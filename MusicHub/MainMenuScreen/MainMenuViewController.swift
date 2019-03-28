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
    func getLoginDetails(userInfo: (username: String, password: String))
}

protocol MainMenuViewControllerInput: AnyObject {
    func showAlert(with error: String)
}

class MainMenuViewController: UIViewController {

    var isKeyboardAppear = false
    var presenter: MainMenuViewControllerOutput!
    var theView: MainMenuView!

    override func viewDidLoad() {
        super.viewDidLoad()
        MainMenuAssembly.sharedInstance.configure(self)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)

        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        tap.delegate = self
    }

    override func loadView() {
        theView = MainMenuView(frame: .zero)
        self.view = theView
        theView.backgroundColor = .black
        theView.confirmPressedClosure = { (username, password) in
            self.presenter.getLoginDetails(userInfo: (username: username, password: password))
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        theView.loginView.autoMatch(.height, to: .height, of: theView.stackView, withMultiplier: 1.5)
        theView.loginView.layer.cornerRadius = theView.loginView.frame.size.height/2
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        theView.alignComponents()
        theView.getRandomColor()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    @objc private func endEditing() {}

    @objc private func keyboardWillShow(notification: NSNotification) {
        if !isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y -= keyboardSize.height
            }
            isKeyboardAppear = true
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        if isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y += keyboardSize.height
            }
            isKeyboardAppear = false
        }
    }

    @objc private func applicationDidBecomeActive() {
        theView.getRandomColor()
    }
}

extension MainMenuViewController: MainMenuViewControllerInput {
    func showAlert(with error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.theView.getRandomColor()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainMenuViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let view = touch.view else { return true }
        if view.isEqual(theView.confirmButton) {
            return true
        } else if view.isMember(of: UIButton.self) {
            return false
        } else { return true }
    }
}
