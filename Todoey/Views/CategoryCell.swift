//
//  CategoryCell.swift
//  jToDo
//
//  Created by Javier Cueto on 20/11/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

       /* var product : Product? {
            didSet {
                productImage.image = product?.productImage
                productNameLabel.text = product?.productName
                productDescriptionLabel.text = product?.productDesc
            }
        }*/
        
        
         let productNameLabel : UILabel = {
            let lbl = UILabel()
            lbl.textColor = .black
            lbl.font = UIFont.boldSystemFont(ofSize: 16)
            lbl.textAlignment = .left
            return lbl
        }()
        
        
        private let productDescriptionLabel : UILabel = {
            let lbl = UILabel()
            lbl.textColor = .black
            lbl.font = UIFont.systemFont(ofSize: 16)
            lbl.textAlignment = .left
            lbl.numberOfLines = 0
            return lbl
        }()
        
   

        var productQuantity : UILabel =  {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textAlignment = .left
            label.text = "1"
            label.textColor = .black
            return label
            
        }()
        
        private let productImage : UIImageView = {
            let imgView = UIImageView(image: UIImage(systemName: "person"))
            imgView.contentMode = .scaleAspectFit
            imgView.clipsToBounds = true
            return imgView
        }()
        
     
       
        
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            addSubview(productImage)
            addSubview(productNameLabel)
            addSubview(productDescriptionLabel)
            addSubview(productQuantity)
     
            
            productImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
            productNameLabel.anchor(top: topAnchor, left: productImage.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
            productDescriptionLabel.anchor(top: productNameLabel.bottomAnchor, left: productImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
            
            
            let stackView = UIStackView(arrangedSubviews: [productQuantity])
            stackView.distribution = .equalSpacing
            stackView.axis = .horizontal
            stackView.spacing = 5
            addSubview(stackView)
            stackView.anchor(top: topAnchor, left: productNameLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 15, paddingRight: 10, width: 0, height: 70, enableInsets: false)
            
          
        
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
