//
//  ThemeController.swift
//  jToDo
//
//  Created by Javier Cueto on 24/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

class ThemeController: UITableViewController {
    let cellThemeID = "cellThemeID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "themeTitle".localized()
        configureTableView()
    }
    
    func configureTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellThemeID)
    }
    
    
    
}

extension ThemeController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ConfigSettings.shared.dataSettings.colorsApp.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellThemeID, for: indexPath)
        cell.textLabel?.text = ConfigSettings.shared.dataSettings.colorsApp[indexPath.row].name
        cell.imageView?.image = UIImage(systemName: "circle.fill")
        cell.imageView?.tintColor = ConfigSettings.shared.dataSettings.colorsApp[indexPath.row].color
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if ConfigSettings.shared.ACCENT_COLOR_INDEX == indexPath.row {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
    
}


extension ThemeController {
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ConfigSettings.shared.newColor(index: indexPath.row)
        self.tabBarController?.tabBar.tintColor = ConfigSettings.shared.ACCENT_COLOR
        UINavigationBar.appearance().tintColor = ConfigSettings.shared.ACCENT_COLOR
        navigationController?.navigationBar.tintColor = ConfigSettings.shared.ACCENT_COLOR
        self.navigationController?.popViewController(animated: true)
    }
    
}
