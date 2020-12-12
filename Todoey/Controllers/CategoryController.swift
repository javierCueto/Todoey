//
//  CategoryController.swift
//  Todoey
//
//  Created by Javier Cueto on 20/11/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit
import CoreData

class CategoryController: UITableViewController {
    private let cellId = "cellId"
    private let cellSpacingHeight:CGFloat = 0
    private let viewModal = UIView()
    private let addCategoryView = ActionCategoryView()
    private let viewCardHeight = 300
    
    private var categories = [Category]()
    
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
        loadCategories()
        addCategoryView.delegate = self
       
    }
    
    func loadCategories(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createAt", ascending: false)]
        do{
          categories = try contex.fetch(request)
        }catch{
           print("Erro obteniendo context \(error) :)")
        }
        tableView.reloadData()
           
    }

    func configureTableView(){

       
        tableView = UITableView(frame: self.tableView.frame, style: .insetGrouped)
        tableView.register(CategoryCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none



    }
    
    func configureNavigationBar(){
        navigationItem.title = "Categorias"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(handleAddNewCategory))
        
       
    }
    
    
    func callCategoryView(withCategory category: Category? , withActionCategory actionCategory: CategoryAction){
        
        navigationController?.view.addSubview(viewModal)
        viewModal.alpha = 0
        viewModal.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        viewModal.backgroundColor = UIColor.black.withAlphaComponent(0.67)
        
        viewModal.addSubview(self.addCategoryView)
        addCategoryView.centerX(inView: self.viewModal)
        addCategoryView.focusField()
        addCategoryView.clearField()
        addCategoryView.setDimentions(height: CGFloat(self.viewCardHeight) , width: self.viewModal.frame.width - 40)
        addCategoryView.anchor(top: self.viewModal.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        addCategoryView.categoryAction = actionCategory
        addCategoryView.category = category
       
        

        UIView.animate(withDuration: 0.3) {
            self.viewModal.alpha = 1
            self.addCategoryView.frame.origin.y = CGFloat(self.viewCardHeight)
        }
    }
    
}

extension CategoryController {
    @objc func handleAddNewCategory(){
       
        callCategoryView(withCategory: nil, withActionCategory: .new)
    }
}

extension CategoryController: AddCategoryViewDelegate{
    
    func didFinishCategory(title: String?, emoji: String?,categoryAction: CategoryAction) {
        UIView.animate(withDuration: 0.3) {
            self.viewModal.alpha = 0
            self.viewModal.endEditing(true)
        } completion: { (_) in
            self.viewModal.removeFromSuperview()
            
            
            switch categoryAction {
             
            case .edit:
                self.addCategoryView.category?.emoji = String(emoji?.prefix(1) ?? "❓")
                self.addCategoryView.category?.name = title
                self.addCategoryView.category?.updateAt = Date()
                do{
                  try self.contex.save()
                }catch{
                    print("Erro saving category \(error) :)")
                }
                
                UIView.transition(with: self.tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {self.tableView.reloadData()}, completion: nil)

            case .new:
                let newCategory = Category(context: self.contex)
                newCategory.name = title
                newCategory.emoji = String(emoji?.prefix(1) ?? "❓")
                newCategory.createAt = Date()
                newCategory.updateAt = Date()
                self.categories.insert(newCategory, at: 0)
                do{
                  try self.contex.save()
                }catch{
                    print("Erro saving category \(error) :)")
                }
                self.tableView.reloadData()
            case .close:
                print("close")
            }

            
            
            
   
               
        }
        
        
        
        
    }
}


extension CategoryController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.accessoryType = .disclosureIndicator
        cell.model = categories[indexPath.section]
        return cell
    }
    
    
    
  
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        
    
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue)  in
        }

        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, boolValue) in

            self.callCategoryView(withCategory: self.categories[indexPath.section], withActionCategory: .edit)
            
            
        }

        edit.backgroundColor = UIColor.systemBlue

        let swipeActions = UISwipeActionsConfiguration(actions: [delete,edit])

        return swipeActions
    }
    

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        categories.count
    }
    
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return cellSpacingHeight
       }
    
    // Make the background color show through
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
           // headerView.anchor(height: 5)
        headerView.backgroundColor = UIColor.clear
            return headerView
        }
    
    
    
    
}

