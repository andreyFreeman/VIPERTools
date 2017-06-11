//
//  NavigatorPresenter.Outputs.swift
//  VIPERToolsDemo
//
//  Created by ANDREY KLADOV on 10/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//

import Foundation

extension NavigatorPresenter: LoaderOutput {
    func loaderDidFinish(_ input: LoaderIO) {
        router.navigateToMainSearch(with: self)
    }
}

extension NavigatorPresenter: SearchMoviesOutput {
    
}
