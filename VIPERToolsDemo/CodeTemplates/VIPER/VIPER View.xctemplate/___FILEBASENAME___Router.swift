//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class ___VARIABLE_moduleName___Router: ___VARIABLE_moduleName___WireframeProtocol {
    
    fileprivate weak var view: UIView?
    
    static func createModule(output: ___VARIABLE_moduleName___Output? = nil) throws -> ViperModule<UIView, ___VARIABLE_moduleName___IO> {
        let view: ___VARIABLE_moduleName___View = try .instantiateFromXib()
        let interactor = ___VARIABLE_moduleName___Interactor()
        let router = ___VARIABLE_moduleName___Router()
        let presenter = ___VARIABLE_moduleName___Presenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.output = output
        
        return ViperModule(view: view, input: presenter)
    }
}
