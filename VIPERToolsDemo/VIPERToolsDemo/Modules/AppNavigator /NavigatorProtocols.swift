//
//  NavigatorProtocols.swift
//  VIPERToolsDemo
//
//  Created ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//
//

import Foundation
import UIKit

// MARK: - Wireframe

protocol NavigatorWireframeProtocol: class {
    @discardableResult func navigateToLoader(with output: LoaderOutput?, animated: Bool) throws -> LoaderInput
    func navigate(to view: UIViewController, mode: NavigatorInputMode, animated: Bool)
}

// MARK: - Presenter

protocol NavigatorViewPresenter: class {
    
}

protocol NavigatorInteractorPresenter: class {
    
}

typealias NavigatorPresenterProtocol = NavigatorViewPresenter & NavigatorInteractorPresenter

// MARK: - Interactor

protocol NavigatorInteractorProtocol: class {
    
}

// MARK: - View

protocol NavigatorViewProtocol: class {
    
}

// MARK: - IO

enum NavigatorInputMode {
    case push
    case replace
}

protocol NavigatorInput: class {
    func showLoader(animated: Bool)
}
protocol NavigatorOutput: class {}
protocol NavigatorIO: class, NavigatorInput {
    weak var output: NavigatorOutput? { set get }
}
