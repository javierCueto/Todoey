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
        configureTableView()
    }
    
    func configureTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellThemeID)
    }
    
    
    
}

extension ThemeController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorsApp.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellThemeID, for: indexPath)
        cell.textLabel?.text = colorsApp[indexPath.row].name
        cell.imageView?.image = UIImage(systemName: "circle.fill")
        cell.imageView?.tintColor = colorsApp[indexPath.row].color
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if UserDefaults.standard.integer(forKey: "Theme") == indexPath.row {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
    
}


extension ThemeController {
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newColor = colorsApp[indexPath.row].idTheme
        UserDefaults.standard.set(newColor, forKey: "Theme")
        ThemeColor.shared.ACCENT_COLOR = colorsApp[newColor].color
        self.tabBarController?.tabBar.tintColor = ThemeColor.shared.ACCENT_COLOR
        UINavigationBar.appearance().tintColor = ThemeColor.shared.ACCENT_COLOR
        navigationController?.navigationBar.tintColor = ThemeColor.shared.ACCENT_COLOR
        
        
        self.navigationController?.popViewController(animated: true)
    }
}
