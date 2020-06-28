//
//  MedicationController.swift
//  MedicationTracker
//
//  Created by admin on 9/24/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit



class MedicationController {
    
    var medications: [Medication] = []
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.timeZone = .autoupdatingCurrent
        return formatter
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    var medicationListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("MedicationList.plist")
    }
    
    @ discardableResult func addMedication(name: String, dosage: String, takeTime: Date?, image: UIImage) -> Medication {
        let medication = Medication(name: name, dosage: dosage, takeTime: takeTime, image: image)
        medications.append(medication)
        saveToPersistentStore()
        return medication
    }
    
    func deleteMedication(medication: Medication) {
        if let index = medications.firstIndex(of: medication) {
            medications.remove(at: index)
            saveToPersistentStore()
        }
    }
    
//    func updateMedication(medication: Medication, time: Date) {
//        medication.takeTime =
//        
//        
//    }
    
    func saveToPersistentStore() {
        guard let url = medicationListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(medications)
            try data.write(to: url)
        } catch {
            print("Error saving medication data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = medicationListURL,
            fileManager.fileExists(atPath: url.path) else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            medications = try decoder.decode([Medication].self, from: data)
        } catch {
            print("Error loading medication data: \(error)")
        }
    }

}
