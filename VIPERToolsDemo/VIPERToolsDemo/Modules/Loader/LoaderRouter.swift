//
//  LoaderRouter.swift
//  VIPERToolsDemo
//
//  Created ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//
//

import UIKit
import ServiceLocator

final class LoaderRouter: LoaderWireframeProtocol {
    
    weak var view: UIViewController?
    
    static func createModule(output: LoaderOutput? = nil) throws -> ViperModule<UIViewController, LoaderIO> {
        let view = LoaderViewController(nibName: nil, bundle: nil)
        let interactor = LoaderInteractor(service: try inject())
        let router = LoaderRouter()
        let presenter = LoaderPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.output = output
        
        return ViperModule(view: view, input: presenter)
    }
    
    func onFinish() {
        
    }
}
