//
//  EditProfileWireframe.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 22.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

class EditProfileWireframe: BaseWireframe {

    // MARK: - Private properties -
    // MARK: - Module setup -

    init(delegate: EditProfileDelegate?, image: String) {
        let moduleViewController = EditProfileViewController()
        moduleViewController.imageUrl = image
        super.init(viewController: moduleViewController)

        let interactor = EditProfileInteractor()
        let presenter = EditProfilePresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        presenter.delegate = delegate
        interactor.presenter = presenter
        interactor.profilePhotoService = ProfilePhotoService()
        interactor.userService = UserService()
        interactor.profileService = ProfileService()
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension EditProfileWireframe: EditProfileWireframeInterface {
    func routeToEditItem(with item: FormItems, userInformation: UserInformation, delegate: EditProfileItemDelegate) {
        let module = EditProfileItemWireframe(item: item, userInformation: userInformation, delegate: delegate)
        navigationController?.pushWireframeWithoutAnimation(module)
    }

    func viewDisappeared() {
        navigationController?.popViewController(animated: false)
    }
}
