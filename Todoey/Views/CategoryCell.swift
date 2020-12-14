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
            numberItemsLabel.text = "\(model.items?.count ?? 0)"
        }
    }
    
    private let emoji: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    
    private let categoryNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
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
        emoji.anchor(top: topAnchor,left: leftAnchor, bottom: bottomAnchor, paddingTop: PADDING_TEXT_CELL, paddingLeft: PADDING_TEXT_CELL, paddingBottom: PADDING_TEXT_CELL)
        
        addSubview(categoryNameLabel)
        categoryNameLabel.centerY(inView: emoji)
        categoryNameLabel.anchor(left: emoji.rightAnchor, paddingLeft: PADDING_TEXT_CELL)
        
        addSubview(numberItemsLabel)
        numberItemsLabel.centerY(inView: categoryNameLabel)
        numberItemsLabel.anchor(left: categoryNameLabel.rightAnchor, paddingLeft: PADDING_TEXT_CELL)
        
        
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
