//
//  MainMenuPresenter.swift
//  MusicHub
//
//  Created by Bogdan Nikolaev on 27/03/2019.
//  Copyright © 2019 Bogdan Nikolaev. All rights reserved.
//

import Foundation

protocol MainMenuPresenterInput: MainMenuViewControllerOutput, MainMenuInteractorOutput {
    
}

class MainMenuPresenter: MainMenuPresenterInput {

    weak var view: MainMenuViewControllerInput!
    var router: MainMenuRouterInput!
    var interactor: MainMenuInteractorInput!

    func getLoginDetails(userInfo: (username: String, password: String)) {
        self.interactor.getLoginDetails(userInfo: userInfo)
    }

    func sendLoginStatus(isLoggedIn: Bool) {
        if isLoggedIn {
            
        } else {
            self.view.showAlert(with: "Invalid Login!")
        }
    }
}
