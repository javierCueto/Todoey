//
//  MainTabController.swift
//  jToDo
//
//  Created by Javier Cueto on 13/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
    // MARK: -  PROPERTIES
    
    // MARK: -  LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        view.backgroundColor = .white
    }
    
    // MARK: -  API
    

    // MARK: -  HELPERS
    func configureViewControllers(){
        view.backgroundColor = .white
        
        let category = templateNavigationController(unseledtedImage: #imageLiteral(resourceName: "list"), selectedImage: #imageLiteral(resourceName: "list"), rootViewController: CategoryController(), tittle: "Categorias")
        
        let settings = templateNavigationController(unseledtedImage: #imageLiteral(resourceName: "settings"), selectedImage: #imageLiteral(resourceName: "settings"), rootViewController: SettingsController(),tittle: "Configuración")
        
        let search = templateNavigationController(unseledtedImage: #imageLiteral(resourceName: "search"), selectedImage: #imageLiteral(resourceName: "search"), rootViewController: SearchController(),tittle: "Buscar")

        
        viewControllers = [category,search,settings]
        tabBar.tintColor = ACCENT_COLOR
    }
    
    func templateNavigationController(unseledtedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController, tittle: String) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unseledtedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.title = tittle
        nav.navigationBar.tintColor = ACCENT_COLOR
        
        return nav
    }
}
