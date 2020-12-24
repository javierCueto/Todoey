//
//  DataSettings.swift
//  jToDo
//
//  Created by Javier Cueto on 22/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

//Colors
/*
 private let settingsColor:
 
 Setting(header: "Tema", items: [ItemSetting(name: "Rojo"), ItemSetting(name: "Verde")]),
 Setting(header: "Tema", items: [ItemSetting(name: "Rojo"), ItemSetting(name: "Verde")])
 */

import UIKit


struct DataSettings {
    var dataSettings: [Setting] = [Setting]()
    
    let colorsApp:[ItemSetting] = [
        ItemSetting(idTheme: 0, name: "Blue",color: .systemBlue),
        ItemSetting(idTheme: 1, name: "Red",color: .systemRed),
        ItemSetting(idTheme: 2, name: "Green",color: .systemGreen),
        ItemSetting(idTheme: 3, name: "Pink",color: .systemPink),
        ItemSetting(idTheme: 4, name: "Teal",color: .systemTeal),
        ItemSetting(idTheme: 5, name: "Gray",color: .systemGray),
        ItemSetting(idTheme: 6, name: "Orange",color: .systemOrange),
        ItemSetting(idTheme: 7, name: "Purple",color: .systemPurple),
        ItemSetting(idTheme: 8, name: "Indigo",color: .systemIndigo),
        ItemSetting(idTheme: 9, name: "Yellow",color: .systemYellow),
    ]
    let aboutApp = [
        ItemSetting(name: "Aplication",detailName: "\(Bundle.main.appName)"),
        ItemSetting(name: "Version",detailName: "\(Bundle.main.versionNumber)"),
        ItemSetting(name: "Compatibilidad",detailName: "iPhone"),
        ItemSetting(name: "Developer",detailName: "Javier Cueto"),
    ]
    
    init() {
        dataSettings = [
            Setting(header: "Tema", items: colorsApp, typeSetting: .theme),
            Setting(header: "Acerca de", items: aboutApp, typeSetting:  .about)
        ]
    }
    
}


