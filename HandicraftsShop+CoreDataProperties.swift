//
//  HandicraftsShop+CoreDataProperties.swift
//  hk traditional handicraft
//
//  Created by peter lam on 13/1/2022.
//
//

import Foundation
import CoreData


extension HandicraftsShop {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HandicraftsShop> {
        return NSFetchRequest<HandicraftsShop>(entityName: "HandicraftsShop")
    }

    @NSManaged public var id: Int16
    @NSManaged public var image: Data?
    @NSManaged public var lati: Float
    @NSManaged public var long: Float
    @NSManaged public var name: String?
    @NSManaged public var text: String?

}

extension HandicraftsShop : Identifiable {

}
