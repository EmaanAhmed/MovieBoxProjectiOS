//
//  MostMovies+CoreDataProperties.swift
//  
//
//  Created by 2unni on 3/16/20.
//
//

import Foundation
import CoreData


extension MostMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MostMovies> {
        return NSFetchRequest<MostMovies>(entityName: "MostMovies")
    }

    @NSManaged public var id: Int32
    @NSManaged public var original_title: String?
    @NSManaged public var overview: String?
    @NSManaged public var poster_path: String?
    @NSManaged public var release_date: String?
    @NSManaged public var vote_average: Double
    @NSManaged public var title: String?

}
