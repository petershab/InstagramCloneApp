//
//  CreateUserInteractor.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 12.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation
import FirebaseAuth

final class CreateUserInteractor {
    weak var presenter: CreateUserPresenter?
    
}

// MARK: - Extensions -

extension CreateUserInteractor: CreateUserInteractorInterface {
    func createUser(username: String?) {
        guard let firUser = Auth.auth().currentUser,
              let username = username,
              !username.isEmpty else { return }
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else { return }
              self.presenter?.transitionToProfile()
        }
    }
}

