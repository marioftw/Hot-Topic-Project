//
//  Exercise.swift
//  Vitality
//
//  Created by Simran on 2/07/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
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
