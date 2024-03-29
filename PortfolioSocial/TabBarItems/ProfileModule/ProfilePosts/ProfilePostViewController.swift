//
//  ProfilePostViewController.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 3/9/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import Foundation

class ProfilePostViewController: UIViewController {
    let contentView = UIView()
    var imageView = UIImageView()
    var tableView = PostTableView()
    var index = 0

    var postList = [Post]() {
        didSet {
            tableView = PostTableView(frame: view.frame, style: .plain, posts: postList)
            tableView.tableViewDelegate = self
            tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 201))
            tableView.reloadData()
        }
    }
    var onDoneBlock: ((Int) -> Void)?
    let dismissButton = UIButton(type: .system)
    var uuid = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
        dismissButton.setTitle("Back", for: .normal)
        dismissButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(dismissButton)
        imageView.layer.cornerRadius = 8
        view.addSubview(imageView)
        tableView.isHidden = true

    }

    override func viewDidAppear(_ animated: Bool) {
        if !tableView.isDescendant(of: view) {
            view.addSubview(tableView)
        }
        tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .middle, animated: false)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dismissButton.sizeToFit()
        dismissButton.center = CGPoint(x: 30, y: 30)
        imageView.frame = CGRect(x: 0, y: 117, width: view.frame.width, height: view.frame.width)
    }

    @objc func back() {
        tableView.isHidden = true
        navigationController?.popViewController(animated: true)
    }

    @objc func onTap() {
        back()
    }
}

extension ProfilePostViewController: PostTableViewDelegate {
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostTableCell) {
        guard let indexPath = self.tableView.indexPath(for: cell)
        else { return }

        likeButton.isUserInteractionEnabled = false
        let post = postList[indexPath.row]

        LikeService().setIsLiked(!post.isLiked, for: post) { (success) in
            defer {
                likeButton.isUserInteractionEnabled = true
            }

            guard success else { return }

            post.likeCount += !post.isLiked ? 1 : -1
            post.isLiked = !post.isLiked

            guard let cell = self.tableView.cellForRow(at: indexPath) as? PostTableCell
            else { return }

            DispatchQueue.main.async {
                cell.liked = post.isLiked
                cell.likeCount = post.likeCount
            }
        }
    }

    func clickedUsername(with username: String) {
        UserService().getUUID(from: username.capitalized, completion: { [weak self] (uuid) in
            let wireframe = ProfileScreenWireframe(uuid: uuid)
            self?.navigationController?.pushWireframe(wireframe)
        })
    }
}
