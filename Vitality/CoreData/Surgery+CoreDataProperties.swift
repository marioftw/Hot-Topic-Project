//
//  Surgery+CoreDataProperties.swift
//  Vitality
//
//  Created by Mario Aguirre on 29/06/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//
//

import Foundation
import CoreData


extension Surgery {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Surgery> {
        return NSFetchRequest<Surgery>(entityName: "Surgery")
    }

    @NSManaged public var name: String?
    @NSManaged public var about: String?

}
