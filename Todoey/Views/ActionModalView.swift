//
//  AddCategoryView.swift
//  jToDo
//
//  Created by Javier Cueto on 08/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit


protocol ActionModalViewDelegate: class{
    func didFinishCategory(title: String?, emoji: String?, categoryAction: ActionModal)
}

protocol ActionItemModalViewDelegate: class{
    func didFinishItem(title: String?, itemAction: ActionModal)
}


enum ActionModal {
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

enum TypeObject {
    case category
    case item
    
    
    var description: String {
        switch self {
        
        case .category:
            return "Categoria"
        case .item:
            return  "Tarea"
        }
    }
}

class ActionModalView: UIView {
    
    weak var delegate: ActionModalViewDelegate?
    
    weak var delegateItem: ActionItemModalViewDelegate?
    
    var action: ActionModal = .new
    
    private var typeObject: TypeObject?
    
    private var viewStatus: Bool = false
    
    var category: Category? {
        didSet {
            saveButton.setTitle(action.description, for: .normal)
            closedButton.backgroundColor =  ConfigSettings.shared.ACCENT_COLOR
            emojiLabel.textColor = ConfigSettings.shared.ACCENT_COLOR
            titleTextField.tintColor = ConfigSettings.shared.ACCENT_COLOR
            emojiTextField.tintColor = ConfigSettings.shared.ACCENT_COLOR
            saveButton.backgroundColor = ConfigSettings.shared.ACCENT_COLOR
            guard let cat = category else {return}
            titleTextField.text = cat.name
            emojiTextField.text = cat.emoji
            
        }
    }
    
    var item: Item? {
        didSet {
            saveButton.setTitle(action.description, for: .normal)
            guard let cat = category else {return}
            titleTextField.text = cat.name
        }
    }
    
    private let viewCard = UIView()
    private var viewCardHeight = 300
    
    private let closedButton: UIButton = {
        let b = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 14)
        let imageXmark = UIImage(systemName: "xmark", withConfiguration: imageConfig)
        b.setImage(imageXmark, for: .normal)
        b.tintColor = .white
        
        b.addTarget(self, action: #selector(handleCloseView), for: .touchUpInside)
        b.setDimentions(height: 40, width: 40)
        //b.backgroundColor = ConfigSettings.shared.ACCENT_COLOR
        b.layer.cornerRadius = 20
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
        
        field.layer.cornerRadius = 10
        field.font = UIFont.systemFont(ofSize: 30)
        field.textAlignment = .center
        
        return field
    }()
    
    private let saveButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Guardar", for: .normal)
        
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(handleButtonView), for: .touchUpInside)
        b.layer.cornerRadius = 10
        return b
    }()
    
    
    
    
    init(typeObject: TypeObject, placeHolder: String ) {
        super.init(frame: .zero)
        self.typeObject = typeObject
        
        if typeObject == .item {
            viewCardHeight = viewCardHeight - 95
        }
        self.configureViewCard()
        self.titleLabel.text = typeObject.description
        self.titleTextField.placeholder = placeHolder
        
    }
    
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if !viewStatus {
            focusField()
            clearField()
            
            if ConfigSettings.shared.MODAL_ANIMATION {
                UIView.animate(withDuration: 0.2) {
                    self.viewCard.frame.origin.y = CGFloat(self.viewCardHeight)
                    self.alpha = 1
                }
            }else{
                self.alpha = 1
            }
            
            viewStatus.toggle()
        }
        
        
    }
    
    func dismiss(){
        if ConfigSettings.shared.MODAL_ANIMATION {
            
            UIView.animate(withDuration: 0.2) {
                self.viewCard.frame.origin.y = CGFloat(-self.viewCardHeight)
                self.alpha = 0
                self.endEditing(true)
                
            }completion: { (_) in
                self.removeFromSuperview()
                self.viewStatus.toggle()
            }
        }else{
            
            
            self.viewCard.frame.origin.y = CGFloat(-self.viewCardHeight)
            self.alpha = 0
            UIView.performWithoutAnimation {
                self.endEditing(true)
            }
            
            
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
        
        /* let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
         let blurEffectView = UIVisualEffectView(effect: blurEffect)
         blurEffectView.alpha = 0.9
         blurEffectView.frame = bounds
         blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         addSubview(blurEffectView)*/
        
        backgroundColor = UIColor.black.withAlphaComponent(0.67)
        self.alpha = 0
        addSubview(viewCard)
        viewCard.centerX(inView: self)
        viewCard.setDimentions(height: CGFloat(self.viewCardHeight) , width: UIScreen.main.bounds.width - 40)
        
        viewCard.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        
        viewCard.backgroundColor = .secondarySystemBackground
        viewCard.layer.cornerRadius = 15
        
        viewCard.addSubview(closedButton)
        closedButton.anchor(top: viewCard.topAnchor, right: viewCard.rightAnchor, paddingTop: -10, paddingRight: -10)
        
        viewCard.addSubview(titleLabel)
        titleLabel.centerX(inView: viewCard)
        titleLabel.anchor(top: viewCard.topAnchor, paddingTop: 20)
        
        viewCard.addSubview(titleTextField)
        titleTextField.anchor(top: titleLabel.bottomAnchor, left: viewCard.leftAnchor, right: viewCard.rightAnchor,paddingTop: 20, paddingLeft: 20 ,paddingRight: 20, height: 50)
        
        if typeObject == .category {
            viewCard.addSubview(emojiLabel)
            emojiLabel.anchor(top: titleTextField.bottomAnchor, left: viewCard.leftAnchor, right: viewCard.rightAnchor,paddingTop: 20, paddingLeft: 20 ,paddingRight: 20)
            
            
            
            viewCard.addSubview(emojiTextField)
            emojiTextField.centerX(inView: viewCard)
            emojiTextField.anchor(top: emojiLabel.bottomAnchor, paddingTop: 10, width: 70, height: 50)
        }
        
        viewCard.addSubview(saveButton)
        saveButton.anchor(left: viewCard.leftAnchor,bottom: viewCard.bottomAnchor,right: viewCard.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, height: 50)
        
    }
    
    @objc func handleCloseView(){
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        action = .close
        if typeObject == .category {
            delegate?.didFinishCategory(title: titleTextField.text, emoji: emojiTextField.text, categoryAction: action)
        }else{
            delegateItem?.didFinishItem(title: titleTextField.text, itemAction: action)
        }
        
    }
    
    @objc func handleButtonView(){
        if typeObject == .category {
            delegate?.didFinishCategory(title: titleTextField.text, emoji: emojiTextField.text, categoryAction: action)
        }else{
            delegateItem?.didFinishItem(title: titleTextField.text, itemAction: action)
        }
    }
    
}
