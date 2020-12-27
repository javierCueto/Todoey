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
    
    private var setings = [Setting]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configureTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setings =  ConfigSettings.shared.dataSettings.dataSettings
        tableview.reloadData()
        print("cargaron los settings de nuevo")
    }
    
    func configUI(){
        navigationItem.title = "Configuración"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    
    func configureTable(){
        
        let tableSize = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        tableview = UITableView(frame: tableSize, style: .insetGrouped)
        view.addSubview(tableview)
        
        tableview.register(SubtitleCell.self, forCellReuseIdentifier: cellId)
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    
    // MARK: -  Action
    
    @objc func handleSwitch(sender: UISwitch){
        if sender.tag == 0{
            print("here")
            ConfigSettings.shared.updateConfirmationDelete(value: sender.isOn)
        }else{
            ConfigSettings.shared.updateAnimation(value: sender.isOn)
        }
    }
    
}


// MARK: -  Table
extension SettingsController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch(setings[indexPath.section].typeSetting){
        
        case .theme:
            let controller = ThemeController()
            
            navigationController?.pushViewController(controller, animated: true)
        case .about:
            break
        case .config:
            break
        case .mode:
            let controller = StyleModeController()
            
            navigationController?.pushViewController(controller, animated: true)
        }
        
        
        
    }
}


extension SettingsController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(setings[section].typeSetting){
        
        case .theme:
            return 1
        case .about:
            return setings[section].items.count
        case .config:
            return setings[section].items.count
        case .mode:
            return 1
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        setings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        switch(setings[indexPath.section].typeSetting){
        
        case .theme:
            cell.textLabel?.text = "Seleccione un tema"
            cell.imageView?.image = UIImage(systemName: "circle.fill")
            cell.accessoryType = .disclosureIndicator
            cell.imageView?.tintColor = ConfigSettings.shared.ACCENT_COLOR
        case .about:
            cell.textLabel?.text = setings[indexPath.section].items[indexPath.row].name
            cell.detailTextLabel?.text = setings[indexPath.section].items[indexPath.row].detailName
        case .config:
            cell.textLabel?.text = setings[indexPath.section].items[indexPath.row].name
            let shareLocationSwitch = UISwitch()
            shareLocationSwitch.tag = indexPath.row
            shareLocationSwitch.isOn = ConfigSettingsGeneral.init(rawValue: indexPath.row)!.description
            shareLocationSwitch.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
            cell.accessoryView = shareLocationSwitch
            cell.selectionStyle = .none
        case .mode:
            cell.textLabel?.text =  ConfigSettings.shared.dataSettings.styleModeApp[ConfigSettings.shared.STYLE_MODE_INDEX].name
            cell.accessoryType = .disclosureIndicator
            cell.imageView?.image = UIImage(systemName: ConfigSettings.shared.dataSettings.styleModeApp[ConfigSettings.shared.STYLE_MODE_INDEX].icon!)
            cell.imageView?.tintColor = ConfigSettings.shared.ACCENT_COLOR
        }
        
        
        
        return cell
    }
    
    // Create a standard header that includes the returned text.
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                    section: Int) -> String? {
        return "\(setings[section].header)"
    }
    
    
    
}

