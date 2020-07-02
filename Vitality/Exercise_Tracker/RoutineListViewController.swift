//
//  RoutineListViewController.swift
//  WorkoutDiary
//
//  Created by Martin Rist on 23/10/2019.
//  Copyright © 2019 Martin Rist. All rights reserved.
//

import UIKit

class RoutineListViewController: UITableViewController {

  // MARK: - Segue Identifiers

  enum SegueIdentifier: String {
    case showRoutine
    case addRoutine
    case editRoutine
  }


  // MARK: - Cell Reuse Identifiers

  enum CellIdentifier: String {
    case routineCell
  }


  // MARK: - Properties

  var dataModel: DataModel!


  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }

}



// MARK: - Table view data source

extension RoutineListViewController {

  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return dataModel.routines.count
  }

  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.routineCell.rawValue,
                                             for: indexPath)

    let routine = dataModel.routines[indexPath.row]
    configureCell(cell, with: routine)

    return cell
  }

  private func configureCell(_ cell: UITableViewCell,
                             with routine: Routine) {
    cell.textLabel!.text = routine.name
    cell.detailTextLabel!.text = "\(routine.exerciseCount)"
    cell.detailTextLabel?.textColor = .secondaryLabel
  }

  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
    dataModel.routines.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .automatic)
  }


}



// MARK: - Navigation

extension RoutineListViewController {

  override func prepare(for segue: UIStoryboardSegue,
                        sender: Any?) {

    guard let identString = segue.identifier,
      let identifier = RoutineListViewController.SegueIdentifier(rawValue: identString) else {
        return }

    switch identifier {

    case .showRoutine:
      // swiftlint:disable:next force_cast
      let controller = segue.destination as! ExerciseListViewController
      if let sender = sender as? UITableViewCell,
        let indexPath = tableView.indexPath(for: sender) {
        controller.routine = dataModel.routines[indexPath.row]
      }

    case .addRoutine:
      // swiftlint:disable:next force_cast
      let controller = segue.destination as! RoutineDetailViewController
      controller.delegate = self

    case .editRoutine:
      // swiftlint:disable:next force_cast
      let controller = segue.destination as! RoutineDetailViewController
      controller.delegate = self
      if let sender = sender as? UITableViewCell,
        let indexPath = tableView.indexPath(for: sender) {
        controller.routineToEdit = dataModel.routines[indexPath.row]
      }
    }

  }
}



// MARK: - RoutineDetailViewControllerDelegate

extension RoutineListViewController: RoutineDetailViewControllerDelegate {

  func routineDetailViewControllerDidCancel(_ controller: RoutineDetailViewController) {
    navigationController?.popViewController(animated: true)
  }

  func routineDetailViewController(_ controller: RoutineDetailViewController, didFinishAdding routine: Routine) {

    // Update data model
    dataModel.routines.append(routine)

    // Update view
    let newRowIndex = dataModel.routines.count - 1
    let newIndexPath = IndexPath(row: newRowIndex, section: 0)
    tableView.insertRows(at: [newIndexPath], with: .automatic)

    // Pop the 'add' screen off
    navigationController?.popViewController(animated: true)
  }

  func routineDetailViewController(_ controller: RoutineDetailViewController, didFinishEditing routine: Routine) {

    // Update view
    if let index = dataModel.routines.firstIndex(of: routine) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        configureCell(cell, with: routine)
      }
    }

    // Pop the 'add' screen off
    navigationController?.popViewController(animated: true)

  }
}
