//
//  CategoryController.swift
//  Todoey
//
//  Created by Javier Cueto on 20/11/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

class CategoryController: UIViewController {
    private let tableView = UITableView()
    let cellId = "cellId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
    }
    
    
    func configureTableView(){
        tableView.register(CategoryCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.register(LocationCell.self, forCellReuseIdentifier: reuseIndentifier)
        tableView.rowHeight = 60
        tableView.frame = CGRect(x: 0 , y: 0, width: view.frame.width, height: view.frame.height)
        
        view.addSubview(tableView)
    }
    
    func configureNavigationBar(){
        navigationItem.title = "Categorias"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

extension CategoryController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CategoryCell
        
        cell.productNameLabel.text = "prueba de lista"
        return cell
    }
    
    
}
