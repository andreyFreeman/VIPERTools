//
//  SearchMoviesPresenter.swift
//  VIPERToolsDemo
//
//  Created ANDREY KLADOV on 10/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//
//

import UIKit

final class SearchMoviesPresenter {

    fileprivate weak var view: SearchMoviesViewProtocol!
    fileprivate let interactor: SearchMoviesInteractorProtocol
    fileprivate let router: SearchMoviesWireframeProtocol
    
    weak var output: SearchMoviesOutput?

    init(view: SearchMoviesViewProtocol, interactor: SearchMoviesInteractorProtocol, router: SearchMoviesWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SearchMoviesPresenter: SearchMoviesViewPresenter {
    func viewLoaded() {
        view?.title = "SearchMovies"
    }
}

extension SearchMoviesPresenter: SearchMoviesInteractorPresenter {
    
}

extension SearchMoviesPresenter: SearchMoviesIO {
    
}
