//
//  OMDbAPIService.swift
//  Services
//
//  Created by ANDREY KLADOV on 10/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//

import Foundation
import APIClient

class OMDbAPIService: SearchMoviesService {
    
    private enum APICall: String, StringRepresentable {
        case none = ""
    }
    
    let client: APIClient
    let operationQueue: OperationQueue
    
    init(client: APIClient, operationQueue: OperationQueue = OperationQueue()) {
        self.client = client
        self.operationQueue = operationQueue
    }
    
    func search(_ input: SearchMoviesResult, completion: @escaping (SearchMoviesServiceResult) -> Void) {
        let request = RequestOperation(
            client: client,
            callOrUrl: APICall.none,
            method: .get,
            parameters: input.requestParams
        )
        operationQueue.addOperations([request])
    }
    
    func details(forMovieWithId id: String, completion: @escaping (MovieDetailsServiceResult) -> Void) {
        
    }
}

fileprivate extension SearchMoviesResult {
    var requestParams: RequestParams {
        var params = additionalParams
        params["type"] = type.rawValue
        params["s"] = term
        if paging.page > 1 {
            params["page"] = "\(paging.page)"
        }
        return params
    }
}
