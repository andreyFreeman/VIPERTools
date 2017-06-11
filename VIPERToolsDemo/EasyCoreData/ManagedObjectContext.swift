//
//  ManagedObjectContext.swift
//  EasyCoreData
//
//  Created by Andrey Kladov on 02/04/15.
//  Copyright (c) 2015 Andrey Kladov. All rights reserved.
//

import Foundation
import CoreData

public extension NSManagedObjectContext {
    
    fileprivate struct StaticStorage {
        static weak var customMainThreadManagedObjectContext: NSManagedObjectContext!
    }
    
    /**
     
     if you are going to use your own NSManagedObjectContext, but still want to use NSManagedObjectContext and NSManagedObject extensions, you can setup it here
     **Warning! Weak reference will be stored. Stored NSManagedObjectContext will be overwritten by 'EasyCoreData.setup()' call**

     - parameter context: context you would like to use as a main thread context with this EasyCoreData extensions. *
     
     */
    public class func setupMainThreadManagedObjectContext(_ context: NSManagedObjectContext!) {
        StaticStorage.customMainThreadManagedObjectContext = context
    }
    
}

public extension NSManagedObjectContext {
    /**
     
     Main NSManagedObjectContext will be returned. See EasyCoreData.sharedInstance.mainThreadManagedObjectContext for more information.
     If method setupMainThreadManagedObjectContext was used, custom NSManagedObjectContext will be returned
     
     */
    class var mainThreadContext: NSManagedObjectContext! {
        return StaticStorage.customMainThreadManagedObjectContext ?? EasyCoreData.sharedInstance.mainThreadManagedObjectContext
    }
    
    /**
     
     tempolorary child NSManagedObjectContext for mainThreadContext will be returned
     
     */
    class var temporaryMainThreadContext: NSManagedObjectContext! { return mainThreadContext.createChildContext() }
}

public extension NSManagedObjectContext {
    /**
     
     Creates a new instance of NSManagedObject subclass with given type
     
     - returns: created object of given type T or nil
     
     */
    func createEntity<T>() -> T! where T: NSManagedObject {
        return T(entity: T.entityDescription(inContext: self), insertInto: self)
    }
}

public extension NSManagedObjectContext {
    
    /**
     
     Must be used for creation, updating or deletion of instances of NSManagedObject subclasses in the background. All changed will be saved to all parent contexts as well
     
     - parameter saveFunction: The function will be called to perform changes. All changes must be done in the localContext which is passed to this function as a parameter
     
     - parameter completion: The function will be called on the Main thread once save operation finished. Can update UI here
     
     */
    
    func saveDataInBackground(_ saveFunction: @escaping (_ localContext: NSManagedObjectContext) -> Void, completion: (() -> Void)?) {
        let context = createChildContext(.privateQueueConcurrencyType)
        context.perform {
            saveFunction(context)
            switch context.hasChanges {
            case true: context.saveWithCompletion(completion)
            default: DispatchQueue.main.async { completion?() }
            }
        }
    }
    
    /**
     
     Must be used for creation, updating or deletion of instances of NSManagedObject subclasses in the background. All changes will be saved to all parent contexts as well
     
     - parameter saveFunction: The function will be called to perform changes. All changes must be done in the localContext which is passed to this function as a parameter
     
     - parameter completion: The function will be called on the Main thread once save operation finished. Can update UI here
     
     */
    class func saveDataInBackground(_ saveFunction: @escaping (_ localContext: NSManagedObjectContext) -> Void, completion: (() -> Void)?) {
        mainThreadContext.saveDataInBackground(saveFunction, completion: completion)
    }
    
    /**
     
     Save current NSManagedObject state and merge changes into parent NSManagedObjectContent if exists
     
     - parameter completion: The function will be called once save operation finished
     
     */
    func saveWithCompletion(_ completion:(() -> Void)?) {
        perform {
            do {
                try self.save()
                switch self.parent {
                case .some(let context): context.saveWithCompletion(completion)
                default: DispatchQueue.main.async { completion?() }
                }
            } catch let error as NSError {
                logTextIfDebug("\(error)")
                completion?()
            } catch {
                fatalError()
            }
        }
    }
    
    /**
     
     Must be used for creation, updating or deletion of NSManagedObject subclasses instances on the Main thread
     
     - parameter saveFunction: The function will be called to perform changes
     
     */
    class func saveDataWithBlock(_ saveFunction: @escaping () -> Void) {
        mainThreadContext.performAndWait {
            saveFunction()
            do { try self.mainThreadContext.save(); do {
                try self.mainThreadContext.parent?.save()
            } catch let error as NSError {
                logTextIfDebug("\(error)")
                }
            } catch let error as NSError {
                logTextIfDebug("\(error)")
            } catch {
                fatalError()
            }
        }
    }
}

public extension NSManagedObjectContext {
    /**
     
     Creates a new instance of NSManagedObjectContext which is child for the current one
     
     - parameter concurrencyType: concurrency type of the new NSManagedObjectContext. The default value is MainQueueConcurrencyType
     
     - returns: a new instance is NSManagedObjectContext
     
     */
    func createChildContext(_ concurrencyType: NSManagedObjectContextConcurrencyType = .mainQueueConcurrencyType) -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: concurrencyType)
        context.parent = self
        return context
    }
}

public extension NSManagedObjectContext {
    /**
     
     Fetches the instances of NSManagedObject subclasses from CoreData storage
     
     - parameter entity: type of NSManagedObject subclass
     - parameter predicate: default value is nil
     - parameter sortDescriptors: default value is nil
     - returns: array of objects given type T or empty array
     
     */
    func fetchObjects<T>(_ entity: T.Type = T.self, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int? = nil, fetchBatchSize: Int? = nil) -> [T] where T: NSManagedObject {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity.entityName)
        request.sortDescriptors = sortDescriptors
        request.predicate = predicate
        if let limit = fetchLimit { request.fetchLimit = limit }
        if let batchSize = fetchBatchSize { request.fetchBatchSize = batchSize }
        do {
            guard let items = try fetch(request) as? [T] else { return [T]() }
            return items
        } catch let error as NSError {
            logTextIfDebug("executeFetchRequest error: \(error)")
        }
        return [T]()
    }
    
    /**
     
     Fetches the instance of NSManagedObject subclass from CoreData storage
     
     - parameter entity: type of NSManagedObject subclass
     - parameter predicate: default values is nil
     - parameter sortDescriptors: The default value is nil
     - returns: optional object or nil of given type T
     
     */
    func fetchFirstOne<T>(_ entity: T.Type = T.self, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> T? where T: NSManagedObject {
        return fetchObjects(entity, predicate: predicate, sortDescriptors: sortDescriptors, fetchLimit: 1).first
    }
}

public extension NSManagedObjectContext {
    /**
     
     Fetches NSManagedObject instance from other context in current
     
     - parameter entity: The instance of NSManagedObject for lookup in context
     - returns: The instance is NSManagedObject in the current context
     
     */
    func entityFromOtherContext<T>(_ entity: T) -> T? where T: NSManagedObject {
        if let result = (try? existingObject(with: entity.objectID)) as? T {
            return result
        }
        
        let uri = entity.objectID.uriRepresentation()
        guard let objectID = persistentStoreCoordinator?.managedObjectID(forURIRepresentation: uri)/*, let obj = object(with: objectID) as? T */else {
            return nil
        }
//
//        return obj
        
        let request = NSFetchRequest<T>()
        request.entity = objectID.entity
        request.predicate = NSComparisonPredicate(leftExpression: NSExpression.expressionForEvaluatedObject(), rightExpression:  NSExpression(forConstantValue: object), modifier: .direct, type: .equalTo, options: [])
        request.fetchLimit = 1
        return object(with: entity.objectID) as? T
    }
}

public extension NSManagedObjectContext {
    public func saveWithParents() throws {
        
        var errorToThrow: Error?
        
        performAndWait {
            do {
                try self.save()
                try self.parent?.saveWithParents()
            }
            catch let error {
                errorToThrow = error
            }
        }
        
        if let error = errorToThrow {
            throw error
        }
    }
}

@available(iOS 8.0, *)
public extension NSManagedObjectContext {
    /**
     
     Fetches the instances of NSManagedObject subclasses from CoreData storage asynchronously
     
     - parameter entity: type of the objects needs to be fetched
     - parameter predicate: default values is nil
     - parameter sortDescriptors: The default value is nil
     - returns: array of objects given type T or empty array
     
     */
    func fetchObjectsAsynchronously<T>(_ entity: T.Type = T.self, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int? = nil, fetchBatchSize: Int? = nil, completion: (([T]) -> Void)?) where T: NSManagedObject {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity.entityName)
        request.sortDescriptors = sortDescriptors
        request.predicate = predicate
        let asyncRequest = NSAsynchronousFetchRequest(fetchRequest: request) { result in
            var results = [T]()
            if let res = result.finalResult as? [T] { results = res }
            completion?(results)
        }
        perform {
            do {
                try self.execute(asyncRequest)
            } catch let error as NSError {
                logTextIfDebug("fetchObjectsAsynchronously error: \(error)")
            } catch {
                fatalError()
            }
        }
    }
}
