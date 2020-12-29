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
    // MARK: -  Properties
    private let cellId = "cellId"
    private let cellSpacingHeight:CGFloat = 20
    private let addCategoryView = ActionModalView(typeObject: .category , placeHolder: "Nombre de la categoria")
    private let confirmModalView = ConfirmModalView(title: "Esta seguro?")
    private lazy var viewHeight = view.frame.height
    private lazy var viewWidth = view.frame.width
    
    
    private var categories = [Category]()
    
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // MARK: -  lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        addCategoryView.delegate = self
        confirmModalView.delegate = self
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCategories()
    }
    
    
    // MARK: -  helpers
    func loadCategories(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "updatedAt", ascending: false)]
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
        // navigationItem.rightBarButtonItem?.tintColor = ACCENT_COLOR
        
        
    }
    
    
    
    func callCategoryView(withCategory category: Category? , withActionCategory actionCategory: ActionModal){
        
        if ConfigSettings.shared.MODAL_ANIMATION {
            callCategoryViewAnimation(withCategory: category, withActionCategory: actionCategory)
        }else{
            UIView.performWithoutAnimation {
                callCategoryViewAnimation(withCategory: category, withActionCategory: actionCategory)
            }
        }
        
        
    }
    
    func callCategoryViewAnimation(withCategory category: Category? , withActionCategory actionCategory: ActionModal){
        navigationController?.view.addSubview(addCategoryView)
        addCategoryView.action = actionCategory
        addCategoryView.category = category
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        print(frame)
        addCategoryView.frame = frame
    }
    
    // MARK: -  Crud
    
    func deleteCategory(indexPath: IndexPath){
        self.contex.delete(self.categories[indexPath.section])
        self.categories.remove(at: indexPath.section)
        
        do{
            try self.contex.save()
        }catch{
            print("Erro saving category \(error) :)")
        }
        
        let indexSet = IndexSet(arrayLiteral: indexPath.section)
        
        tableView.beginUpdates()
        tableView.deleteSections(indexSet, with: .left)
        tableView.endUpdates()

    }
}

extension CategoryController {
    @objc func handleAddNewCategory(){
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        callCategoryView(withCategory: nil, withActionCategory: .new)
    }
}

extension CategoryController: ConfirmModalViewDelegate {
    func didFinishConfirm(indexPath: IndexPath, isDeleted: Bool) {
        self.confirmModalView.dismiss()
        if isDeleted {
            deleteCategory(indexPath: indexPath)
        }else{
            //self.tableView.reloadData()
        }
        
    }
    
    
}
extension CategoryController: ActionModalViewDelegate{
    
    
    func didFinishCategory(title: String?, emoji: String?,categoryAction: ActionModal) {
        self.addCategoryView.dismiss()
        switch categoryAction {
        
        case .edit:
            self.addCategoryView.category?.emoji = String(emoji?.prefix(1) ?? "❓")
            self.addCategoryView.category?.name = title
            self.addCategoryView.category?.updatedAt = Date()
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
            newCategory.createdAt = Date()
            newCategory.updatedAt = Date()
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
        let items = categories[indexPath.section].items?.filtered(
            using: NSPredicate(format: "done = false")
        )
        cell.numberItemsLabel.text = "Tareas faltantes \(items?.count ?? 0)"
        return cell
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        
        
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue)  in
            
            if ConfigSettings.shared.CONFIRMATION_DELETE {
                //self.tableView.reloadData()
                let indexSet = IndexSet(arrayLiteral: indexPath.section)
                self.tableView.beginUpdates()
                self.tableView.reloadSections(indexSet, with: .right)
                self.tableView.endUpdates()
                self.tabBarController?.view.addSubview(self.confirmModalView)
                self.confirmModalView.indexPath = indexPath
                self.confirmModalView.nameToDelete = self.categories[indexPath.section].name ?? ""
                let frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: self.viewHeight)
                self.confirmModalView.frame = frame
                
            }else{
                self.deleteCategory(indexPath: indexPath)
            }
            
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
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        return headerView
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = ItemController()
        controller.selectedCategory = categories[indexPath.section]
        navigationController?.pushViewController(controller, animated: true)
        categories[indexPath.section].updatedAt = Date()
        do{
            try self.contex.save()
        }catch{
            print("Erro saving category \(error) :)")
        }
    }
    
    
    
}

