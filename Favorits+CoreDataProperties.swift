//
//  Favorits+CoreDataProperties.swift
//  
//
//  Created by 2unni on 3/15/20.
//
//

import Foundation
import CoreData


extension Favorits {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorits> {
        return NSFetchRequest<Favorits>(entityName: "Favorits")
    }

    @NSManaged public var id: Int32
    @NSManaged public var poster_path: String?
    @NSManaged public var title: String?
    @NSManaged public var vote_average: Double

}
