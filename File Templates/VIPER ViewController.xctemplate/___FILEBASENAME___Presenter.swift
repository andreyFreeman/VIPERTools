//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class ___FILEBASENAMEASIDENTIFIER___Presenter {

    fileprivate weak var view: ___FILEBASENAMEASIDENTIFIER___ViewProtocol!
    fileprivate let interactor: ___FILEBASENAMEASIDENTIFIER___InteractorProtocol
    fileprivate let router: ___FILEBASENAMEASIDENTIFIER___WireframeProtocol
    
    weak var output: ___FILEBASENAMEASIDENTIFIER___Output?

    init(view: ___FILEBASENAMEASIDENTIFIER___ViewProtocol, interactor: ___FILEBASENAMEASIDENTIFIER___InteractorProtocol, router: ___FILEBASENAMEASIDENTIFIER___WireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension ___FILEBASENAMEASIDENTIFIER___Presenter: ___FILEBASENAMEASIDENTIFIER___ViewPresenter {
    func viewLoaded() {
        view?.title = "___FILEBASENAMEASIDENTIFIER___"
    }
}

extension ___FILEBASENAMEASIDENTIFIER___Presenter: ___FILEBASENAMEASIDENTIFIER___InteractorPresenter {
    
}

extension ___FILEBASENAMEASIDENTIFIER___Presenter: ___FILEBASENAMEASIDENTIFIER___IO {
    
}
