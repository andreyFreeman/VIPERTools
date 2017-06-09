//
//  NSOperationQueue.Serial.swift
//  UltimateGuitar
//
//  Created by ANDREY KLADOV on 30/11/2016.
//
//

import Foundation

public extension OperationQueue {
    public class func serialQueue(qualityOfService: QualityOfService = .default) -> OperationQueue {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = qualityOfService
        return queue
    }
    public func addOperations(_ operations: [Operation]) {
        addOperations(operations, waitUntilFinished: false)
    }
}

public extension Operation {
    public func addDependencies(_ operations: [Operation]) {
        for operation in operations {
            addDependency(operation)
        }
    }
}
