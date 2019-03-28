//
//  Model.swift
//  MusicHub
//
//  Created by Bogdan Nikolaev on 28/03/2019.
//  Copyright © 2019 Bogdan Nikolaev. All rights reserved.
//

import Foundation

class UserModel {
    var username = "admin"
    let password = "admin"

    func isRegisteredUser(userInfo: (username: String, password: String)) -> Bool {
        return userInfo.username == self.username && userInfo.password == self.password
    }
}
