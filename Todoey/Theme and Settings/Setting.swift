//
//  Setting.swift
//  jToDo
//
//  Created by Javier Cueto on 22/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

enum TypeSetting {
    case theme
    case about
    case config
    case mode
}

struct Setting {
    let header: String
    let items: [ItemSetting]
    let typeSetting: TypeSetting
}

