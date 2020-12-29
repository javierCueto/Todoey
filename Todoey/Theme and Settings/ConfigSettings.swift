//
//  Configuration.swift
//  jToDo
//
//  Created by Javier Cueto on 23/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

enum ConfigSettingsGeneral{
    case confirmationDelete
    case modalAnimation
    
    
    var description: Bool {
        switch self {
        
        case .confirmationDelete:
            return ConfigSettings.shared.CONFIRMATION_DELETE
        case .modalAnimation:
            return  ConfigSettings.shared.MODAL_ANIMATION
        }
    }
}

final public class ConfigSettings  {
    let dataSettings = DataSettings()
    var ACCENT_COLOR: UIColor
    var ACCENT_COLOR_INDEX: Int
    
    var STYLE_MODE: UIUserInterfaceStyle
    var STYLE_MODE_INDEX: Int
    
    
    var MODAL_ANIMATION: Bool
    var CONFIRMATION_DELETE: Bool
    
    private init() {
        ACCENT_COLOR_INDEX  = UserDefaults.standard.integer(forKey: "Theme")
        ACCENT_COLOR = dataSettings.colorsApp[ACCENT_COLOR_INDEX].color ?? UIColor.systemBlue
        
        STYLE_MODE_INDEX  = UserDefaults.standard.integer(forKey: "StyleMode")
        STYLE_MODE = UIUserInterfaceStyle.init(rawValue: STYLE_MODE_INDEX) ?? UIUserInterfaceStyle.unspecified
        
        MODAL_ANIMATION  = UserDefaults.standard.bool(forKey: "ModalAnimation")
    
        CONFIRMATION_DELETE  = UserDefaults.standard.bool(forKey: "ConfimationDelete")

    }
    
    func newColor(index: Int){
        UserDefaults.standard.set(index, forKey: "Theme")
        ACCENT_COLOR = dataSettings.colorsApp[index].color ?? UIColor.systemBlue
        ACCENT_COLOR_INDEX = index
    }
    
    func newStyleMode(index: Int){
        UserDefaults.standard.set(index, forKey: "StyleMode")
        STYLE_MODE = UIUserInterfaceStyle.init(rawValue: index) ?? UIUserInterfaceStyle.unspecified
        STYLE_MODE_INDEX = index
    }
    
    
    func updateConfigGeneral(index: Int,value: Bool){
        guard let config = dataSettings.configApp[index].configGeneral else {return}
        switch config {

        case .confirmationDelete:
            UserDefaults.standard.set(value, forKey: "ConfimationDelete")
            CONFIRMATION_DELETE = value
            print(CONFIRMATION_DELETE)
        case .modalAnimation:
            UserDefaults.standard.set(value, forKey: "ModalAnimation")
            MODAL_ANIMATION = value
        }


    }
    

    
    public static let shared = ConfigSettings()
}
