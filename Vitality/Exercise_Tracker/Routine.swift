//
//  Routine.swift
//  WorkoutDiary
//
//  Created by Martin Rist on 23/10/2019.
//  Copyright © 2019 Martin Rist. All rights reserved.
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
