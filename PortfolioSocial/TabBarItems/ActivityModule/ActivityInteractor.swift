//
//  ActivityInteractor.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 07.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

class ActivityInteractor {
    var presenter: ActivityPresenterInterface!
    var activityService: ActivityService?
    var followService: FollowService?
    var postService: PostService?
    var userService: UserService?
    var profileService: ProfileService?
}

// MARK: - Extensions -

extension ActivityInteractor: ActivityInteractorInterface {
    func getEvents() {
        activityService?.activity(from: User.current!.uid, completion: { [weak self] (result) in
            self?.presenter.recievedEvents(events: result)
        })
    }
    
    func getProfilePhoto(from username: String, completion: @escaping (String) -> Void) {
        userService?.getUUID(from: username, completion: { [weak self](uuid) in
            self?.profileService?.profileImage(for: uuid, completion: { (url) in
                completion(url)
            })
        })
    }
    
    func getUserUUID(from username: String, completion: @escaping (String, Bool) -> Void) {
        userService?.getUUID(from: username, completion: { [weak self] (uuid) in
            self?.followService?.isUserFollowed(uuid, byCurrentUserWithCompletion: { (isFollowed) in
                completion(uuid, isFollowed)
            })
        })
    }
    
    func setFollowStatus(with isFollowing: Bool, uuid: String) {
        followService?.setIsFollowing(isFollowing, fromCurrentUserTo: uuid)
    }
    
    func getPost(from key: String, completion: @escaping (Post?) -> Void) {
        postService?.show(forKey: key, posterUID: User.current!.uid, completion: { (post) in
            completion(post)
        })
    }
    
   
}
