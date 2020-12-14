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
    
    private var viewStatus: Bool = false
    
    var category: Category? {
        didSet {
            saveButton.setTitle(categoryAction.description, for: .normal)
            guard let cat = category else {return}
            titleTextField.text = cat.name
            emojiTextField.text = cat.emoji
        }
    }
    
    private let viewCard = UIView()
    private let viewCardHeight = 300
    
    private let closedButton: UIButton = {
        let b = UIButton(type: .close)
        b.tintColor = .lightGray
        b.addTarget(self, action: #selector(handleCloseView), for: .touchUpInside)
        return b
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Categoria"
        label.textColor = UIColor(named: "TitleColor")
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private var emojiLabel: UILabel = {
        let label = UILabel()
        label.text = "Seleccione 1 emoji"
        label.textColor = ACCENT_COLOR
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let titleTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .systemGray5
        let paddinView = UIView()
        paddinView.setDimentions(height: 30, width: 8)
        field.leftView = paddinView
        field.leftViewMode = .always
        field.tintColor = ACCENT_COLOR
        field.placeholder = "Titulo de la categoria"
        field.layer.cornerRadius = 10
        return field
    }()
    
    private let emojiTextField: UITextField = {
        let field = EmojiTextField()
        field.backgroundColor = .systemGray5
        let paddinView = UIView()
        paddinView.setDimentions(height: 30, width: 8)
        field.leftView = paddinView
        field.leftViewMode = .always
        field.rightView = paddinView
        field.rightViewMode = .always
        field.tintColor = ACCENT_COLOR
        field.layer.cornerRadius = 10
        field.font = UIFont.systemFont(ofSize: 30)
        field.textAlignment = .center
        
        return field
    }()
    
    private let saveButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Guardar", for: .normal)
        b.backgroundColor = ACCENT_COLOR
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(handleButtonView), for: .touchUpInside)
        b.layer.cornerRadius = 10
        return b
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewCard()
    }
    
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if !viewStatus {
            focusField()
            clearField()
            
            UIView.animate(withDuration: 0.2) {
                self.viewCard.frame.origin.y = CGFloat(self.viewCardHeight)
                self.alpha = 1
            }
            viewStatus.toggle()
        }
        
        
    }
    
    func dismiss(){
        UIView.animate(withDuration: 0.2) {
            self.viewCard.frame.origin.y = CGFloat(-self.viewCardHeight)
            self.alpha = 0
            self.endEditing(true)
            
        }completion: { (_) in
            self.removeFromSuperview()
            self.viewStatus.toggle()
        }
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
        backgroundColor = UIColor.black.withAlphaComponent(0.67)
        self.alpha = 0
        addSubview(viewCard)
        viewCard.centerX(inView: self)
        viewCard.setDimentions(height: CGFloat(self.viewCardHeight) , width: UIScreen.main.bounds.width - 40)
        
        viewCard.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        
        viewCard.backgroundColor = .secondarySystemBackground
        viewCard.layer.cornerRadius = 15
        
        viewCard.addSubview(closedButton)
        closedButton.anchor(top: viewCard.topAnchor, right: viewCard.rightAnchor, paddingTop: 20, paddingRight: 20)
        
        viewCard.addSubview(titleLabel)
        titleLabel.centerX(inView: viewCard)
        titleLabel.centerY(inView: closedButton)
        
        viewCard.addSubview(titleTextField)
        titleTextField.anchor(top: titleLabel.bottomAnchor, left: viewCard.leftAnchor, right: viewCard.rightAnchor,paddingTop: 20, paddingLeft: 20 ,paddingRight: 20, height: 50)
        
        viewCard.addSubview(emojiLabel)
        emojiLabel.anchor(top: titleTextField.bottomAnchor, left: viewCard.leftAnchor, right: viewCard.rightAnchor,paddingTop: 20, paddingLeft: 20 ,paddingRight: 20)
        
        
        
        viewCard.addSubview(emojiTextField)
        emojiTextField.centerX(inView: viewCard)
        emojiTextField.anchor(top: emojiLabel.bottomAnchor, paddingTop: 10, width: 70, height: 50)
        
        
        viewCard.addSubview(saveButton)
        saveButton.anchor(left: viewCard.leftAnchor,bottom: viewCard.bottomAnchor,right: viewCard.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, height: 50)
        
    }
    
    @objc func handleCloseView(){
        categoryAction = .close
        delegate?.didFinishCategory(title: titleTextField.text, emoji: emojiTextField.text, categoryAction: categoryAction)
    }
    
    @objc func handleButtonView(){
        delegate?.didFinishCategory(title: titleTextField.text, emoji: emojiTextField.text, categoryAction: categoryAction)
    }
    
}
