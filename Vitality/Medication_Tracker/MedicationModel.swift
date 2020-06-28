//
//  MedicationModel.swift
//  Vitality
//
//  Created by Simran Deo on 19/06/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import Foundation
import UIKit

struct Medication: Codable, Equatable {
    var name: String
    var dosage: String
    var takeTime: Date?
    var image: Data
    
    init(name: String, dosage: String, takeTime: Date?, image: UIImage) {
        self.name = name
        self.dosage = dosage
        self.takeTime = takeTime
        self.image = image.pngData()!
    }
}

