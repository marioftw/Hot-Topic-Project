//
//  ExerciseListViewController.swift
//  Vitality
//
//  Created by Simran on 2/07/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import UIKit

class ExerciseListViewController: UITableViewController {


  // MARK: - Segue Identifiers

  enum SegueIdentifier: String {
    case addExercise
    case editExercise
  }


  // MARK: - Cell Reuse Identifiers

  enum CellIdentifier: String {
    case exerciseCell
  }


  // MARK: - Properties

  var routine: Routine!


  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    title = routine.name
  }
}



// MARK: - Table View Data Source

extension ExerciseListViewController {

  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return routine.exercises.count
  }

  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.exerciseCell.rawValue,
                                             for: indexPath)

    let exercise = routine.exercises[indexPath.row]
    configureCell(cell, with: exercise)

    return cell
  }

  private func configureCell(_ cell: UITableViewCell, with exercise: Exercise) {
    cell.textLabel!.text = exercise.name
    cell.detailTextLabel!.text = exercise.description
  }

  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {

    routine.exercises.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .automatic)
  }

}



// MARK: - Navigation

extension ExerciseListViewController {

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let identString = segue.identifier,
      let identifier = ExerciseListViewController.SegueIdentifier(rawValue: identString) else { return }

    switch identifier {

    case .addExercise:
      // swiftlint:disable:next force_cast
      let controller = segue.destination as! ExerciseDetailViewController
      controller.delegate = self

    case .editExercise:
      // swiftlint:disable:next force_cast
      let controller = segue.destination as! ExerciseDetailViewController
      controller.delegate = self
      if let sender = sender as? UITableViewCell,
        let indexPath = tableView.indexPath(for: sender) {
        controller.exerciseToEdit = routine.exercises[indexPath.row]
      }
    }
  }
}



// MARK: - ExerciseDetailViewControllerDelegate

extension ExerciseListViewController: ExerciseDetailViewControllerDelegate {

  func exerciseDetailViewControllerDidCancel(_ controller: ExerciseDetailViewController) {
    navigationController?.popViewController(animated: true)
  }

  func exerciseDetailViewController(_ controller: ExerciseDetailViewController,
                                    didFinishAdding exercise: Exercise) {

    // Update data model
    routine.exercises.append(exercise)

    // Update view
    let newRowIndex = routine.exercises.count - 1
    let newIndexPath = IndexPath(item: newRowIndex, section: 0)
    tableView.insertRows(at: [newIndexPath], with: .automatic)

    // Pop the 'add' screen off
    navigationController?.popViewController(animated: true)
  }

  func exerciseDetailViewController(_ controller: ExerciseDetailViewController,
                                    didFinishEditing exercise: Exercise) {

    // Update view
    if let index = routine.exercises.firstIndex(of: exercise) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        configureCell(cell, with: exercise)
      }
    }

    // Pop the 'edit' screen off
    navigationController?.popViewController(animated: true)
  }
}
