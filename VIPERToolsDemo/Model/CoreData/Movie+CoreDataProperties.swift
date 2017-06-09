//
//  Movie+CoreDataProperties.swift
//  VIPERToolsDemo
//
//  Created by ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var imdbId: String?
    @NSManaged public var posterUrlString: String?
    @NSManaged public var sortingOrder: Int32
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var year: String?
    @NSManaged public var details: MovieDetails?
    @NSManaged public var searchRequest: SearchRequest?

}
