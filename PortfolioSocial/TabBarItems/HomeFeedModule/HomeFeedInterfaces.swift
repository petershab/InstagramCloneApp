//
//  HomeFeedInterfaces.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 07.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol HomeFeedWireframeInterface: WireframeInterface {
    func routeToProfile(with uuid: String, isFollowed: Bool)
    func routeToLogIn()
}

protocol HomeFeedViewInterface: ViewInterface {
    func updateTimeline(with posts: [Post])
}

protocol HomeFeedPresenterInterface: PresenterInterface {
    func viewLoaded()
    func recievedTimeline(posts: [Post])
    func viewReloaded()
    func pressedUsernameButton(with username: String)
    func recieved(uuid: String, isFollowed: Bool)
    var posts: [Post]? { get set}
    func likedPost(isLiked: Bool, post: Post, completion: @escaping (Bool) -> Void)
}

protocol HomeFeedInteractorInterface: InteractorInterface {
    func getTimeline()
    func getUUID(from username: String)
    func likedPost(isLiked: Bool, post: Post, completion: @escaping (Bool) -> Void)
}
