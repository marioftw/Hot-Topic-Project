//
//  DataModel.swift
//  WorkoutDiary
//
//  Created by Martin Rist on 15/10/2019.
//  Copyright © 2019 Martin Rist. All rights reserved.
//

import Foundation

class DataModel {

  // MARK: - Properties

  var routines = [Routine]()

  // MARK: - Lifecycle

  init() {
    loadData()
  }
}



// MARK: - Test Data

extension DataModel {

  func loadData() {
    routines = Array<Any>().map { routineNumber in
      let routine = Routine(name: "Routine \(routineNumber)",
                            description: "Routine \(routineNumber) description")

        routine.exercises = Array<Any>().map { exerciseNumber in
        Exercise(name: "Exercise \(routineNumber).\(exerciseNumber)",
                 description: "Exercise \(routineNumber).\(exerciseNumber) description")
      }

      return routine
    }
  }

}
