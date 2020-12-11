//
//  CategoryController.swift
//  Todoey
//
//  Created by Javier Cueto on 20/11/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

class CategoryController: UITableViewController {
    let cellId = "cellId"
    let cellSpacingHeight:CGFloat = 0
    private let viewModal = UIView()
    private let addCategoryView = AddCategoryView()
    let viewCardHeight = 300
    
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    func configureTableView(){

       
        tableView = UITableView(frame: self.tableView.frame, style: .insetGrouped)
        //tableView.allowsSelection = false
        tableView.register(CategoryCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none


    }
    
    func configureNavigationBar(){
        navigationItem.title = "Categorias"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(handleAddNewCategory))
        
       
    }
    
    
    func configureAddNewCategory(){
        navigationController?.view.addSubview(viewModal)
        viewModal.alpha = 0
        
        viewModal.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        viewModal.backgroundColor = UIColor.black.withAlphaComponent(0.67)
        
        viewModal.addSubview(self.addCategoryView)
        addCategoryView.delegate = self
        
        addCategoryView.centerX(inView: self.viewModal)
        addCategoryView.focusField()
        addCategoryView.clearField()
        addCategoryView.setDimentions(height: CGFloat(self.viewCardHeight) , width: self.viewModal.frame.width - 40)
        addCategoryView.anchor(top: self.viewModal.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
       

        UIView.animate(withDuration: 0.3) {
            self.viewModal.alpha = 1
            self.addCategoryView.frame.origin.y = CGFloat(self.viewCardHeight)
        }
    }
    
}

extension CategoryController {
    @objc func handleAddNewCategory(){
       
        configureAddNewCategory()
    }
}

extension CategoryController: AddCategoryViewDelegate{
    func didFinishNewCategory(title: String?, emoji: String?, isSaved: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.viewModal.alpha = 0
            self.viewModal.endEditing(true)
        } completion: { (_) in
            self.viewModal.removeFromSuperview()
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
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
 
        }
    }
   
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        5
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

