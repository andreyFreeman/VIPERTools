//
//  LoaderInteractor.swift
//  VIPERToolsDemo
//
//  Created ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//
//

import UIKit
import Services

final class LoaderInteractor: LoaderInteractorProtocol {
    
    weak var presenter: LoaderInteractorPresenter?
    
    let service: ServicesPrepare
    init(service: ServicesPrepare) {
        self.service = service
    }
    
    func startLoading() {
        service.prepare { [weak self] in
            self?.presenter?.didFinishLoading()
        }
    }
}
