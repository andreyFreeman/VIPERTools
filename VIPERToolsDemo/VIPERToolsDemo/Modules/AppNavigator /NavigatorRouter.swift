//
//  NavigatorRouter.swift
//  VIPERToolsDemo
//
//  Created ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//
//

import UIKit

final class NavigatorRouter: NavigatorWireframeProtocol {
    
    fileprivate weak var view: UINavigationController?
    
    static func createModule(output: NavigatorOutput? = nil) throws -> ViperModule<UIViewController, NavigatorIO> {
        let view = NavigatorViewController()
        let interactor = NavigatorInteractor()
        let router = NavigatorRouter()
        let presenter = NavigatorPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.output = output
        
        return ViperModule(view: view, input: presenter)
    }
    
    func navigate(to view: UIViewController, mode: NavigatorInputMode, animated: Bool) {
        switch mode {
        case .push:
            self.view?.pushViewController(view, animated: animated)
        case .replace:
            self.view?.setViewControllers([view], animated: animated)
        }
    }
}
