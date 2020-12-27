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
        ItemSetting(name: "Blue",color: .systemBlue),
        ItemSetting(name: "Blue 2",color: .blue),
        ItemSetting(name: "Teal",color: .systemTeal),
        ItemSetting(name: "Red",color: .systemRed),
        ItemSetting(name: "Red 2",color: .red),
        ItemSetting(name: "Green",color: .systemGreen),
        ItemSetting(name: "Gray",color: .systemGray),
        ItemSetting(name: "Orange",color: .systemOrange),
        ItemSetting(name: "Purple",color: .systemPurple),
        ItemSetting(name: "Indigo",color: .systemIndigo),
        ItemSetting(name: "Pink",color: .systemPink),
        ItemSetting(name: "Magenta",color: .magenta),
        ItemSetting(name: "Yellow",color: .systemYellow),
    ]
    
    
    let styleModeApp:[ItemSetting] = [
        ItemSetting(name: "System",icon: "gear"),
        ItemSetting(name: "Light mode",icon: "sun.max.fill"),
        ItemSetting(name: "Dark mode",icon: "moon.fill"),
    ]
    
    
    
    let aboutApp = [
        ItemSetting(name: "Aplication",detailName: "\(Bundle.main.appName)"),
        ItemSetting(name: "Version",detailName: "\(Bundle.main.versionNumber)"),
        ItemSetting(name: "Compatibilidad",detailName: "iPhone"),
        ItemSetting(name: "Developer",detailName: "Javier Cueto"),
    ]
    
    let configApp = [
        ItemSetting(name: "Confirmar en eliminar"),
        ItemSetting(name: "Animación en el modal"),
    ]
    
    
    init() {
        dataSettings = [
            Setting(header: "General", items: configApp, typeSetting: .config),
            Setting(header: "Estilo de interfaz", items: styleModeApp, typeSetting: .mode),
            Setting(header: "Tema", items: colorsApp, typeSetting: .theme),
            Setting(header: "Acerca de", items: aboutApp, typeSetting:  .about)
        ]
    }
    
}


