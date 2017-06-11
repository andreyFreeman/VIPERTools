//
//  ValidateStatusCode.swift
//  VIPERToolsDemo
//
//  Created by ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//

import Foundation

struct ValidateStatusCode: Middleware {
    
    let acceptableCodes: CountableRange<Int>
    init(acceptableCodes: CountableRange<Int> = 200..<300) {
        self.acceptableCodes = acceptableCodes
    }
    
    func format(response: RawResponse, chainingTo next: ResponseFormatter) throws -> JSONObject {
        
        guard let code = response.1?.statusCode else {
            throw APIClientError.responseValidationFailed(reason: APIClientError.ValidationFailureReason.dataFileNil)
        }
        
        guard case acceptableCodes = code else {
            throw APIClientError.responseValidationFailed(reason: APIClientError.ValidationFailureReason.unacceptableStatusCode(code: code))
        }
        
        return try next.format(response: response)
    }
}

