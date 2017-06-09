//
//  Navigator.Initial.swift
//  VIPERToolsDemo
//
//  Created by ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//

import UIKit

extension NavigatorRouter {
    func navigateToLoader(with output: LoaderOutput?, animated: Bool) throws -> LoaderInput {
        let loader = try LoaderRouter.createModule(output: output)
        navigate(to: loader.view, mode: .replace, animated: animated)
        return loader.input
    }
}
