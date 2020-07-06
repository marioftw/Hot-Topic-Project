//
//  ExerciseLog.swift
//  Vitality
//
//  Created by Simran on 5/07/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import Foundation
class ExerciseLog: Codable, CustomStringConvertible {
    var date: Date
    var musclesExercised: [String: Bool]
    init(date: Date, musclesExercised: [String: Bool]) {
        self.date = date
        self.musclesExercised = musclesExercised
    }
    var description: String {
        return "Date: \(date) \nMuscles: \n \(musclesExercised.description)"
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("exercises").appendingPathExtension("plist")
    
    static func save(_ exerciseLogs: [ExerciseLog]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedExerciseLog = try? propertyListEncoder.encode(exerciseLogs)
        try? codedExerciseLog?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    static func load() -> [ExerciseLog]? {
        guard let codedExerciseLog = try? Data(contentsOf: ArchiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ExerciseLog>.self, from: codedExerciseLog)
    }
}
