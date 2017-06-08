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

protocol ___FILEBASENAMEASIDENTIFIER___WireframeProtocol: class {

}

// MARK: - Presenter

protocol ___FILEBASENAMEASIDENTIFIER___ViewPresenter: class {
    func viewLoaded()
}

protocol ___FILEBASENAMEASIDENTIFIER___InteractorPresenter: class {
    
}

typealias ___FILEBASENAMEASIDENTIFIER___PresenterProtocol = ___FILEBASENAMEASIDENTIFIER___ViewPresenter & ___FILEBASENAMEASIDENTIFIER___InteractorPresenter

// MARK: - Interactor

protocol ___FILEBASENAMEASIDENTIFIER___InteractorProtocol: class {
    
}

// MARK: - View

protocol ___FILEBASENAMEASIDENTIFIER___ViewProtocol: class {
    var title: String? { set get }
}

// MARK: - IO

protocol ___FILEBASENAMEASIDENTIFIER___Input: class {
    
}

protocol ___FILEBASENAMEASIDENTIFIER___Output: class {

}
