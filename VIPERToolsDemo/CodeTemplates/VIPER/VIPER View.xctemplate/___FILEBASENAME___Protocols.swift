//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: - Wireframe

protocol ___VARIABLE_moduleName___WireframeProtocol: class {

}

// MARK: - Presenter

protocol ___VARIABLE_moduleName___ViewPresenter: class {
    
}

protocol ___VARIABLE_moduleName___InteractorPresenter: class {
    
}

typealias ___VARIABLE_moduleName___PresenterProtocol = ___VARIABLE_moduleName___ViewPresenter & ___VARIABLE_moduleName___InteractorPresenter

// MARK: - Interactor

protocol ___VARIABLE_moduleName___InteractorProtocol: class {
    
}

// MARK: - View

protocol ___VARIABLE_moduleName___ViewProtocol: class {
    
}

// MARK: - IO

protocol ___VARIABLE_moduleName___Input: class {
    
}

protocol ___VARIABLE_moduleName___Output: class {

}

protocol ___VARIABLE_moduleName___IO: ___VARIABLE_moduleName___Input {
    weak var output: ___VARIABLE_moduleName___Output? { set get }
}
