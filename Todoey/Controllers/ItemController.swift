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
    let cellIDItem = "cellIDItem"
    private let addItemView = ActionModalView(typeObject: .item, placeHolder: "PlaceHolderTask".localized())
    private let confirmModalView = ConfirmModalView(title: "ConfirmTitleModal".localized())
    private lazy var viewHeight = view.frame.height
    private lazy var viewWidth = view.frame.width
    
    // MARK: -  PROPERTIES
    var itemArray = [Item]()
    
    var selectedCategory : Category? 
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // MARK: -  LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        addItemView.delegateItem = self
        confirmModalView.delegate = self
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadItems()
    }
    
    // MARK: -  HELPERS
    func configureUI(){
        navigationItem.title = "\(selectedCategory?.emoji ?? "") \(selectedCategory?.name ?? "")"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(handleNewItem))
    }
    
    func configureTableView(){
        tableView.register(ItemCell.self, forCellReuseIdentifier: cellIDItem)
        tableView.separatorStyle = .none
    }
    
    
    
    // MARK: -  FETCH
    func loadItems(){
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        request.predicate = categoryPredicate
        //request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        do{
            itemArray = try contex.fetch(request)
        }catch{
            print("Erro obteniendo context \(error) :)")
        }
        
        tableView.reloadData()
    }
    
    func callActionModalView(withCategory category: Category? , withActionCategory actionCategory: ActionModal){
        
        if ConfigSettings.shared.MODAL_ANIMATION {
            callActionModalViewAnimation(withCategory: category, withActionCategory: actionCategory)
        }else{
            UIView.performWithoutAnimation {
                callActionModalViewAnimation(withCategory: category, withActionCategory: actionCategory)
            }
        }
        
        
    }
    
    func callActionModalViewAnimation(withCategory category: Category? , withActionCategory actionCategory: ActionModal){
        navigationController?.view.addSubview(addItemView)
        addItemView.action = actionCategory
        addItemView.category = category
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
    
    
    // MARK: -  Crud
    
    func deleteItem(indexPath: IndexPath){
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

extension ItemController: ConfirmModalViewDelegate {
    func didFinishConfirm(indexPath: IndexPath, isDeleted: Bool) {
        self.confirmModalView.dismiss()
        if isDeleted {
            deleteItem(indexPath: indexPath)
        }
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
            
            newItem.name = title
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            newItem.createdAt = Date()
            
            //self.itemArray.insert(newItem, at: 0)
            self.itemArray.append(newItem)
            
            
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
        print("table reload__________________________\(itemArray[indexPath.row].done)")
        
    }
    
    
}


// MARK: -  UITableViewDataSource
extension ItemController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIDItem, for: indexPath) as! ItemCell
        cell.model = itemArray[indexPath.row]
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            if ConfigSettings.shared.CONFIRMATION_DELETE {
                self.tabBarController?.view.addSubview(self.confirmModalView)
                self.confirmModalView.indexPath = indexPath
                self.confirmModalView.nameToDelete = self.itemArray[indexPath.row].name ?? ""
                let frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: self.viewHeight)
                self.confirmModalView.frame = frame
                
            }else{
                deleteItem(indexPath: indexPath)
            }
            
            
            
        }
    }
}
