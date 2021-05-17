//
//  PostInterfaces.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 3/1/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol PostWireframeInterface: WireframeInterface {
    func routeToProfile()
    func routeBack()
}

protocol PostViewInterface: ViewInterface {
    func setImage(with image: NSObject)
}

protocol PostPresenterInterface: PresenterInterface {
    func viewLoaded()
    func pressedShare(with image: NSObject, and caption: String)
    func createdPost()
    func pressedBack()
}

protocol PostInteractorInterface: InteractorInterface {
    func createPost(with image: NSObject, and caption: String)
}