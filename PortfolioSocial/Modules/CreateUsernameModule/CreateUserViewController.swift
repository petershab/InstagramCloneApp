//
//  CreateUsernameViewController.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 11.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

final class CreateUserViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Public properties -

    var presenter: CreateUserPresenterInterface!

    // MARK: - Lifecycle -
    
    var topLabel: UILabel = {
        var label = UILabel()
        label.text = "Create Username"
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 26)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    var containter: UIView = {
        let container = UIView()
        container.backgroundColor = .clear
        return container
    }()
    
    var bottomLabel: UILabel = {
        var label = UILabel()
        label.text = "Add a username so your friends can find you"
        label.font = UIFont(name: "System, Semibold 15", size: 15)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    var usernameTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Username"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.font = UIFont(name: "System, Semibold 15", size: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(rgb: 0xFAFAFA)
        return textField
    }()
    
    var nextButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("Register or Login", for: .normal)
        button.addTarget(self, action: #selector(onPress), for: .touchDown)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "System, Semibold 15", size: 15)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor(rgb: 0x3897F0)
        return button
    }()
    
    func setupFrames() {
        containter.frame =  CGRect(x: (view.frame.width - 300) / 2, y: (view.frame.height - 275) / 2 , width: 300, height: 275)
        topLabel.frame = CGRect(x: 50, y: 0, width: 200, height: 50)
        bottomLabel.frame = CGRect(x: 0, y: 50, width: 300, height: 50)
        usernameTextField.frame = CGRect(x: 0, y: 150, width: 300, height: 50)
        nextButton.frame = CGRect(x: 0, y: 225, width: 300, height: 50)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        usernameTextField.delegate = self
        view.addSubview(containter)
        containter.addSubview(topLabel)
        containter.addSubview(bottomLabel)
        containter.addSubview(usernameTextField)
        containter.addSubview(nextButton)
        setupFrames()
    }
    
    @objc func onPress() {
        presenter.buttonPressed(username: usernameTextField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            switch textField {
            case usernameTextField:
                usernameTextField.resignFirstResponder()
            default:
                break
            }
            return true
        }

        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            return true
        }

}

// MARK: - Extensions -

extension CreateUserViewController: CreateUserViewInterface {
}
