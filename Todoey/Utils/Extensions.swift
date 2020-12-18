//
//  Extensions.swift
//  jToDo
//
//  Created by Javier Cueto on 20/11/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit


extension UIView {

    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                       left: NSLayoutXAxisAnchor? = nil,
                       bottom: NSLayoutYAxisAnchor? = nil,
                       right: NSLayoutXAxisAnchor? = nil,
                       paddingTop: CGFloat = 0,
                       paddingLeft: CGFloat = 0,
                       paddingBottom: CGFloat = 0,
                       paddingRight: CGFloat = 0,
                       width: CGFloat? = nil,
                       height: CGFloat? = nil){

        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    }
    
    func setDimentions(height: CGFloat, width: CGFloat){
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    
    
    func centerX(inView view: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor){
            clipsToBounds = true
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
            gradientLayer.frame = self.bounds
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            self.layer.insertSublayer(gradientLayer, at: 0)

        }
    
   
    
    
}


 
extension UILabel {

    func addStrike(){
        guard let text = self.text else {return}
        self.attributedText =  NSMutableAttributedString(string: text, attributes: [.strikethroughStyle: NSUnderlineStyle.thick.rawValue])
    }

    


    func removeStrike(){
        guard let text = self.text else {return}
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string:  (text))
        attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
            
        self.attributedText = attributeString
    }

   

}
