//
//  ConfirmView.swift
//  jToDo
//
//  Created by Javier Cueto on 29/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

protocol ConfirmModalViewDelegate: class {
    func didFinishConfirm( indexPath: IndexPath, isDeleted: Bool)
}

class ConfirmModalView: UIView {
    
    var indexPath: IndexPath?
    
    var nameToDelete: String = "" {
        didSet{
            titleToDeleteLabel.text = nameToDelete
        }
    }

    weak var delegate: ConfirmModalViewDelegate?

    
    private var viewStatus: Bool = false
    
    private let viewCard = UIView()
    private var viewCardHeight = 200
    
    private let closedButton: UIButton = {
        let b = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 14)
        let imageXmark = UIImage(systemName: "xmark", withConfiguration: imageConfig)
        b.setImage(imageXmark, for: .normal)
        b.tintColor = .white
        
        b.addTarget(self, action: #selector(handleCloseView), for: .touchUpInside)
        b.setDimentions(height: 40, width: 40)
        b.layer.cornerRadius = 20
        return b
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "TitleColor")
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private var titleToDeleteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
  
    
    private let saveButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Borrar", for: .normal)
        
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(handleButtonView), for: .touchUpInside)
        b.layer.cornerRadius = 10
        return b
    }()
    
    
    
    
    init(title: String ) {
        super.init(frame: .zero)
        self.configureViewCard()
        self.titleLabel.text = title
        
    }
    
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if !viewStatus {
            closedButton.backgroundColor =  ConfigSettings.shared.ACCENT_COLOR
            saveButton.backgroundColor = ConfigSettings.shared.ACCENT_COLOR

            
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
        indexPath = nil
        nameToDelete = ""
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
        closedButton.anchor(top: viewCard.topAnchor, right: viewCard.rightAnchor, paddingTop: -10, paddingRight: -10)
        
        viewCard.addSubview(titleLabel)
        titleLabel.centerX(inView: viewCard)
        titleLabel.anchor(top: viewCard.topAnchor, paddingTop: 20)
        
        viewCard.addSubview(titleToDeleteLabel)
        titleToDeleteLabel.centerX(inView: viewCard)
        titleToDeleteLabel.anchor(top: titleLabel.bottomAnchor, paddingTop: 30)
        

        
        viewCard.addSubview(saveButton)
        saveButton.anchor(left: viewCard.leftAnchor,bottom: viewCard.bottomAnchor,right: viewCard.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, height: 50)
        
    }
    
    @objc func handleCloseView(){
        guard let indexPath = self.indexPath else {return}
        delegate?.didFinishConfirm( indexPath: indexPath, isDeleted: false)
    }
    
    @objc func handleButtonView(){
        guard let indexPath = self.indexPath else {return}
        delegate?.didFinishConfirm( indexPath: indexPath, isDeleted: true)
    }
    
}
