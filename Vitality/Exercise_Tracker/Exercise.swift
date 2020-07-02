//
//  Exercise.swift
//  WorkoutDiary
//
//  Created by Martin Rist on 15/10/2019.
//  Copyright © 2019 Martin Rist. All rights reserved.
//

import Foundation

public class Exercise: Equatable {

  public var name: String
  public var description: String

  public init(name: String, description: String) {
    self.name = name
    self.description = description
  }

  public static func == (lhs: Exercise, rhs: Exercise) -> Bool {
    return lhs.name == rhs.name
      && lhs.description == rhs.description
  }

}
