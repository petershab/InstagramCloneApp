//
//  SignUpViewController.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 07.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import Firebase

final class SignUpViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: SignUpPresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setupFirebaseAuth() {
        guard let authUI = FUIAuth.defaultAuthUI()
                else { return }

            // 2
            authUI.delegate = self

            // 3
            let authViewController = authUI.authViewController()
            present(authViewController, animated: true)
    }
}

// MARK: - Extensions -

extension SignUpViewController: SignUpViewInterface {
}

extension SignUpViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        print("handle user signup / login")
    }
}