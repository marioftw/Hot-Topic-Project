//
//  Routine.swift
//  Vitality
//
//  Created by Simran on 2/07/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import Foundation

class Routine: Equatable {

  var name: String
  var description: String
  var exercises = [Exercise]()

  init(name: String, description: String) {
    self.name = name
    self.description = description
  }

  var exerciseCount: Int {
    exercises.count
  }

  static func == (lhs: Routine, rhs: Routine) -> Bool {
    return lhs.name == rhs.name
      && lhs.description == rhs.description
      && lhs.exercises == rhs.exercises
  }

}
