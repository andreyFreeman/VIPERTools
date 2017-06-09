//
//  NavigatorPresenter.swift
//  VIPERToolsDemo
//
//  Created ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//
//

import UIKit

final class NavigatorPresenter {

    fileprivate weak var view: NavigatorViewProtocol!
    fileprivate let interactor: NavigatorInteractorProtocol
    let router: NavigatorWireframeProtocol
    
    weak var output: NavigatorOutput?

    init(view: NavigatorViewProtocol, interactor: NavigatorInteractorProtocol, router: NavigatorWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension NavigatorPresenter: NavigatorViewPresenter {
    
}

extension NavigatorPresenter: NavigatorInteractorPresenter {
    
}

extension NavigatorPresenter: NavigatorIO {
    func showLoader(animated: Bool) {
        router.navigateToLoader(with: self, animated: animated)
    }
}
