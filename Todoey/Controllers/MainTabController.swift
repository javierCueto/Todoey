//
//  MainTabController.swift
//  jToDo
//
//  Created by Javier Cueto on 13/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {

    // MARK: -  LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        overrideUserInterfaceStyle = ConfigSettings.shared.STYLE_MODE
    }
    
    // MARK: -  HELPERS
    func configureViewControllers(){
        let imageConfig = UIImage.SymbolConfiguration(weight: .heavy)
        
        let category = templateNavigationController(unseledtedImage: UIImage(systemName: "list.bullet")!, selectedImage:UIImage(systemName: "list.bullet",withConfiguration: imageConfig)!, rootViewController: CategoryController(), tittle: "CategoriesTitle".localized())
        
        let settings = templateNavigationController(unseledtedImage: UIImage(systemName: "gearshape")!, selectedImage:UIImage(systemName: "gearshape" ,withConfiguration: imageConfig)!, rootViewController: SettingsController(),tittle: "SettingsTitle".localized())
        
        let search = templateNavigationController(unseledtedImage: UIImage(systemName: "magnifyingglass")!, selectedImage: UIImage(systemName: "magnifyingglass",withConfiguration: imageConfig)!, rootViewController: SearchController(),tittle: "SearchTitle".localized())

        
        viewControllers = [category,search,settings]
        tabBar.tintColor = ConfigSettings.shared.ACCENT_COLOR
    }
    
    func templateNavigationController(unseledtedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController, tittle: String) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unseledtedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.title = tittle
        nav.navigationBar.tintColor = ConfigSettings.shared.ACCENT_COLOR
        return nav
    }
}
