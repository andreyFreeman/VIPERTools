//
//  ServicesHUB.swift
//  VIPERTools
//
//  Created by ANDREY KLADOV on 01/05/2017.
//  Copyright © 2017 Jobok. All rights reserved.
//

import Foundation

public protocol ServiceLocator: class {
    func register<Service>(_ factory: @escaping () throws -> Service)
    func inject<Service>() throws -> Service
}
