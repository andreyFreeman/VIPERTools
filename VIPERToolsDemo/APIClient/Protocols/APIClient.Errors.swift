//
//  APIClient.Errors.swift
//  Jobok
//
//  Created by ANDREY KLADOV on 02/05/2017.
//  Copyright © 2017 Jobok. All rights reserved.
//

import Foundation

public enum APIClientError: Error {
    
    public enum ValidationFailureReason {
        case dataFileNil
        case dataFileReadFailed(at: URL)
        case missingContentType(acceptableContentTypes: [String])
        case unacceptableContentType(acceptableContentTypes: [String], responseContentType: String)
        case unacceptableStatusCode(code: Int)
        case unexpectedFormat
    }
    
    public enum SerializationFailureReason {
        case inputDataNil
        case inputDataNilOrZeroLength
        case inputFileNil
        case inputFileReadFailed(at: URL)
        case stringSerializationFailed(encoding: String.Encoding)
        case jsonSerializationFailed(error: Error)
        case propertyListSerializationFailed(error: Error)
    }
    
    case responseSerializationFailed(reason: SerializationFailureReason)
    case responseValidationFailed(reason: ValidationFailureReason)
    case invalidURL(url: StringRepresentable)
    case unknownError
    case nested(Error)
    
    case notImplemented
}
