//
//  ServicesHUB.swift
//  Services
//
//  Created by ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//

import Foundation
import APIClient
import ConcurrentOperation
import CoreData
import EasyCoreData
import Model
import ServiceLocator

public func setupServices() {
    let hub = ServiceHUB.shared
    register({ hub as ServicesPrepare })
}

final class ServiceHUB: ServicesPrepare {
    
    enum Error: Swift.Error {
        case serviceUnavaiable
    }
    
    private enum Consts {
        static let url = URL(string: "http://www.omdbapi.com/")!
    }
    
    static let shared = ServiceHUB()
    
    let client: APIClient = TinyAPIClient(baseUrl: Consts.url, commonHeaders:
        [
            "Content-Type" : "application/json"
        ]
    )
    private(set) var contextState: OperationResult<NSManagedObjectContext> = .pending
    private let operationQueue: OperationQueue
    
    init(operationQueue: OperationQueue = OperationQueue()) {
        self.operationQueue = operationQueue
    }
    
    func prepare(handler: @escaping () -> Void) {
        let finish = BlockOperation {
            print("\(self): loading is done")
        }
        finish.completionBlock = handler
        
        let coreData = LoadCoreDataStackOperation(coreData: EasyCoreData.sharedInstance)
        coreData.completionBlock = { [unowned coreData] in
            self.contextState = coreData.result
        }
        finish.addDependency(coreData)
        operationQueue.addOperations([coreData, finish])
    }
}
