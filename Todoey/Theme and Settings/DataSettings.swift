//
//  DataSettings.swift
//  jToDo
//
//  Created by Javier Cueto on 22/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//


import UIKit


struct DataSettings {
    var dataSettings: [Setting] = [Setting]()
    
    //Dont delete any color. DON'T
    let colorsApp:[ItemSetting] = [
        ItemSetting(name: "Blue".localized(),color: .systemBlue),
        ItemSetting(name: "Blue2".localized(),color: .blue),
        ItemSetting(name: "Teal".localized(),color: .systemTeal),
        ItemSetting(name: "Red".localized(),color: .systemRed),
        ItemSetting(name: "Red2".localized(),color: .red),
        ItemSetting(name: "Green".localized(),color: .systemGreen),
        ItemSetting(name: "Gray".localized(),color: .systemGray),
        ItemSetting(name: "Orange".localized(),color: .systemOrange),
        ItemSetting(name: "Purple".localized(),color: .systemPurple),
        ItemSetting(name: "Indigo".localized(),color: .systemIndigo),
        ItemSetting(name: "Pink".localized(),color: .systemPink),
        ItemSetting(name: "Magenta".localized(),color: .magenta),
        ItemSetting(name: "Yellow".localized(),color: .systemYellow),
    ]


    let styleModeApp:[ItemSetting] = [
        ItemSetting(name: "System".localized(),icon: "gear"),
        ItemSetting(name: "LightMode".localized(),icon: "sun.max.fill"),
        ItemSetting(name: "DarkMode".localized(),icon: "moon.fill"),
    ]
    
    
    
    let aboutApp = [
        ItemSetting(name: "appName".localized(),detailName: "\(Bundle.main.appName)"),
        ItemSetting(name: "Version".localized(),detailName: "\(Bundle.main.versionNumber)"),
        ItemSetting(name: "Compatibility".localized(),detailName: "iPhone"),
        ItemSetting(name: "Developer".localized(),detailName: "Javier Cueto 👨🏽‍💻"),
    ]
    
    let configApp = [
        ItemSetting(name: "AnimationInModal".localized(),configGeneral:  .modalAnimation),
        ItemSetting(name: "ConfirmToDelete".localized(),configGeneral:  .confirmationDelete),
        
    ]
    
    
    init() {
        dataSettings = [
            Setting(header: "General".localized(), items: configApp, typeSetting: .config),
            Setting(header: "InterfaceStyle".localized(), items: styleModeApp, typeSetting: .mode),
            Setting(header: "Theme".localized(), items: colorsApp, typeSetting: .theme),
            Setting(header: "About".localized(), items: aboutApp, typeSetting:  .about)
        ]
    }
    
}


