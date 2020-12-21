//
//  CategoryViewController.swift
//  Todoey
//
//  Created by José Javier Cueto Mejía on 01/12/19.
//  Copyright © 2019 José Javier Cueto Mejía. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categories = [Category]()
    
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
      
    }

    //MARK: - tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        
        
        cell.textLabel?.text = categories[indexPath.row].name
       
        
        print("datos cargados")
        
        return cell
    }
    
    //MARK: - tableview delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    //MARK: - data manipulation
    
    func saveCategories(){
        
          do{
            try contex.save()
          }catch{
              print("Erro saving category \(error) :)")
          }
        
          tableView.reloadData()
    }
    
    func loadCategories(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do{
          categories = try contex.fetch(request)
           
        }catch{
           print("Erro obteniendo context \(error) :)")
        }
      
        tableView.reloadData()
           
    }
    
    
    //MARK: - new categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
                
        let alert = UIAlertController(title: "Añadir nueva categoria", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Añadir", style: .default) { (action) in
            

            let newCategory = Category(context: self.contex)
            
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            
            self.saveCategories()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Crear nuevo"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
    }
    
    
    
}
