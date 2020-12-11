//
//  ViewController.swift
//  Todoey
//
//  Created by José Javier Cueto Mejía on 27/11/19.
//  Copyright © 2019 José Javier Cueto Mejía. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    

    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
            
        //        print(dataFilePath)

    }
    
    
    //MARK: - full table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title

        cell.accessoryType = item.done  ? .checkmark : .none
        
        print("datos cargados")
        
        return cell
    }
    
    
    //MARK: - delegate cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    //MARK: - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Añadir nuevo ToDo", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Añadir item", style: .default) { (action) in
            

            let newItem = Item(context: self.contex)
            
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
            self.itemArray.append(newItem)
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Crear nuevo"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
    }
    
    func saveItems(){

          do{
            try contex.save()
          }catch{
              print("Erro saving context \(error) :)")
          }
        
          self.tableView.reloadData()
    }
    
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





//MARK: - Search Bar methods
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate  = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors  = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
            
             
        }
    }
}

