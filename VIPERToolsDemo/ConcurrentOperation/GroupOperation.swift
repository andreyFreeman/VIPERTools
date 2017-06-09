//
//  GroupOperation.swift
//  UltimateGuitar
//
//  Created by ANDREY KLADOV on 30/11/2016.
//
//

import Foundation

open class GroupOperation: Operation {
    
    public let operationQueue: OperationQueue
    private(set) public var operations: [Operation]
    
    public init(operationQueue: OperationQueue = OperationQueue(), operations: [Operation]) {
        self.operationQueue = operationQueue
        self.operations = operations
        super.init()
    }
    
    open override func cancel() {
        super.cancel()
        operationQueue.cancelAllOperations()
    }
    
    open override func main() {
        
        guard !isCancelled else {
            return
        }
        
        operationQueue.addOperations(operations, waitUntilFinished: true)
    }
}
