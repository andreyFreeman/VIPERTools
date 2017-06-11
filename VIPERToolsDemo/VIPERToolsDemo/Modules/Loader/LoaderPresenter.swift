//
//  LoaderPresenter.swift
//  VIPERToolsDemo
//
//  Created ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//
//

import UIKit

final class LoaderPresenter {

    fileprivate weak var view: LoaderViewProtocol!
    fileprivate let interactor: LoaderInteractorProtocol
    fileprivate let router: LoaderWireframeProtocol
    
    weak var output: LoaderOutput?

    init(view: LoaderViewProtocol, interactor: LoaderInteractorProtocol, router: LoaderWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension LoaderPresenter: LoaderViewPresenter {
    func viewLoaded() {
        view?.title = "Loader"
        interactor.startLoading()
    }
}

extension LoaderPresenter: LoaderInteractorPresenter {
    
    func didStartLoading() {
        DispatchQueue.main.async {
            self.view.showLoading()
        }
    }
    
    func didFinishLoading() {
        DispatchQueue.main.async {
            self.view?.hideLoading()
            self.output?.loaderDidFinish(self)
        }
    }
}

extension LoaderPresenter: LoaderIO {
    
}
