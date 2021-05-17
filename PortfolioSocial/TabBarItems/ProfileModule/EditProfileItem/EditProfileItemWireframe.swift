//
//  EditProfileItemWireframe.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 26.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

class EditProfileItemWireframe: BaseWireframe {

    // MARK: - Private properties -

    // MARK: - Module setup -

    init(item: FormItems, userInformation: UserInformation, delegate: EditProfileItemDelegate?) {
        let moduleViewController = EditProfileItemViewController()
        super.init(viewController: moduleViewController)
        let interactor = EditProfileItemInteractor()
        let presenter = EditProfileItemPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        presenter.userInformation = userInformation
        presenter.delegate = delegate
        presenter.currentCase = item
        interactor.presenter = presenter
        interactor.userService = UserService()
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension EditProfileItemWireframe: EditProfileItemWireframeInterface {
    func viewDisappeared() {
        navigationController?.popViewController(animated: false)
    }
}
