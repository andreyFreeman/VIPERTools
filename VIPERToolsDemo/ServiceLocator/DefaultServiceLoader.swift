//
//  ServicesHUB.Integration.swift
//  Jobok
//
//  Created by ANDREY KLADOV on 01/05/2017.
//  Copyright © 2017 Jobok. All rights reserved.
//

import Foundation

public func register<Service>(_ factory: @escaping () throws -> Service) {
    ServiceLoader.register(factory)
}

public func inject<Service>() throws -> Service {
    return try ServiceLoader.inject()
}

public final class ServiceLoader: ServiceLocator {
    
    enum Error: Swift.Error {
        case notFound
    }
    
    private var registry: [ObjectIdentifier : () throws -> Any] = [:]
    
    public static var shared: ServiceLocator = ServiceLoader()
    public init() {}
    
    // MARK: - Registration
    
    public func register<Service>(_ factory: @escaping () throws -> Service) {
        registry[ObjectIdentifier(Service.self)] = factory
    }
    
    public static func register<Service>(_ factory: @escaping () throws -> Service) {
        shared.register(factory)
    }
    
    // MARK: - Injection
    
    public static func inject<Service>() throws -> Service {
        return try shared.inject()
    }
    
    public func inject<Service>() throws -> Service {
        guard let service = try registry[ObjectIdentifier(Service.self)]?() as? Service else {
            throw Error.notFound
        }
        return service
    }
}
