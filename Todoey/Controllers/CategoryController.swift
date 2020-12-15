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
    private let cellSpacingHeight:CGFloat = 8
    private let addCategoryView = ActionCategoryView()
    private var imageEmpty: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "empty").withRenderingMode(.alwaysTemplate))
        image.contentMode = .scaleAspectFit
        image.tintColor = ACCENT_COLOR
        return image
    }()
    
    
    private var categories = [Category]()
    
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        loadCategories()
        addCategoryView.delegate = self
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(categories.count < 1)
        /*if categories.count < 1 {
         imageEmpty.setDimentions(height: 300, width: 300)
         tableView.backgroundView = imageEmpty
         //tableView.addSubview(imageEmpty)
         //imageEmpty.center = tableView.center
         //imageEmpty.centerX(inView: tableView)
         //imageEmpty.centerY(inView: tableView)
         
         //print(tableView.frame)
         /* imageEmpty.anchor(top: tableView.topAnchor, paddingTop: 90, width: 300, height: 300)*/
         }else {
         imageEmpty.removeFromSuperview()
         }*/
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
        //navigationItem.rightBarButtonItem?.tintColor = ACCENT_COLOR
        
        
    }
    
    
    
    func callCategoryView(withCategory category: Category? , withActionCategory actionCategory: CategoryAction){
        navigationController?.view.addSubview(addCategoryView)
        addCategoryView.categoryAction = actionCategory
        addCategoryView.category = category
        print("nuevo aaction \(addCategoryView.categoryAction.description)")
        addCategoryView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
}

extension CategoryController {
    @objc func handleAddNewCategory(){
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
        
        callCategoryView(withCategory: nil, withActionCategory: .new)
    }
}

extension CategoryController: AddCategoryViewDelegate{
    
    func didFinishCategory(title: String?, emoji: String?,categoryAction: CategoryAction) {
        self.addCategoryView.dismiss()
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
            print("edition")
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
            print("new")
        case .close:
            print("close")
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
            
            self.contex.delete(self.categories[indexPath.section])
            self.categories.remove(at: indexPath.section )
            
            do{
                try self.contex.save()
            }catch{
                print("Erro saving category \(error) :)")
            }
            
            let indexSet = IndexSet(arrayLiteral: indexPath.section)
            tableView.deleteSections(indexSet, with: .automatic)
            
        }
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, boolValue) in
            
            self.callCategoryView(withCategory: self.categories[indexPath.section], withActionCategory: .edit)
            
            
        }
        
        edit.backgroundColor = UIColor.systemBlue
        
        let swipeActions = UISwipeActionsConfiguration(actions: [delete,edit])
        
        return swipeActions
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        
        
        return categories.count
    }
    
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // Make the background color show through
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return cellSpacingHeight + 2
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        return headerView
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let controller = ItemController()
        controller.selectedCategory = categories[indexPath.section]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
}

