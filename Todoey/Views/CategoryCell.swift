//
//  CategoryCell.swift
//  jToDo
//
//  Created by Javier Cueto on 20/11/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    var model: Category? {
        didSet{
            guard let model = self.model else {return}
            emoji.text = model.emoji
            categoryNameLabel.text = model.name
            numberItemsLabel.text = "99"//"\(model.items?.count ?? 100)"
        }
    }
    
    private let emoji: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.baselineAdjustment = .alignCenters
        return label
    }()
    
    
    private let categoryNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.baselineAdjustment = .alignCenters
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let numberItemsLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = ACCENT_COLOR
        return label
    }()
 
 

        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(emoji)
        emoji.centerY(inView: self)
        emoji.anchor(top: topAnchor,left: leftAnchor, bottom: bottomAnchor, paddingTop: PADDING_TEXT_CELL, paddingLeft: PADDING_TEXT_CELL, paddingBottom: PADDING_TEXT_CELL, width: 25)
        
        addSubview(numberItemsLabel)
        numberItemsLabel.centerY(inView: self)
        numberItemsLabel.anchor(right: rightAnchor, paddingRight: 40, width: 20)

        
        
        addSubview(categoryNameLabel)
        categoryNameLabel.centerY(inView: self)
        categoryNameLabel.anchor(left: emoji.rightAnchor,right: numberItemsLabel.leftAnchor,paddingLeft: PADDING_TEXT_CELL, paddingRight: PADDING_TEXT_CELL)

        
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
