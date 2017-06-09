//
//  MovieDetails+CoreDataProperties.swift
//  VIPERToolsDemo
//
//  Created by ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//

import Foundation
import CoreData


extension MovieDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDetails> {
        return NSFetchRequest<MovieDetails>(entityName: "MovieDetails")
    }

    @NSManaged public var actors: String?
    @NSManaged public var awards: String?
    @NSManaged public var country: String?
    @NSManaged public var director: String?
    @NSManaged public var genre: String?
    @NSManaged public var imdbRating: Float
    @NSManaged public var plot: String?
    @NSManaged public var rating: String?
    @NSManaged public var releasedAt: String?
    @NSManaged public var runtime: String?
    @NSManaged public var writer: String?
    @NSManaged public var movie: Movie?

}
