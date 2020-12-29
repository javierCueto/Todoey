//
//  ItemSetting.swift
//  jToDo
//
//  Created by Javier Cueto on 22/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//
import UIKit

struct ItemSetting {
    let name: String
    let detailName: String?
    let color: UIColor?
    let icon: String?
    let activated: Bool?
    let configGeneral: ConfigSettingsGeneral?

    init(idTheme:Int = 0,
         name: String,
         detailName: String? = nil,
         color: UIColor? = nil,
         icon:String? = nil,
         activated: Bool = false,
         configGeneral: ConfigSettingsGeneral? = nil ){
        self.name = name
        self.detailName = detailName
        self.color = color
        self.icon = icon
        self.activated = activated
        self.configGeneral = configGeneral
    }
}
