//
//  SettingsController.swift
//  jToDo
//
//  Created by Javier Cueto on 13/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    let manualView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        view.addSubview(manualView)
        manualView.frame = CGRect(x: 10, y: 10, width: 150, height: 150)

        
        
    }
    
    
}
