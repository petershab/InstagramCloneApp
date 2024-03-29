//
//  AuthViewController.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 07.01.2021.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot

class User: Codable {
    let uid: String
    var username: String
    var name: String
    var occupation: String
    var bio: String
    var numberOfPosts: String
    var isFollowed = false

    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
        self.name = ""
        self.occupation = ""
        self.bio = ""
        self.numberOfPosts = "0"
    }

    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
            let username = dict["username"] as? String,
            let numberOfPosts = dict["numberOfPosts"] as? String,
            let information = dict["information"] as? [String: String]
            else { return nil }

        self.uid = snapshot.key
        self.username = username
        self.name = information["name"] ?? ""
        self.occupation = information["occupation"] ?? ""
        self.bio = information["bio"] ?? ""
        self.numberOfPosts = numberOfPosts
    }

    private static var _current: User?

    static var current: User? {
        return _current
    }

    // MARK: - Class Methods

    static func setCurrent(_ user: User, saveToDefaults: Bool = false) {
        if saveToDefaults {
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
            }
        }
        _current = user
    }

    static func setCurrent(_ user: User) {
        _current = user
    }
}
