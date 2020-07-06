//
//  ExerciseListScreenTableViewController.swift
//  Vitality
//
//  Created by Simran on 5/07/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import UIKit

class ExerciseListScreenTableViewController: UITableViewController, AddExerciseDelegate {
    
    func saveWorkout(sender: AddExerciseScreen) {
        if sender.updateMode {
            if let exerciseLog = sender.exerciseLog {
                exerciseLogs[sender.rowNumber!] = exerciseLog
            }
            tableView.reloadData()
        }
        else {
            if let exerciseLog = sender.exerciseLog {
                let newIndexPath = IndexPath(row: exerciseLogs.count, section: 0)
                exerciseLogs.append(exerciseLog)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                tableView.scrollToRow(at: newIndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
            }
        }
        ExerciseLog.save(exerciseLogs)
        
    }
    
    var exerciseLogs = [ExerciseLog]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let logs = ExerciseLog.load() {
            self.exerciseLogs = logs
        } else {
            self.exerciseLogs = []
        }
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.estimatedRowHeight = 185.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let newIndexPath = IndexPath(row: exerciseLogs.count-1, section: 0)
        if exerciseLogs.count >= 1 {
            tableView.scrollToRow(at: newIndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MuscleCell") as? ExerciseLogCell else {
            fatalError("Could not dequeue")
        }
        let localizedDate = DateFormatter.localizedString(from: exerciseLogs[indexPath.row].date, dateStyle: .medium, timeStyle: .short)

        var labelString = "\(localizedDate)"
        var n = 0
        for (muscle, exercised) in exerciseLogs[indexPath.row].musclesExercised {
            if exercised {
                labelString += "\n      \(muscle)"
                n += 1
            }
        }
        if n == 0 {
            labelString += "\n      No muscles exercised."
        }
        cell.musclesWorked.text = labelString
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            exerciseLogs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ExerciseLog.save(exerciseLogs)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseLogs.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditWorkout",
            let controller = segue.destination as? AddExerciseScreen {
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedWorkout = exerciseLogs[indexPath.row]
            controller.exerciseLog = selectedWorkout
            controller.updateMode = true
            controller.rowNumber = indexPath.row
            controller.delegate = self
        }
        else if segue.identifier == "AddWorkout",
        let controller = segue.destination as? AddExerciseScreen {
            controller.updateMode = false
            controller.delegate = self
        }
    }
}
