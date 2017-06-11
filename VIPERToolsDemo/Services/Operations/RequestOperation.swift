//
//  RequestOperation.swift
//  BeautyCam
//
//  Created by ANDREY KLADOV on 01/03/2017.
//  Copyright © 2017 Andrey Kladov. All rights reserved.
//

import Foundation
import ConcurrentOperation
import APIClient

class RequestOperation: ConcurrentOperation, OperationResultProvider {
    
    private(set) public var result: OperationResult<JSONObject>
    
    let client: APIClient
    let callOrUrl: StringRepresentable
    let method: HTTPMethod
    let parameters: RequestParams?
    let customHeaders: RequestHeaders?
    
    public init(client: APIClient, callOrUrl: StringRepresentable, method: HTTPMethod = .get, parameters: RequestParams? = nil, customHeaders: RequestHeaders? = nil) {
        self.result = .pending
        self.client = client
        self.callOrUrl = callOrUrl
        self.method = method
        self.parameters = parameters
        self.customHeaders = customHeaders
        super.init()
    }
    
    public override func main() {
        
        guard !isCancelled else {
            result = .cancelled
            finish()
            return
        }
        
        do {
            try client.run(apiCall: callOrUrl, method: method, parameters: parameters, customHeaders: customHeaders) { requestResult in
                
                guard !self.isCancelled else {
                    self.result = .cancelled
                    self.finish()
                    return
                }
                
                switch requestResult {
                case .success(let object):
                    self.result = .success(object)
                case .fail(let error):
                    self.result = .fail(error)
                }
                self.finish()
            }
        }
        catch let error {
            finish()
        }
    }
}
