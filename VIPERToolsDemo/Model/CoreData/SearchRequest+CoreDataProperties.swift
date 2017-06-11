//
//  SearchRequest+CoreDataProperties.swift
//  VIPERToolsDemo
//
//  Created by ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//

import Foundation
import CoreData


extension SearchRequest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchRequest> {
        return NSFetchRequest<SearchRequest>(entityName: "SearchRequest")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var page: Int16
    @NSManaged public var params: NSObject?
    @NSManaged public var term: String?
    @NSManaged public var totalExpected: Int32
    @NSManaged public var type: String?
    @NSManaged public var results: NSSet?

}

// MARK: Generated accessors for results
extension SearchRequest {

    @objc(addResultsObject:)
    @NSManaged public func addToResults(_ value: Movie)

    @objc(removeResultsObject:)
    @NSManaged public func removeFromResults(_ value: Movie)

    @objc(addResults:)
    @NSManaged public func addToResults(_ values: NSSet)

    @objc(removeResults:)
    @NSManaged public func removeFromResults(_ values: NSSet)

}
