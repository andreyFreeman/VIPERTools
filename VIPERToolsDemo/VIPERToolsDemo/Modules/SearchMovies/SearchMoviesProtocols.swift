//
//  SearchMoviesProtocols.swift
//  VIPERToolsDemo
//
//  Created ANDREY KLADOV on 10/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//
//

import Foundation

// MARK: - Wireframe

protocol SearchMoviesWireframeProtocol: class {

}

// MARK: - Presenter

protocol SearchMoviesViewPresenter: class {
    func viewLoaded()
}

protocol SearchMoviesInteractorPresenter: class {
    
}

typealias SearchMoviesPresenterProtocol = SearchMoviesViewPresenter & SearchMoviesInteractorPresenter

// MARK: - Interactor

protocol SearchMoviesInteractorProtocol: class {
    
}

// MARK: - View

protocol SearchMoviesViewProtocol: class {
    var title: String? { set get }
}

// MARK: - IO

protocol SearchMoviesInput: class {
    
}

protocol SearchMoviesOutput: class {
    
}

protocol SearchMoviesIO: class, SearchMoviesInput {
    weak var output: SearchMoviesOutput? { set get }
}
