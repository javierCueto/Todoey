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
        
    }
    
    // MARK: -  HELPERS
    func configureUI(){
        navigationItem.title = "\(selectedCategory?.emoji ?? "") \(selectedCategory?.name ?? "")"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(handleNewItem))
    }
    
    func configureTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuserIdentifier)
        tableView.separatorStyle = .none
    }
    
    
    @objc func handleNewItem(){
        
    }
    
    // MARK: -  FETCH
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
        }else{
            request.predicate = categoryPredicate
        }
        
        do{
            itemArray = try contex.fetch(request)
        }catch{
            print("Erro obteniendo context \(error) :)")
        }
        
        tableView.reloadData()
    }
    
}


// MARK: -  UITableViewDataSource
extension ItemController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuserIdentifier, for: indexPath)
        cell.textLabel?.text = "prueba"
        print(indexPath.row % 2)
        cell.backgroundColor = indexPath.row % 2 == 0 ? .systemGray6 : .systemBackground
        return cell
    }
}
