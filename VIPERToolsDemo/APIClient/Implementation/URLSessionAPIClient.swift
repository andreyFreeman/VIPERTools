//
//  TinyAPIClient.swift
//  VIPERToolsDemo
//
//  Created by ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//

import Foundation

final public class TinyAPIClient: APIClient {
    
    enum Error: Swift.Error {
        case badUrlSupplied(url: StringRepresentable)
    }
    
    let session: URLSession
    public var baseUrl: URL
    public var commonHeaders: RequestHeaders
    public var commonParams: RequestParams
    
    let middleware: [Middleware]
    let formatJSON: ResponseFormatter
    
    public convenience init(baseUrl: URL, commonHeaders: RequestHeaders = [:], commonParams: RequestParams = [:]) {
        self.init(baseUrl: baseUrl, commonHeaders: commonHeaders, commonParams: commonParams, session: URLSession(configuration: .default))
    }
    
    public init(baseUrl: URL, commonHeaders: RequestHeaders = [:], commonParams: RequestParams = [:], session: URLSession) {
        self.session = session
        self.baseUrl = baseUrl
        self.commonHeaders = commonHeaders
        self.commonParams = commonParams
        
        let middleware: [Middleware] = [
            ValidateResponseError(),
            ValidateStatusCode()
        ]
        let final = FormatJSONResponse()
        self.formatJSON = JSONResponseFormatter {
            return try middleware.chain(to: final).format(response: $0)
        }
        self.middleware = middleware
    }
    
    public func run(
        apiCall call: StringRepresentable,
        method: HTTPMethod,
        parameters: RequestParams?,
        customHeaders: RequestHeaders?,
        completion: @escaping (RequestResult<JSONObject, APIClientError>) -> Void) throws
    {
        try runRaw(apiCall: call, method: method, parameters: parameters, customHeaders: customHeaders) { (data, response, error) in
            self.callExternalCompletion(completion, for: (data, response, error))
        }
    }
    
    public func runRaw(
        apiCall call: StringRepresentable,
        method: HTTPMethod,
        parameters: RequestParams?,
        customHeaders: RequestHeaders?,
        completion: @escaping RawRequestCompletion) throws
    {
        let request = try makeURLRequest(from: call, method: method, params: params(with: parameters), headers: headers(with: customHeaders))
        session.dataTask(with: request) { data, response, error in
            completion(data, response as? HTTPURLResponse, error)
        }
    }
    
    private func callExternalCompletion(
        _ completion: @escaping (RequestResult<JSONObject, APIClientError>) -> Void,
        for response: (Data?, HTTPURLResponse?, Swift.Error?)) {
        do {
            let json = try formatJSON.format(response: response)
            completion(.success(json))
        }
        catch let error {
            if let error = error as? APIClientError {
                completion(.fail(error))
            } else {
                completion(.fail(.nested(error)))
            }
        }
    }
}

fileprivate extension TinyAPIClient {
    func headers(with headers: RequestHeaders?) -> RequestHeaders {
        return commonHeaders+(headers ?? [:])
    }
    
    func params(with params: RequestParams?) -> RequestParams {
        return commonParams+(params ?? [:])
    }
    
    func makeURLRequest(from call: StringRepresentable, method: HTTPMethod, params: RequestParams, headers: RequestHeaders) throws -> URLRequest {
        
        let create:(URL) throws -> URLRequest = {
            var request = URLRequest(url: $0)
            request.httpMethod = method.rawValue
            headers.forEach {
                request.setValue($0.value, forHTTPHeaderField: $0.key)
            }
            return request
        }
        
        if call.isCompleteURL {
            guard let url = URL(string: call.stringValue) else {
                throw Error.badUrlSupplied(url: call.stringValue)
            }
            return try create(url)
        }
        
        return try create(baseUrl.appendingPathComponent(call.stringValue))
    }
}

fileprivate extension HTTPMethod {
    func makeQuery(from params: RequestParams) throws -> String {
        var query: String?
        switch self {
        case .get:
            var result = params.reduce("?") {
                $0+"\($1.key)=\($1.value)&"
            }
            result.characters.removeLast()
            query = result
        default:
            query = params.reduce("") {
                $0+($0.isEmpty ? "" : "&")+"\($1.key)=\($1.value)"
            }
        }
        
        guard let result = query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw TinyAPIClient.Error.badUrlSupplied(url: query ?? "")
        }
        
        return result
    }
}

fileprivate extension StringRepresentable {
    var isCompleteURL: Bool {
        let value = stringValue
        return value.hasPrefix("http://") || value.hasPrefix("https://")
    }
}

fileprivate func + <K,V>(left: Dictionary<K,V>, right: Dictionary<K,V>) -> Dictionary<K,V> {
    var map = Dictionary<K,V>()
    for (k, v) in left {
        map[k] = v
    }
    for (k, v) in right {
        map[k] = v
    }
    return map
}
