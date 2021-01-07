//
//  AddPostWireframe.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 07.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class AddPostWireframe: BaseWireframe {

    // MARK: - Private properties -

    // MARK: - Module setup -

    init() {
        let moduleViewController = AddPostViewController()
        super.init(viewController: moduleViewController)

        let interactor = AddPostInteractor()
        let presenter = AddPostPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension AddPostWireframe: AddPostWireframeInterface {
}
