//
//  ResponseProcessing.swift
//  VIPERToolsDemo
//
//  Created by ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//

import Foundation

protocol ResponseFormatter {
    func format(response: RawResponse) throws -> JSONObject
}

struct JSONResponseFormatter: ResponseFormatter {
    
    typealias Closure = (RawResponse) throws -> JSONObject
    
    let closure: Closure
    init(_ closure: @escaping Closure) {
        self.closure = closure
    }
    
    func format(response: RawResponse) throws -> JSONObject {
        return try self.closure(response)
    }
}

protocol Middleware {
    func format(response: RawResponse, chainingTo next: ResponseFormatter) throws -> JSONObject
}

extension Middleware {
    func chain(to responseFormatter: ResponseFormatter) -> ResponseFormatter {
        return JSONResponseFormatter { request in
            return try self.format(response: request, chainingTo: responseFormatter)
        }
    }
}

extension Collection where Iterator.Element == Middleware {
    func chain(to responseFormatter: ResponseFormatter) -> ResponseFormatter {
        return reversed().reduce(responseFormatter) { nextResponseFormatter, nextMiddleware in
            return JSONResponseFormatter { request in
                return try nextMiddleware.format(response: request, chainingTo: nextResponseFormatter)
            }
        }
    }
}
