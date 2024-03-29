//
//  HomeFeedInteractor.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 07.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

class HomeFeedInteractor {
    var presenter: HomeFeedPresenter?
    var followService: FollowService?
    var userService: UserService?
    var likeService: LikeService?
}

// MARK: - Extensions -

extension HomeFeedInteractor: HomeFeedInteractorInterface {
    func getTimeline() {
        userService?.timeline(completion: { [weak self] (posts) in
            self?.presenter?.recievedTimeline(posts: posts)
        })
    }

    func getUUID(from username: String) {
        userService?.getUUID(from: username, completion: { [weak self] (uuid) in
            self?.followService?.isUserFollowed(uuid, byCurrentUserWithCompletion: { [weak self] (bool) in
                self?.presenter?.recieved(uuid: uuid, isFollowed: bool)
            })
        })
    }

    func likedPost(isLiked: Bool, post: Post, completion: @escaping (Bool) -> Void) {
        likeService?.setIsLiked(!post.isLiked, for: post) { (success) in
            completion(success)
        }
    }
}
