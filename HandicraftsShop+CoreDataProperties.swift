//
//  HandicraftsShop+CoreDataProperties.swift
//  hk traditional handicraft
//
//  Created by peter lam on 10/1/2022.
//
//

import Foundation
import CoreData


extension HandicraftsShop {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HandicraftsShop> {
        return NSFetchRequest<HandicraftsShop>(entityName: "HandicraftsShop")
    }

    @NSManaged public var name: String?
    @NSManaged public var long: Float
    @NSManaged public var lati: Float
    @NSManaged public var id: Int16

}

extension HandicraftsShop : Identifiable {

}
