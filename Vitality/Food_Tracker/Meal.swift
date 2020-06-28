//
//  Meal.swift
//  Vitality
//
//  Created by Simran Deo on 21/06/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    //MARK: Initialization
    init?(name: String, photo: UIImage?, calories: Int) {
        // Initialization should fail if there is no name or if the rating is negative.
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.calories = calories
    }
    
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var calories: Int
    
    //MARK: Archiving Paths
     
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: Types
     
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let calories = "calories"
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(calories, forKey: PropertyKey.calories)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let calories = aDecoder.decodeInteger(forKey: PropertyKey.calories)
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, calories: calories)
        
    }

}
