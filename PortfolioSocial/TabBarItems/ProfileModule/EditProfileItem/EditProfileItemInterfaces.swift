//
//  EditProfileItemInterfaces.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 26.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol EditProfileItemWireframeInterface: WireframeInterface {
    func viewDisappeared()
}

protocol EditProfileItemViewInterface: ViewInterface {
    func setCurrentInformation(labelText: String, information: String, count: Int)
    func setChangeUserName(username: String, count: Int)
}

protocol EditProfileItemPresenterInterface: PresenterInterface {
    func viewLoaded()
    func pressedDone(with text: String)
    func pressedCancel()
    func pressedDoneForUsername(username: String)
}

protocol EditProfileItemInteractorInterface: InteractorInterface {
    func checkUsername(username: String)
}
