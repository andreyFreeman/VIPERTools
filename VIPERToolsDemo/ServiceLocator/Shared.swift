//
//  Shared.swift
//  VIPERTools
//
//  Created by ANDREY KLADOV on 09/07/2017.
//  Copyright © 2017 Andrey Kladov. All rights reserved.
//

import Foundation

var shared: ServiceLocator = ServiceLoader.shared

// MARK: - Useful static methods

public func register<Service>(_ factory: @escaping () throws -> Service) {
    shared.register(factory)
}

public func inject<Service>() throws -> Service {
    return try shared.inject()
}

// MARK: - Shared service locator support

public func setupShared(serviceLocator: ServiceLocator) {
    shared = serviceLocator
}
