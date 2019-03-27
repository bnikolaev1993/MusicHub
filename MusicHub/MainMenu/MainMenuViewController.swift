//
//  MainMenuViewController.swift
//  MusicHub
//
//  Created by Bogdan Nikolaev on 27/03/2019.
//  Copyright © 2019 Bogdan Nikolaev. All rights reserved.
//

import UIKit
import PureLayout

protocol MainMenuViewControllerOutput {
    
}

protocol MainMenuViewControllerInput: AnyObject {
    
}

class MainMenuViewController: UIViewController {

    lazy var usernameTF: UserInputs = UserInputs(frame: .zero)
    lazy var passwordTF: UserInputs = UserInputs(frame: .zero)
    lazy var logo = UIImageView(image: UIImage(named: "logo"))
    lazy var confirmButton: UIButton = UIButton(type: UIButton.ButtonType.roundedRect)
    var loginView: UIView!
    var stackView: UIStackView!
    var isKeyboardAppear = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)

        confirmButton.addTarget(self, action: #selector(confirmPressed(_:)), for: .touchUpOutside)

        self.setUpComponents()
        self.getRandomColor()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginView.autoMatch(.height, to: .height, of: stackView, withMultiplier: 1.5)
        loginView.layer.cornerRadius = loginView.frame.size.height/2
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.alignComponents()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func setUpComponents() {
        loginView = UIView()
        loginView.backgroundColor = .clear


        stackView = UIStackView(arrangedSubviews: [usernameTF, passwordTF, confirmButton])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 15

        loginView.addSubview(stackView)

        self.view.addSubview(loginView)
        usernameTF.backgroundColor = .white
        usernameTF.placeholder = "Username"

        passwordTF.clearsOnBeginEditing = true
        passwordTF.backgroundColor = .white
        passwordTF.placeholder = "Password"
        passwordTF.textContentType = UITextContentType.password

        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.layer.cornerRadius = 10
        confirmButton.titleLabel?.font = confirmButton.titleLabel?.font.withSize(20)

        confirmButton.backgroundColor = .clear
        confirmButton.tintColor = .blue

        self.view.addSubview(logo)
        let tintedImage = self.logo.image?.withRenderingMode(.alwaysTemplate)
        self.logo.image = tintedImage
        self.logo.tintColor = .black
    }

    private func alignComponents() {
        loginView.autoAlignAxis(toSuperviewAxis: .vertical)
        loginView.autoPinEdge(toSuperviewEdge: .right, withInset: 25)
        loginView.autoPinEdge(toSuperviewEdge: .left, withInset: 25)
        loginView.autoPin(toBottomLayoutGuideOf: self, withInset: 50)


        stackView.autoCenterInSuperview()
        stackView.autoSetDimension(.width, toSize: 200)

        logo.autoAlignAxis(toSuperviewAxis: .vertical)
        logo.autoPinEdge(toSuperviewSafeArea: .top, withInset: 25, relation: .greaterThanOrEqual)
        //logo.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
    }

    @objc private func endEditing() {}

    @objc private func confirmPressed(_ sender: UIButton) {}

    func getRandomColor() {
        let color = getColor()
        self.loginView.backgroundColor = color
        self.loginView.backgroundColor = self.loginView.backgroundColor?.withAlphaComponent(0.5)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: {
            self.logo.tintColor = color
        }, completion: nil)
    }

    private func getColor() -> UIColor {
        let red   = CGFloat((arc4random() % 256)) / 255.0
        let green = CGFloat((arc4random() % 256)) / 255.0
        let blue  = CGFloat((arc4random() % 256)) / 255.0
        let alpha = CGFloat(1.0)

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if !isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y -= keyboardSize.height
            }
            isKeyboardAppear = true
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y += keyboardSize.height
            }
            isKeyboardAppear = false
        }
    }
}
