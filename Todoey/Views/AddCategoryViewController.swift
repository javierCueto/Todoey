//
//  AddCategoryView.swift
//  jToDo
//
//  Created by Javier Cueto on 08/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

class EmojiTextField: UITextField {

   // required for iOS 13
   override var textInputContextIdentifier: String? { "" } // return non-nil to show the Emoji keyboard ¯\_(ツ)_/¯

    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        return nil
    }
}

class AddCategoryViewController: UIViewController {
    
    let viewCardHeight = 300
    let viewCard: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Nueva Categoria"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    private var emojiLabel: UILabel = {
       let label = UILabel()
        label.text = "Seleccione 1 emoji"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let titleTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .systemGroupedBackground
        let paddinView = UIView()
        paddinView.setDimentions(height: 30, width: 8)
        field.leftView = paddinView
        field.leftViewMode = .always
        field.keyboardAppearance = .dark
        field.placeholder = "Titulo de la categoria"
        field.becomeFirstResponder()
        field.layer.cornerRadius = 10
        return field
    }()
    
    let emojiTextField: UITextField = {
        let field = EmojiTextField()
        field.backgroundColor = .systemGroupedBackground
        let paddinView = UIView()
        paddinView.setDimentions(height: 30, width: 8)
        field.leftView = paddinView
        field.leftViewMode = .always
        field.rightView = paddinView
        field.rightViewMode = .always
        field.layer.cornerRadius = 10
        field.font = UIFont.systemFont(ofSize: 30)
        field.textAlignment = .center
        field.keyboardAppearance = .dark
        field.text = "🧰"
     
        return field
    }()
    
    
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.67)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewCard()
        
    }
    
    func configureViewCard(){

        view.addSubview(viewCard)
        viewCard.clipsToBounds = true
        viewCard.centerX(inView: view)
        viewCard.setDimentions(height: CGFloat(viewCardHeight) , width: view.frame.width - 40)
        viewCard.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        
        
        viewCard.addSubview(titleLabel)
        titleLabel.anchor(top: viewCard.topAnchor, left: viewCard.leftAnchor, right: viewCard.rightAnchor,paddingTop: 20, paddingLeft: 20 ,paddingRight: 20)
        
        viewCard.addSubview(titleTextField)
        titleTextField.anchor(top: titleLabel.bottomAnchor, left: viewCard.leftAnchor, right: viewCard.rightAnchor,paddingTop: 20, paddingLeft: 20 ,paddingRight: 20, height: 50)
        
        viewCard.addSubview(emojiLabel)
        emojiLabel.anchor(top: titleTextField.bottomAnchor, left: viewCard.leftAnchor, right: viewCard.rightAnchor,paddingTop: 20, paddingLeft: 20 ,paddingRight: 20)
        
        
        
        viewCard.addSubview(emojiTextField)
        emojiTextField.centerX(inView: viewCard)
        emojiTextField.anchor(top: emojiLabel.bottomAnchor, paddingTop: 10, width: 70, height: 50)
 
        
        UIView.animate(withDuration: 0.3 ) {
            self.viewCard.frame.origin.y = CGFloat(self.viewCardHeight)
        }
    }
    
}
