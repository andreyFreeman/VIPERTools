//
//  LoaderProtocols.swift
//  VIPERToolsDemo
//
//  Created ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//
//

import Foundation

// MARK: - Wireframe

protocol LoaderWireframeProtocol: class {
    
}

// MARK: - Presenter

protocol LoaderViewPresenter: class {
    func viewLoaded()
}

protocol LoaderInteractorPresenter: class {
    func didStartLoading()
    func didFinishLoading()
}

typealias LoaderPresenterProtocol = LoaderViewPresenter & LoaderInteractorPresenter

// MARK: - Interactor

protocol LoaderInteractorProtocol: class {
    func startLoading()
}

// MARK: - View

protocol LoaderViewProtocol: class {
    var title: String? { set get }
    func showLoading()
    func hideLoading()
}

// MARK: - IO

protocol LoaderInput: class {
    
}

protocol LoaderOutput: class {
    func loaderDidFinish(_ input: LoaderIO)
}

protocol LoaderIO: class, LoaderInput {
    weak var output: LoaderOutput? { set get }
}
