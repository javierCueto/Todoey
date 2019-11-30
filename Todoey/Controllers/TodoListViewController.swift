//
//  ViewController.swift
//  Todoey
//
//  Created by José Javier Cueto Mejía on 27/11/19.
//  Copyright © 2019 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        print(dataFilePath)

        
        loadItems()
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
            let newItem = Item()
            newItem.title = textField.text!
            
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
        let encoder = PropertyListEncoder()
          do{
              let data = try encoder.encode(itemArray)
              try data.write(to: self.dataFilePath!)
          }catch{
              print("Erro encontrado, \(error) :)")
          }
        
          self.tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Un error encontrado al extraer los datos \(error)")
            }
        }
    }
}

