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
        
        let category = templateNavigationController(unseledtedImage: UIImage(systemName: "list.dash")!, selectedImage: UIImage(systemName: "list.dash")!, rootViewController: CategoryController(), tittle: "Categorias")
        
        let settings = templateNavigationController(unseledtedImage: UIImage(systemName: "gear")!, selectedImage: UIImage(systemName: "gear")!, rootViewController: SettingsController(),tittle: "Configuración")
        
        let search = templateNavigationController(unseledtedImage: UIImage(systemName: "magnifyingglass")!, selectedImage: UIImage(systemName: "magnifyingglass")!, rootViewController: SearchController(),tittle: "Buscar")

        
        viewControllers = [category,search,settings]
        tabBar.tintColor = ACCENT_COLOR
    }
    
    func templateNavigationController(unseledtedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController, tittle: String) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unseledtedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.title = tittle
        return nav
    }
}