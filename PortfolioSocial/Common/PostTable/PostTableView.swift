//
//  HomeFeedViewController.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 07.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol PostTableViewDelegate {
    func clickedUsername(with username: String)
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostTableCell)
}

class PostTableView: UITableView {
    
    // MARK: - Public properties -
    var tableView = UITableView()
    var postList: [Post]?
    var tableViewDelegate: PostTableViewDelegate?
    // MARK: - Lifecycle -

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(PostTableCell.self, forCellReuseIdentifier: "TableViewCell")
        rowHeight = frame.width + 201
        dataSource = self
        delegate = self
        allowsSelection = false
        backgroundColor = UIColor(rgb: 0xFAFAFA)
    }
    
    convenience init(frame: CGRect, style: UITableView.Style, posts: [Post]) {
        self.init(frame: frame, style: style)
        self.postList = posts
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateWithPostsList(posts: [Post]) {
        postList = posts
        self.reloadData()
    }
    

    @objc func pressedOnUsername(sender: Any) {
        let name : String = ((sender as! UsernameButton).username)!
        tableViewDelegate?.clickedUsername(with: name)
    }
}

// MARK: - Extensions -
extension PostTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList?.count ?? 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: PostTableCell.identifier, for: indexPath) as! PostTableCell
        
        if let posts = postList {
            myCell.shimmerView.removeFromSuperview()
            myCell.shimmerView.stopShimmeringEffect()
            myCell.contentView.isUserInteractionEnabled = false
            myCell.frame.size = frame.size
            
            let slice = posts[indexPath.row]
            
            myCell.setupProfileImage(info: slice)
            myCell.setupTopNameButton(name: slice.poster)
            myCell.setupMainImageView(imageURL: slice.imageURL)
            myCell.setupLikeButton(isLiked: slice.isLiked)
            myCell.delegate = self
            if !slice.caption.isEmpty {
                myCell.setupBottonNameButton(name: slice.poster)
                myCell.setupCaptionLabel(caption: slice.caption)
                myCell.setupDateLabel(date: slice.creationDate, captionExists: true)
            } else {
                myCell.setupDateLabel(date: slice.creationDate, captionExists: false)
            }
            
            myCell.backgroundColor = .white
            myCell.setupLikeLabel(with: String(slice.likeCount))
            myCell.topNameButton.tag = indexPath.row
            myCell.bottomNameButton.tag = indexPath.row
            myCell.topNameButton.addTarget(self, action: #selector(pressedOnUsername(sender:)), for: .touchDown)
            myCell.bottomNameButton.addTarget(self, action: #selector(pressedOnUsername(sender:)), for: .touchDown)
        } else {
            myCell.shimmerView.backgroundColor = UIColor(rgb: 0xEDEDED)
            myCell.shimmerView.startShimmeringEffect()
        }
        myCell.backgroundColor = UIColor(rgb: 0xFAFAFA)
        
        
        return myCell
        
    }
}

extension PostTableView: PostActionCellDelegate {
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostTableCell) {
        tableViewDelegate?.didTapLikeButton(likeButton, on: cell)
    }

}