//
//  APIClient.swift
//  BeautyCam
//
//  Created by ANDREY KLADOV on 27/02/2017.
//  Copyright © 2017 Andrey Kladov. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public typealias RequestHeaders = [String: String]
public typealias RequestParams = [String: Any]
public typealias JSONObject = [String: Any]
public typealias ProgressCallback = (Int64, Int64) -> Void
public typealias RawResponse = (Data?, HTTPURLResponse?, Error?)
public typealias RawRequestCompletion = (Data?, HTTPURLResponse?, Error?) -> Void

public protocol StringRepresentable {
    var stringValue: String { get }
}

extension StringRepresentable where Self: RawRepresentable, Self.RawValue == String {
    public var stringValue: String {
        return rawValue
    }
}

public enum RequestResult<T, E> {
    case success(T)
    case fail(E)
}

public protocol APIClient {
    
    var baseUrl: URL { get }
    var commonHeaders: RequestHeaders { set get }
    var commonParams: RequestParams { set get }
    
    func run(
        apiCall call: StringRepresentable,
        method: HTTPMethod,
        parameters: RequestParams?,
        customHeaders: RequestHeaders?,
        completion: @escaping (RequestResult<JSONObject, APIClientError>) -> Void) throws
    
    func runRaw(
        apiCall call: StringRepresentable,
        method: HTTPMethod,
        parameters: RequestParams?,
        customHeaders: RequestHeaders?,
        completion: @escaping RawRequestCompletion) throws
}

extension String: StringRepresentable {
    public var stringValue: String { return self }
}
