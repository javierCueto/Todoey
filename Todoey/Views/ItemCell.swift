//
//  ItemCell.swift
//  jToDo
//
//  Created by Javier Cueto on 21/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//


import UIKit

class ItemCell: UITableViewCell {
    
    var model: Item? {
        didSet{
            guard let model = self.model else {return}
            isCheck.tintColor = ConfigSettings.shared.ACCENT_COLOR
            nameLabel.removeStrike()
            if model.done {
                nameLabel.text = model.name
                nameLabel.addStrike()
                isCheck.image = UIImage(systemName: "checkmark.circle")
                
            }else {
                nameLabel.removeStrike()
                nameLabel.text = model.name
                isCheck.image = UIImage(systemName: "circle")
            }
            
        }
    }
    
    private let isCheck: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(systemName: "square")
        
        i.setDimentions(height: 30, width: 30)
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.baselineAdjustment = .alignCenters
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addSubview(isCheck)
        isCheck.centerY(inView: self)
        isCheck.anchor(left: leftAnchor, paddingLeft: PADDING_TEXT_CELL)
        
        
        addSubview(nameLabel)
        nameLabel.centerY(inView: self)
        nameLabel.anchor(left: isCheck.rightAnchor,right: rightAnchor,paddingLeft: PADDING_TEXT_CELL, paddingRight: PADDING_TEXT_CELL)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
