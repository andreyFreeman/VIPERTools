//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class ___VARIABLE_moduleName___Presenter {

    fileprivate weak var view: ___VARIABLE_moduleName___ViewProtocol!
    fileprivate let interactor: ___VARIABLE_moduleName___InteractorProtocol
    fileprivate let router: ___VARIABLE_moduleName___WireframeProtocol
    
    weak var output: ___VARIABLE_moduleName___Output?

    init(view: ___VARIABLE_moduleName___ViewProtocol, interactor: ___VARIABLE_moduleName___InteractorProtocol, router: ___VARIABLE_moduleName___WireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension ___VARIABLE_moduleName___Presenter: ___VARIABLE_moduleName___ViewPresenter {
    func viewLoaded() {
        view?.title = "___VARIABLE_moduleName___"
    }
}

extension ___VARIABLE_moduleName___Presenter: ___VARIABLE_moduleName___InteractorPresenter {
    
}

extension ___VARIABLE_moduleName___Presenter: ___VARIABLE_moduleName___IO {
    
}
