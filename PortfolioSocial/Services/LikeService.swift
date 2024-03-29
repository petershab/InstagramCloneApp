//
//  LikeService.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 4/15/21.
//

import Foundation
import FirebaseDatabase

class LikeService {
    func create(for post: Post, success: @escaping (Bool) -> Void) {
        guard let key = post.key else {
            return success(false)
        }

        let currentUID = User.current!.uid
        let baseRef =  Database.database().reference()
        let likesRef = Database.database().reference().child("postLikes").child(key).child(currentUID)
        likesRef.setValue(true) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return success(false)
            }

            UserService().getUUID(from: post.poster, completion: { (uuid) in
                let likesRef = Database.database().reference().child("postLikes").child(key).child(currentUID)
                likesRef.setValue(true) { (error, _) in
                    if let error = error {
                        assertionFailure(error.localizedDescription)
                        return success(false)
                    }

                    let likeCountRef = baseRef.child("posts").child(uuid).child(key).child("like_count")
                    likeCountRef.runTransactionBlock({ (mutableData) -> TransactionResult in
                        let currentCount = mutableData.value as? Int ?? 0
                        mutableData.value = currentCount + 1
                        return TransactionResult.success(withValue: mutableData)
                    }, andCompletionBlock: { (error, _, _) in
                        if let error = error {
                            assertionFailure(error.localizedDescription)
                            success(false)
                        } else {
                            ActivityService().createEvent(forURLString: key, from: post.poster, completion: { (bool) in
                                success(bool)
                            })
                        }
                    })
                }
            })
        }
    }

    func delete(for post: Post, success: @escaping (Bool) -> Void) {
        guard let key = post.key else {
            return success(false)
        }
        let currentUID = User.current!.uid
        let baseRef =  Database.database().reference()
        let likesRef = baseRef.child("postLikes").child(key).child(currentUID)
        likesRef.setValue(nil) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return success(false)
            }

            UserService().getUUID(from: post.poster, completion: { (uuid) in
                let likesRef = baseRef.child("postLikes").child(key).child(currentUID)
                likesRef.setValue(nil) { (error, _) in
                    if let error = error {
                        assertionFailure(error.localizedDescription)
                        return success(false)
                    }

                    let likeCountRef = baseRef.child("posts").child(uuid).child(key).child("like_count")
                    likeCountRef.runTransactionBlock({ (mutableData) -> TransactionResult in
                        let currentCount = mutableData.value as? Int ?? 0
                        mutableData.value = currentCount - 1
                        return TransactionResult.success(withValue: mutableData)
                    }, andCompletionBlock: { (error, _, _) in
                        if let error = error {
                            assertionFailure(error.localizedDescription)
                            success(false)
                        } else {
                            ActivityService().deleteEvent(forURLString: key,
                                                          from: uuid,
                                                          completion: { (bool) in
                                success(bool)
                            })
                        }
                    })
                }
            })
        }
    }

    func isPostLiked(_ post: Post, byCurrentUserWithCompletion completion: @escaping (Bool) -> Void) {
        guard let postKey = post.key else {
            assertionFailure("Error: post must have key.")
            return completion(false)
        }

        let likesRef = Database.database().reference().child("postLikes").child(postKey)
        likesRef.queryEqual(toValue: nil, childKey: User.current!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? [String: Bool] {
                completion(true)
            } else {
                completion(false)
            }
        })
    }

    func setIsLiked(_ isLiked: Bool, for post: Post, success: @escaping (Bool) -> Void) {
        if isLiked {
            create(for: post, success: success)
        } else {
            delete(for: post, success: success)
        }
    }
}
