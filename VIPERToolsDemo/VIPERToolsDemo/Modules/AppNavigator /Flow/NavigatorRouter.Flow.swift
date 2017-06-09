//
//  Navigator.Initial.swift
//  VIPERToolsDemo
//
//  Created by ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//

import UIKit

extension NavigatorRouter {
    func navigateToLoader(with output: LoaderOutput?, animated: Bool) {
        do {
            let loader = try LoaderRouter.createModule(output: output)
            navigate(to: loader.view, mode: .replace, animated: animated)
        }
        catch let error {
            print("\(self).\(#function) \(error)")
        }
    }
    
    func navigateToMainSearch(with output: SearchMoviesOutput?) {
        do {
            let module = try SearchMoviesRouter.createModule(output: output)
            navigate(to: module.view, mode: .replace, animated: true)
        }
        catch let error {
            print("\(self).\(#function) \(error)")
        }
    }
}
