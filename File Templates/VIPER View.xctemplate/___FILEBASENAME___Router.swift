//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class ___FILEBASENAMEASIDENTIFIER___Router: ___FILEBASENAMEASIDENTIFIER___WireframeProtocol {
    
    weak var view: UIView?
    weak var output: ___FILEBASENAMEASIDENTIFIER___Output?
    weak var input: ___FILEBASENAMEASIDENTIFIER___Input?
    
    static func createModule(output: ___FILEBASENAMEASIDENTIFIER___Output? = nil) throws -> ViperModule<UIView, ___FILEBASENAMEASIDENTIFIER___Input> {
        let view: ___FILEBASENAMEASIDENTIFIER___View = try .instantiateFromXib()
        let interactor = ___FILEBASENAMEASIDENTIFIER___Interactor()
        let router = ___FILEBASENAMEASIDENTIFIER___Router()
        let presenter = ___FILEBASENAMEASIDENTIFIER___Presenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        router.output = output
        router.input = presenter
        
        return ViperModule(view: view, input: presenter)
    }
}
