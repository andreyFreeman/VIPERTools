//
//  LoadCoreDataStackOperation.swift
//  Budgeteer
//
//  Created by ANDREY KLADOV on 30/11/2016.
//  Copyright © 2016 Andrey Kladov. All rights reserved.
//

import Foundation
import EasyCoreData
import CoreData
import ConcurrentOperation

final public class LoadCoreDataStackOperation: Operation, OperationResultProvider {
    
    public typealias DataType = NSManagedObjectContext
    public typealias Result = OperationResult<DataType>
    
    public let coreData: EasyCoreData
    private(set) public var result: Result = .pending
    
    public init(coreData: EasyCoreData) {
        self.coreData = coreData
        super.init()
    }
    
    override public func main() {
        
        guard !isCancelled else {
            result = .cancelled
            return
        }
        
        guard !coreData.coreDataStackLoaded else {
            result = .success(coreData.mainThreadManagedObjectContext)
            return
        }
        
        let fileManager = FileManager.default
        let modelName = "MoviesFinder"
        
        coreData.modelName = modelName
        coreData.modelBundle = Bundle(for: type(of: self))
        if let url = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.jobok.jobok")?.appendingPathComponent("\(modelName).sqlite") {
            coreData.sqliteStoreURL = url
        }
        coreData.setup()
        NSManagedObjectContext.setupMainThreadManagedObjectContext(coreData.mainThreadManagedObjectContext)
        result = .success(NSManagedObjectContext.mainThreadContext)
    }
    
    deinit {
        print("\(self).\(#function)")
    }
}
