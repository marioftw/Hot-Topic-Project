//
//  RoutineDetailViewController.swift
//  WorkoutDiary
//
//  Created by Martin Rist on 23/10/2019.
//  Copyright © 2019 Martin Rist. All rights reserved.
//

import UIKit

// MARK: - RoutineDetailViewControllerDelegate

protocol RoutineDetailViewControllerDelegate: class {
  func routineDetailViewControllerDidCancel(_ controller: RoutineDetailViewController)
  func routineDetailViewController(_ controller: RoutineDetailViewController,
                                   didFinishAdding routine: Routine)
  func routineDetailViewController(_ controller: RoutineDetailViewController,
                                   didFinishEditing routine: Routine)
}

class RoutineDetailViewController: UITableViewController {

  // MARK: - Properties

  weak var delegate: RoutineDetailViewControllerDelegate?
  var routineToEdit: Routine?

  // MARK: - Outlets

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var descriptionPlaceholderLabel: UILabel!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!


  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    if let routine = routineToEdit {

      // Set up view state for editing
      title = "Edit routine"
      doneBarButton.isEnabled = true

      // Copy model data into view
      nameTextField.text = routine.name
      descriptionTextView.text = routine.description
      descriptionPlaceholderLabel.isHidden = !routine.description.isEmpty

    } else {

      // Set up view state for adding
      title = "Add routine"

    }

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    nameTextField.becomeFirstResponder()
  }


  // MARK: - Actions

  @IBAction func cancel(_ sender: Any) {
    delegate?.routineDetailViewControllerDidCancel(self)
  }

  @IBAction func done(_ sender: Any) {

    if let routine = routineToEdit {

      // Copy view state back into model
      routine.name = nameTextField.text!
      routine.description = descriptionTextView.text

      // Notify delegate of editing completion
      delegate?.routineDetailViewController(self,
                                            didFinishEditing: routine)

    } else {
      // Create new routine
      let routine = Routine(name: nameTextField.text!,
                            description: descriptionTextView.text)
      delegate?.routineDetailViewController(self,
                                            didFinishAdding: routine)
    }
  }
}


// MARK: - UITextFieldDelegate

extension RoutineDetailViewController: UITextFieldDelegate {

  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {

    // Work out what the 'new' text would be
    let oldText = textField.text!
    let stringRange = Range(range, in: oldText)!
    let newText = oldText.replacingCharacters(in: stringRange, with: string)

    // Disable the 'done' button if the new text is empty
    doneBarButton.isEnabled = !newText.isEmpty

    return true
  }
}


// MARK: - UITextViewDelegate

extension RoutineDetailViewController: UITextViewDelegate {

  func textView(_ textView: UITextView,
                shouldChangeTextIn range: NSRange,
                replacementText text: String) -> Bool {
    let oldText = textView.text!
    let stringRange = Range(range, in: oldText)!
    let newText = oldText.replacingCharacters(in: stringRange, with: text)
    descriptionPlaceholderLabel.isHidden = !newText.isEmpty
    return true
  }

}
