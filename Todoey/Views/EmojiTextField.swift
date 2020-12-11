//
//  EmojiTextField.swift
//  jToDo
//
//  Created by Javier Cueto on 10/12/20.
//  Copyright © 2020 José Javier Cueto Mejía. All rights reserved.
//
import UIKit

class EmojiTextField: UITextField {
    
    // required for iOS 13
    override var textInputContextIdentifier: String? { "" }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        return nil
    }
}
