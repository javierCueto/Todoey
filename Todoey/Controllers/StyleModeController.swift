//
//  StyleModeController.swift
//  jToDo
//
//  Created by Javier Cueto on 27/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//


import UIKit

class StyleModeController: UITableViewController {
    let cellThemeID = "cellThemeID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        navigationItem.title = "Estilo de interfaz"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellThemeID)
    }
    
    
    
}

extension StyleModeController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ConfigSettings.shared.dataSettings.styleModeApp.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellThemeID, for: indexPath)
        cell.textLabel?.text = ConfigSettings.shared.dataSettings.styleModeApp[indexPath.row].name
        cell.imageView?.image = UIImage(systemName: ConfigSettings.shared.dataSettings.styleModeApp[indexPath.row].icon!)
        cell.imageView?.tintColor = ConfigSettings.shared.ACCENT_COLOR
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if ConfigSettings.shared.STYLE_MODE_INDEX == indexPath.row {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
    
}


extension StyleModeController {
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ConfigSettings.shared.newStyleMode(index: indexPath.row)
        self.tabBarController?.overrideUserInterfaceStyle = ConfigSettings.shared.STYLE_MODE
        self.navigationController?.popViewController(animated: true)
    }
    
}
