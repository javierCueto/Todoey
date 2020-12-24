//
//  Configuration.swift
//  jToDo
//
//  Created by Javier Cueto on 23/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

final public class ConfigSettings  {
    let dataSettings = DataSettings()
    var ACCENT_COLOR: UIColor
    
    private init() {
        ACCENT_COLOR = dataSettings.colorsApp[UserDefaults.standard.integer(forKey: "Theme")].color ?? UIColor.systemBlue
        print("se inicio la configuracion")
    }
    public static let shared = ConfigSettings()
}
