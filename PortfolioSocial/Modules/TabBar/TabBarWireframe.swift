//
//  TabBarWireframe.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 11.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

enum RootTabBarsItem: Int {

    case home = 0
    case search
    case addPost
    case activity
    case profile

    static var homeController: BaseWireframe?
    static var userSearchController: BaseWireframe?
    static var addPostController: BaseWireframe?
    static var activityController: BaseWireframe?
    static var profileController: BaseWireframe?

    static func initialize() {
        homeController =  HomeFeedWireframe.init()
        userSearchController = SearchViewWireframe.init()
        addPostController =  AddPostWireframe.init()
        activityController =  ActivityWireframe.init()
        profileController = ProfileScreenWireframe.init(uuid: "")
    }

    static func controllers() -> [UIViewController] {
        return [homeController!.viewController,
                userSearchController!.viewController,
                addPostController!.viewController,
                activityController!.viewController,
                profileController!.viewController]
    }
}

class TabBarWireframe: BaseWireframe {

    // MARK: - Private properties -
    var titles = ["Home", "Search", "Post", "Liked", "Profile"]
    var tabBarViewControllers = [UINavigationController]()

    fileprivate weak var view: (UITabBarController)?

    // MARK: - Module setup -

    init(isFirstTime: Bool) {
        RootTabBarsItem.initialize()
        let moduleViewController = TabBarViewController()
        moduleViewController.isFirstTime = isFirstTime
        super.init(viewController: moduleViewController)

        let controllers = RootTabBarsItem.controllers()
        for controller in controllers {
            let navController = RootNavigationController()
            navController.setViewControllers([controller], animated: false)
            tabBarViewControllers.append(navController)
        }
        moduleViewController.selectedIndex = 4
        moduleViewController.viewControllers = tabBarViewControllers
        let interactor = TabBarInteractor()
        let presenter = TabBarPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }
}

// MARK: - Extensions -

extension TabBarWireframe: TabBarWireframeInterface {
}
