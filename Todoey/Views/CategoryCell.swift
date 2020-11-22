//
//  CategoryCell.swift
//  jToDo
//
//  Created by Javier Cueto on 20/11/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    
   private let circleView: UIView = {
        let view = UIView()
        view.setDimentions(height: 30, width: 30)
        view.backgroundColor = .blue
        return view
    }()


        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(circleView)
        
        circleView.anchor(top: topAnchor,left: leftAnchor, bottom: bottomAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10)
        circleView.centerY(inView: self)
        circleView.layer.cornerRadius = 30/2
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor


    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
