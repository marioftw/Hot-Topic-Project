//
//  ExerciseDetailViewController.swift
//  Vitality
//
//  Created by Simran on 2/07/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import UIKit

// MARK: - ExerciseDetailViewControllerDelegate

protocol ExerciseDetailViewControllerDelegate: class {
  func exerciseDetailViewControllerDidCancel(_ controller: ExerciseDetailViewController)
  func exerciseDetailViewController(_ controller: ExerciseDetailViewController,
                                    didFinishAdding exercise: Exercise)
  func exerciseDetailViewController(_ controller: ExerciseDetailViewController,
                                    didFinishEditing exercise: Exercise)
}



// MARK: - ExerciseDetailViewController

class ExerciseDetailViewController: UITableViewController {


  // MARK: - Properties

  weak var delegate: ExerciseDetailViewControllerDelegate?
  var exerciseToEdit: Exercise?


  // MARK: - Outlets

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var descriptionPlaceholderLabel: UILabel!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!


  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    if let exercise = exerciseToEdit {

      // Set up view state for editing
      title = "Edit exercise"
      doneBarButton.isEnabled = true

      // Copy model data into view
      nameTextField.text = exercise.name
      descriptionTextView.text = exercise.description
      descriptionPlaceholderLabel.isHidden = !exercise.description.isEmpty

    } else {

      // Set up view state for adding
      title = "Add exercise"
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    nameTextField.becomeFirstResponder()
  }


  // MARK: - Actions

  @IBAction func cancel(_ sender: Any) {
    delegate?.exerciseDetailViewControllerDidCancel(self)
  }

  @IBAction func done(_ sender: Any) {

    if let exercise = exerciseToEdit {

      // Copy view state back into model
      exercise.name = nameTextField.text!
      exercise.description = descriptionTextView.text

      // Notify delegate of editing completion
      delegate?.exerciseDetailViewController(self,
                                             didFinishEditing: exercise)

    } else {

      // Create new exercise
      let exercise = Exercise(name: nameTextField.text!,
                              description: descriptionTextView.text)
      delegate?.exerciseDetailViewController(self,
                                             didFinishAdding: exercise)
    }
  }
}



// MARK: - UITextFieldDelegate

extension ExerciseDetailViewController: UITextFieldDelegate {

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

extension ExerciseDetailViewController: UITextViewDelegate {

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
