//
//  Search.swift
//  jToDo
//
//  Created by Javier Cueto on 13/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit
import CoreData

class SearchController: UITableViewController{
    // MARK: -  Properties
    private let cellId = "cellId"
    private let searchController = UISearchController(searchResultsController: nil)
    private var categories = [Category]()
    private var filterCategories = [Category]()
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: -  LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        configureSearchController()

    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCategories()
    }
    
    
    // MARK: -  HELPERS
    func configureUI(){
        navigationItem.title = "Buscar categoria"
        //navigationItem.largeTitleDisplayMode = .never

    }
    
    func configureTableView(){

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)

    }
    
    func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
    
    // MARK: -  FETCH
    func loadCategories(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        do{
            categories = try contex.fetch(request)

        }catch{
            print("Erro obteniendo context \(error) :)")
        }
        tableView.reloadData()
        
    }
}


// MARK: -  UITableViewDataSource
extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = filterCategories[indexPath.row].name
       
        let items = filterCategories[indexPath.section].items?.filtered(
            using: NSPredicate(format: "done = false")
         )
        
        cell.detailTextLabel?.text = "\(items?.count ?? 0)"

        return cell
    }
    
}

extension SearchController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {return}
        
        filterCategories = categories.filter({
            $0.name!.contains(searchText) || $0.name!.lowercased().contains(searchText)
        })
        
        print(filterCategories)
        self.tableView.reloadData()
    }
    
    
}
