//
//  MainMenuAssembly.swift
//  MusicHub
//
//  Created by Bogdan Nikolaev on 27/03/2019.
//  Copyright © 2019 Bogdan Nikolaev. All rights reserved.
//

import Foundation

class MainMenuAssembly {
    static let sharedInstance = MainMenuAssembly()

    func configure(_ viewController: MainMenuViewController) {
        let presenter = MainMenuPresenter()
        let interactor = MainMenuInteractor()
        let router = MainMenuRouter()
        let userModel = UserModel()

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = viewController
        interactor.presenter = presenter
        interactor.userModel = userModel
        router.viewController = viewController
    }
}
