//
//  FormatJSONResponse.swift
//  VIPERToolsDemo
//
//  Created by ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//

import Foundation

struct FormatJSONResponse: ResponseFormatter {
    func format(response: RawResponse) throws -> JSONObject {
        
        guard let data = response.0 else {
            throw APIClientError.responseValidationFailed(reason: APIClientError.ValidationFailureReason.dataFileNil)
        }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSONObject {
                return json
            } else {
                throw APIClientError.responseValidationFailed(reason: .unexpectedFormat)
            }
        } catch let jsonError {
            throw APIClientError.responseSerializationFailed(reason: .jsonSerializationFailed(error: jsonError))
        }
    }
}
