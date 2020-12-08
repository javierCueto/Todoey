//
//  CategoryController.swift
//  Todoey
//
//  Created by Javier Cueto on 20/11/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

class CategoryController: UITableViewController {
   // private var tableView: UITableView!
    let cellId = "cellId"
    let cellSpacingHeight:CGFloat = 0
    
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

