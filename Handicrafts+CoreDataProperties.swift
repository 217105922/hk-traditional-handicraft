//
//  Handicrafts+CoreDataProperties.swift
//  hk traditional handicraft
//
//  Created by peter lam on 10/1/2022.
//
//

import Foundation
import CoreData


extension Handicrafts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Handicrafts> {
        return NSFetchRequest<Handicrafts>(entityName: "Handicrafts")
    }

    @NSManaged public var long: Float
    @NSManaged public var lati: Float
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var attribute: String?
    @NSManaged public var district: String?
    @NSManaged public var url: URL?

}

extension Handicrafts : Identifiable {

}
