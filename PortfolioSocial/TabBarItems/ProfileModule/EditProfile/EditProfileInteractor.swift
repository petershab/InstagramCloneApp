//
//  EditProfileInteractor.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 22.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation
import FirebaseDatabase
import Firebase

class EditProfileInteractor {
    weak var presenter: EditProfilePresenter?
    var profilePhotoService: ProfilePhotoService?
    var userService: UserService?
    var profileService: ProfileService?
}

// MARK: - Extensions -

extension EditProfileInteractor: EditProfileInteractorInterface {
    func updateUsersInformation(info: UserInformation) {
        profileService?.updateInformation(forUID: User.current!.uid, newInfo: info) { [weak self] (bool) in
            if bool {
                self?.userService?.show(forUID: User.current!.uid) { [self] (user) in
                    if let user = user {
                        User.setCurrent(user, saveToDefaults: true)
                        self?.presenter?.viewDisappeared()
                    }
                }
            } else {
                fatalError()
            }
        }
    }
    
    func updateProfilePhoto(image: NSObject) {
        profilePhotoService?.updateProfilePhoto(for: image as! UIImage)
    }
    
    func getUserInformation() {
        profileService?.userInformation(for: User.current!.uid, completion: { [weak self]  (info) in
            self?.presenter?.recievedInformation(info: info)
        })
    }
}