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
    var ACCENT_COLOR_INDEX: Int
    
    private init() {
        ACCENT_COLOR_INDEX  = UserDefaults.standard.integer(forKey: "Theme")
        ACCENT_COLOR = dataSettings.colorsApp[ACCENT_COLOR_INDEX].color ?? UIColor.systemBlue
    }
    
    func newColor(index: Int){
        UserDefaults.standard.set(index, forKey: "Theme")
        ACCENT_COLOR = dataSettings.colorsApp[index].color ?? UIColor.systemBlue
        ACCENT_COLOR_INDEX = index
    }
    public static let shared = ConfigSettings()
}
