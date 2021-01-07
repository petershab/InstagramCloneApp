//
//  SearchViewPresenter.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 07.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class SearchViewPresenter {

    // MARK: - Private properties -

    private unowned let view: SearchViewViewInterface
    private let interactor: SearchViewInteractorInterface
    private let wireframe: SearchViewWireframeInterface

    // MARK: - Lifecycle -

    init(view: SearchViewViewInterface, interactor: SearchViewInteractorInterface, wireframe: SearchViewWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension SearchViewPresenter: SearchViewPresenterInterface {
}
