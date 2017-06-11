//
//  ValidateResponseError.swift
//  VIPERToolsDemo
//
//  Created by ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//

import Foundation

struct ValidateResponseError: Middleware {
    func format(response: RawResponse, chainingTo next: ResponseFormatter) throws -> JSONObject {
        if let error = response.2 {
            throw APIClientError.nested(error)
        }
        return try next.format(response: response)
    }
}
