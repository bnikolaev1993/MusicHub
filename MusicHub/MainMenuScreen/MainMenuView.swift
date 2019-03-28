//
//  MainMenuView.swift
//  MusicHub
//
//  Created by Bogdan Nikolaev on 28/03/2019.
//  Copyright © 2019 Bogdan Nikolaev. All rights reserved.
//

import UIKit

class MainMenuView: UIView {

    lazy var usernameTF: UserInputs = UserInputs(frame: .zero)
    lazy var passwordTF: UserInputs = UserInputs(frame: .zero)
    lazy var logo = UIImageView(image: UIImage(named: "logo"))
    lazy var confirmButton: UIButton = UIButton(type: UIButton.ButtonType.roundedRect)
    var uiColor: UIColor!
    var loginView: UIView!
    var stackView: UIStackView!
    var confirmPressedClosure: ((String, String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.uiColor = getColor()
        confirmButton.addTarget(self, action: #selector(confirmPressed(_:)), for: .touchUpOutside)
        self.setUpComponents()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

        self.addSubview(loginView)
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

        self.addSubview(logo)
        let tintedImage = self.logo.image?.withRenderingMode(.alwaysTemplate)
        self.logo.image = tintedImage
        self.logo.tintColor = uiColor
    }

    public func alignComponents() {
        loginView.autoAlignAxis(toSuperviewAxis: .vertical)
        loginView.autoPinEdge(toSuperviewEdge: .right, withInset: 25)
        loginView.autoPinEdge(toSuperviewEdge: .left, withInset: 25)
        loginView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 50)


        stackView.autoCenterInSuperview()
        stackView.autoSetDimension(.width, toSize: 200)

        logo.autoAlignAxis(toSuperviewAxis: .vertical)
        logo.autoPinEdge(toSuperviewSafeArea: .top, withInset: 25, relation: .greaterThanOrEqual)
        //logo.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
    }

    public func getRandomColor() {
        self.loginView.backgroundColor = uiColor
        self.loginView.backgroundColor = self.loginView.backgroundColor?.withAlphaComponent(0.5)
        self.logo.tintColor = uiColor
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: {
            self.logo.tintColor = .black
        }, completion: nil)
    }

    private func getColor() -> UIColor {
        let red   = CGFloat((arc4random() % 256)) / 255.0
        let green = CGFloat((arc4random() % 256)) / 255.0
        let blue  = CGFloat((arc4random() % 256)) / 255.0
        let alpha = CGFloat(1.0)

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    @objc private func confirmPressed(_ sender: UIButton) {
        self.confirmPressedClosure?(usernameTF.text?.lowercased() ?? "", passwordTF.text?.lowercased() ?? "")
    }

}
