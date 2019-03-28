//
//  MainMenuRouter.swift
//  MusicHub
//
//  Created by Bogdan Nikolaev on 27/03/2019.
//  Copyright © 2019 Bogdan Nikolaev. All rights reserved.
//

import Foundation

protocol MainMenuRouterInput {
    func goToMainMenu()
}

class MainMenuRouter: MainMenuRouterInput {

    weak var viewController: MainMenuViewController!
    
    func goToMainMenu() {

    }
}
