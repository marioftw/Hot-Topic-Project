//
//  AddExerciseScreen.swift
//  Vitality
//
//  Created by Simran on 5/07/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import UIKit
protocol AddExerciseDelegate: class {
    func saveWorkout(sender: AddExerciseScreen)
}

class AddExerciseScreen: UIViewController, UITableViewDataSource, UITableViewDelegate, MuscleCellDelegate {
    
    func toggleMuscleWorked(sender: MuscleCellTableViewCell) {
        if let muscleName = sender.muscleName.text {
            exerciseLog?.musclesExercised[muscleName] = sender.muscleSelected.isOn
        }
    }
    
    var isPickerHidden = true
    var exerciseLog: ExerciseLog?
    var updateMode: Bool = false
    var rowNumber: Int?
    var delegate: AddExerciseDelegate?

    class MusclesExercised: CustomStringConvertible, Codable {
        // Couldn't pass and save the reference to a dictionary in MuscleCellTableViewCell because dictionaries are passed as values so I put it inside a class so I can pass the reference to the object
        var musclesExercised: [String: Bool] = [:]
        var description: String {
            return musclesExercised.description
        }
        init(muscles: [String]) {
            for muscle in muscles {
                self.musclesExercised[muscle] = false
            }
        }
        func setMuscleExercised(muscle: String, value: Bool) {
            self.musclesExercised[muscle] = value
        }
    }
    
    @IBAction func dateUpdated(_ sender: UIDatePicker) {
        exerciseLog!.date = datePickerView.date
    }
    
    
    var muscles: [String] = ["Neck", "Shoulders", "Upper back", "Lower back", "Biceps", "Triceps", "Forearms", "Abs", "Glutes", "Hamstrings", "Quads", "Calves"]
    
    var musclesExercised: MusclesExercised
    required init?(coder: NSCoder) {
        self.musclesExercised = MusclesExercised(muscles: self.muscles)
        super.init(coder: coder)
    }

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var datePickerView: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if let exerciseLog = self.exerciseLog {
            datePickerView.date = exerciseLog.date
        }
        else {
            var musclesExercised = [String:Bool]()
            for muscle in muscles {
                musclesExercised[muscle] = false
            }
            exerciseLog = ExerciseLog(date: Date(), musclesExercised: musclesExercised)
        }
        datePickerView.maximumDate = Date()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return muscles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let muscle = muscles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MuscleCell") as! MuscleCellTableViewCell
        
        cell.muscleName.text = muscle
        if let exerciseLog = self.exerciseLog {
            if let isOn = exerciseLog.musclesExercised[muscle] {
                cell.muscleSelected.isOn = isOn
            }
        }
        cell.delegate = self
        
        return cell
        
    }
    
    @IBAction func saveWorkout(_ sender: UIButton) {
        if let delegate = self.delegate {
            delegate.saveWorkout(sender: self)
        }
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
     
}

