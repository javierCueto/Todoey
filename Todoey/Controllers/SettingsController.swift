//
//  SettingsController.swift
//  jToDo
//
//  Created by Javier Cueto on 13/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    private var tableview: UITableView!
    private let cellId = "cellID"
    
    private let setings: [Setting] = [
     
        Setting(header: "Tema", items: colorsApp)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configureTable()
    }
    
    func configUI(){
        navigationItem.title = "Configuración"
    }
    
    func configureTable(){
        
        let tableSize = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        tableview = UITableView(frame: tableSize, style: .insetGrouped)
        view.addSubview(tableview)
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableview.delegate = self
        tableview.dataSource = self
    }
    
}


// MARK: -  Table
extension SettingsController: UITableViewDelegate{
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Configuration.shared.ACCENT_COLOR = setings[indexPath.section].items[indexPath.row].color

        self.tabBarController?.tabBar.tintColor = Configuration.shared.ACCENT_COLOR
        UINavigationBar.appearance().tintColor = Configuration.shared.ACCENT_COLOR
    }
}


extension SettingsController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setings[section].items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        setings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = setings[indexPath.section].items[indexPath.row].name
        cell.imageView?.image = UIImage(systemName: "square.fill")
        cell.imageView?.tintColor = setings[indexPath.section].items[indexPath.row].color
        return cell
    }
    
    // Create a standard header that includes the returned text.
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        return "\(setings[section].header)"
    }

    
    
}

