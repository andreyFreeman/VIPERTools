//
//  SearchMoviesRouter.swift
//  VIPERToolsDemo
//
//  Created ANDREY KLADOV on 10/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//
//

import UIKit

final class SearchMoviesRouter: SearchMoviesWireframeProtocol {
    
    fileprivate weak var view: UIViewController?
    
    static func createModule(output: SearchMoviesOutput? = nil) throws -> ViperModule<UIViewController, SearchMoviesIO> {
        let view = SearchMoviesViewController(nibName: nil, bundle: nil)
        let interactor = SearchMoviesInteractor()
        let router = SearchMoviesRouter()
        let presenter = SearchMoviesPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.output = output
        
        return ViperModule(view: view, input: presenter)
    }
}
