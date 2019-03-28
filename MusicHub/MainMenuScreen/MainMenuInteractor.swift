//
//  MainMenuInteractor.swift
//  MusicHub
//
//  Created by Bogdan Nikolaev on 28/03/2019.
//  Copyright © 2019 Bogdan Nikolaev. All rights reserved.
//

import Foundation

protocol MainMenuInteractorInput {
    func getLoginDetails(userInfo: (username: String, password: String))
}

protocol MainMenuInteractorOutput {
    func sendLoginStatus(isLoggedIn: Bool)
}

class MainMenuInteractor: MainMenuInteractorInput {
    var presenter: MainMenuInteractorOutput!
    var userModel: UserModel!

    func getLoginDetails(userInfo: (username: String, password: String)) {
        self.presenter.sendLoginStatus(isLoggedIn: userModel.isRegisteredUser(userInfo: userInfo))
    }
}
