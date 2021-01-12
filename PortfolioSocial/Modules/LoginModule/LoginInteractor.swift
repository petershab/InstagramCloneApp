//
//  LoginInteractor.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 07.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase

final class LoginInteractor {
    weak var presenter: LoginPresenter?
}

// MARK: - Extensions -

extension LoginInteractor: LoginInteractorInterface {
    func getUserState(user: FIRUser) {
        UserDefaults.isFirstLaunch()
        UserDefaults.isloggedIn()
        UserService.show(forUID: user.uid) { (user) in
            if let user = user {
                User.setCurrent(user)
                self.presenter?.userExists()
            } else {
                self.presenter?.transitionToNewUser()
                
            }
        }
    }
}