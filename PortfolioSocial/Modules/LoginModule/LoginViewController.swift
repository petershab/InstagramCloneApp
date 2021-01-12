//
//  LoginViewController.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 07.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseUI

typealias FIRUser = FirebaseAuth.User

final class LoginViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: LoginPresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topBar)
        topBar.addSubview(topLabel)
        topBar.addSubview(bottomLabel)
        view.addSubview(signUpOrRegister)
        view.backgroundColor = .white
        addFrames()
    }
    
    var topBar: UIView = {
        let views = UIView(frame: .zero)
        views.backgroundColor = .red
        return views
    }()
    
    var topLabel: UILabel = {
        var label = UILabel()
        label.text = "InstaClone"
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 36)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    var bottomLabel: UILabel = {
        var label = UILabel()
        label.text = "Sign up to see photos and videos from your friends."
        label.font = UIFont(name: "System, Semibold 15", size: 15)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    var signUpOrRegister: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("Register or Login", for: .normal)
        button.addTarget(self, action: #selector(onPress), for: .touchDown)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "System, Semibold 15", size: 15)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor(rgb: 0x3897F0)
        return button
    }()
    
    func addFrames() {
        topBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 265)
        topLabel.frame = CGRect(x: topBar.bounds.maxX / 2 - 100, y: topBar.bounds.maxY / 2 - 25, width: 200, height: 50)
        bottomLabel.frame = CGRect(x: topBar.bounds.maxX / 2 - 100, y: topBar.bounds.maxY / 2 + 15 , width: 200, height: 75)
        signUpOrRegister.frame = CGRect(x: view.frame.width / 2 - 152.5, y: topBar.frame.height + 25, width: 305, height: 44)
    }
    
    @objc func onPress() {
        self.view.backgroundColor = .brown
        //presenter.pressedButton()
        setupFirebaseAuth()
    }
    
    func setupFirebaseAuth() {
        guard let authUI = FUIAuth.defaultAuthUI()
        else { return }
                
        authUI.delegate = self
        let providers = [FUIEmailAuth()]
        authUI.providers = providers
        //Will add more providers later on
  
        let authViewController = authUI.authViewController()
        
        present(authViewController, animated: true)
        //Shows loginController for a second after dismissal which sucks

        
        // I have no clue how to work with non-viper view controllers in a Viper project. There are some resources out there for what to do with WKWebView but they generally involve creating some complicated structure https://github.com/strongself/The-Book-of-VIPER/blob/master/english/webview.md
        //I tried creating the authviewcontroller in the interactor and passing it back to this view controller but then I needed to add UIKit to the presenter which I read is a big no no, also there where issues with the delegate in that case
    }

}
extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        
        print("handle user signup / login")
        guard let currentUser = authDataResult?.user
        else { return }
        
        presenter.checkUser(user: currentUser)
     
        

    }
}

// MARK: - Extensions -

extension LoginViewController: LoginViewInterface {
}
