//
//  MainMenuPresenter.swift
//  MusicHub
//
//  Created by Bogdan Nikolaev on 27/03/2019.
//  Copyright © 2019 Bogdan Nikolaev. All rights reserved.
//

import Foundation

protocol MainMenuPresenterInput: MainMenuViewControllerOutput {

}

class MainMenuPresenter: MainMenuPresenterInput {
    weak var view: MainMenuViewControllerInput!
    var router: MainMenuRouterInput!

    
}
