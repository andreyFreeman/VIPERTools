//
//  Result.swift
//  Budgeteer
//
//  Created by ANDREY KLADOV on 16/04/2017.
//  Copyright © 2017 Andrey Kladov. All rights reserved.
//

import Foundation

public enum OperationResult<T> {
    
    enum ExtractDataError : Swift.Error {
        case noData
    }
    
    case cancelled
    case pending
    case success(T)
    case fail(Error)
    
    public func value() throws -> T {
        if case .success(let object) = self {
            return object
        }
        if case .fail(let error) = self {
            throw error
        }
        throw ExtractDataError.noData
    }
    
    public var error: Error? {
        if case .fail(let error) = self {
            return error
        }
        return nil
    }
}

extension OperationResult: CustomStringConvertible {
    public var description: String {
        switch self {
        case .cancelled:
            return "Result.cancelled"
        case .pending:
            return "Result.pending"
        case .success(let object):
            return "Result.success(\(object))"
        case .fail(let error):
            return "Result.fail(\(error))"
        }
    }
}

public protocol OperationResultProvider {
    
    associatedtype DataType
    
    var result: OperationResult<DataType> { get }
}

public class OperationResultReProvider<T, P: OperationResultProvider>: OperationResultProvider where P.DataType == T {
    
    public typealias DataType = T
    public typealias Provider = P
    
    public let provider: Provider
    
    private var _settedResult: OperationResult<T>?
    
    public init(provider: Provider) {
        self.provider = provider
    }
    
    public func resetupResult(_ result: OperationResult<T>?) {
        _settedResult = result
    }
    
    public var result: OperationResult<T> {
        if let result = _settedResult {
            return result
        }
        return provider.result
    }
}
