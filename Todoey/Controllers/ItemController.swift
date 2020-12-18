//
//  ItemController.swift
//  jToDo
//
//  Created by Javier Cueto on 14/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit
import CoreData

class ItemController: UITableViewController {
    let reuserIdentifier = "cellItem"
    private let addItemView = ActionModalView(typeObject: .item, placeHolder: "Nombre de la tarea")
    
    // MARK: -  PROPERTIES
    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // MARK: -  LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        addItemView.delegateItem = self
        
    }
    
    // MARK: -  HELPERS
    func configureUI(){
        navigationItem.title = "\(selectedCategory?.emoji ?? "") \(selectedCategory?.name ?? "")"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(handleNewItem))
    }
    
    func configureTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuserIdentifier)
        // tableView.separatorStyle = .none
    }
    
    
    
    // MARK: -  FETCH
    func loadItems(){
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        request.predicate = categoryPredicate
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        do{
            itemArray = try contex.fetch(request)
        }catch{
            print("Erro obteniendo context \(error) :)")
        }
        
        tableView.reloadData()
    }
    
    func callActionModalView(withCategory category: Category? , withActionCategory actionCategory: ActionModal){
        navigationController?.view.addSubview(addItemView)
        addItemView.action = actionCategory
        addItemView.category = category
        print("nuevo aaction \(addItemView.action.description)")
        addItemView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    @objc func handleNewItem(){
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        callActionModalView(withCategory: nil, withActionCategory: .new)
    }
    
    func saveItems(){
        
        do{
            try contex.save()
        }catch{
            print("Erro saving context \(error) :)")
        }
        
        self.tableView.reloadData()
    }
    
    
}

extension ItemController: ActionItemModalViewDelegate{
    func didFinishItem(title: String?, itemAction: ActionModal) {
        self.addItemView.dismiss()
        
        switch itemAction {
        
        case .edit:
            break
        case .new:
            let newItem = Item(context: self.contex)
            
            newItem.title = title
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            newItem.createdAt = Date()
            
            self.itemArray.insert(newItem, at: 0)
            
            
            self.saveItems()
        case .close:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done.toggle()
        itemArray[indexPath.row].updatedAt = Date()
        do{
            try self.contex.save()
        }catch{
            print("Erro saving category \(error) :)")
        }
        
        self.tableView.reloadData()
        print(itemArray[indexPath.row].done)
        
    }
    
    
}


// MARK: -  UITableViewDataSource
extension ItemController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuserIdentifier, for: indexPath)
        if itemArray[indexPath.row].done {
            cell.textLabel?.text = itemArray[indexPath.row].title
            cell.textLabel?.addStrike()
        }else {
            cell.textLabel?.removeStrike()
            cell.textLabel?.text = itemArray[indexPath.row].title
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.contex.delete(self.itemArray[indexPath.row])
            do{
                try self.contex.save()
            }catch{
                print("Erro saving category \(error) :)")
            }
            self.itemArray.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }
}
