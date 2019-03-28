//
//  UITextField.swift
//  MusicHub
//
//  Created by Bogdan Nikolaev on 27/03/2019.
//  Copyright © 2019 Bogdan Nikolaev. All rights reserved.
//

import UIKit

class UserInputs: UITextField, UITextFieldDelegate {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftViewMode = .always
        self.clearButtonMode = .whileEditing
        self.font = self.font?.withSize(24)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height/2
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
