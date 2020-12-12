//
//  AddCategoryView.swift
//  jToDo
//
//  Created by Javier Cueto on 08/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit


protocol AddCategoryViewDelegate: class{
    func didFinishCategory(title: String?, emoji: String?, categoryAction: CategoryAction)
}

enum CategoryAction {
    case edit
    case new
    case close
    
    var description: String {
        switch self {
        
        case .edit:
            return "Editar"
        case .new:
           return  "Guardar"
        case .close:
            return "nada"
        }
    }
}

class ActionCategoryView: UIView {
    
    weak var delegate: AddCategoryViewDelegate?
    
    var categoryAction: CategoryAction = .new
    
    var category: Category? {
        didSet {
            saveButton.setTitle(categoryAction.description, for: .normal)
            guard let cat = category else {return}
            titleTextField.text = cat.name
            emojiTextField.text = cat.emoji
        }
    }
    
    private let closedButton: UIButton = {
        let b = UIButton(type: .close)
        b.tintColor = .lightGray
        b.addTarget(self, action: #selector(handleCloseView), for: .touchUpInside)
        return b
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Categoria"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
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
    
    private let titleTextField: UITextField = {
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
    
    private let emojiTextField: UITextField = {
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
        
        return field
    }()
    
    private let saveButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Guardar", for: .normal)
        b.backgroundColor = .systemBlue
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(handleButtonView), for: .touchUpInside)
        b.layer.cornerRadius = 10
        return b
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewCard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func focusField() {
        titleTextField.becomeFirstResponder()
    }
    
    func clearField() {
        titleTextField.text = ""
        emojiTextField.text = "🧰"
    }
    
    func configureViewCard(){
        print("se ejecuto la vista")
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 15
        
        addSubview(closedButton)
        closedButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 20, paddingRight: 20)
        
        addSubview(titleLabel)
        titleLabel.centerX(inView: self)
        titleLabel.centerY(inView: closedButton)

        addSubview(titleTextField)
        titleTextField.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,paddingTop: 20, paddingLeft: 20 ,paddingRight: 20, height: 50)
        
      addSubview(emojiLabel)
        emojiLabel.anchor(top: titleTextField.bottomAnchor, left: leftAnchor, right: rightAnchor,paddingTop: 20, paddingLeft: 20 ,paddingRight: 20)
        
       
        
        addSubview(emojiTextField)
        emojiTextField.centerX(inView: self)
        emojiTextField.anchor(top: emojiLabel.bottomAnchor, paddingTop: 10, width: 70, height: 50)
    
        
        addSubview(saveButton)
        saveButton.anchor(left: leftAnchor,bottom: bottomAnchor,right: rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, height: 50)
        
    }
    
    @objc func handleCloseView(){
        categoryAction = .close
        delegate?.didFinishCategory(title: titleTextField.text, emoji: emojiTextField.text, categoryAction: categoryAction)
    }
    
    @objc func handleButtonView(){
        delegate?.didFinishCategory(title: titleTextField.text, emoji: emojiTextField.text, categoryAction: categoryAction)
    }
    
}
