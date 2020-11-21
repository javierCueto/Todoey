//
//  CategoryController.swift
//  Todoey
//
//  Created by Javier Cueto on 20/11/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

class CategoryController: UIViewController {
    private var tableView = UITableView()
    let cellId = "cellId"
    let cellSpacingHeight:CGFloat = 0
    
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
    }
    
    
    func configureTableView(){
        tableView = UITableView(frame: CGRect(x: 0 , y: 0, width: view.frame.width, height: view.frame.height), style: .insetGrouped)
        tableView.register(CategoryCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        

        //tableView.backgroundColor = .lightGray
        //tableView.register(LocationCell.self, forCellReuseIdentifier: reuseIndentifier)
        //tableView.rowHeight = 60
        //tableView.frame = CGRect(x: 0 , y: 0, width: view.frame.width, height: view.frame.height)
        
        view.addSubview(tableView)
    }
    
    func configureNavigationBar(){
        navigationItem.title = "Categorias"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

extension CategoryController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CategoryCell
        // note that indexPath.section is used rather than indexPath.row


        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
 
        }
    }
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    
    // Set the spacing between sections
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return cellSpacingHeight
       }
    
    // Make the background color show through
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
           // headerView.anchor(height: 5)
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    
    
    
    
}
