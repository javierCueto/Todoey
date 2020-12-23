//
//  Configuration.swift
//  jToDo
//
//  Created by Javier Cueto on 23/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

final public class Configuration  {
    var ACCENT_COLOR = UIColor.systemGreen
    
    private init() {}
    public static let shared = Configuration()
}
