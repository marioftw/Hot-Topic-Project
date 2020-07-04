//
//  SignUpViewController.swift
//  Vitality
//
//  Created by Mario Aguirre on 19/06/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var accessCodeTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            accessCodeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            self.errorLabel.text = "Please fill in all fields"
        } else {
            if let email = emailTextField.text, let password = passwordTextField.text {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if self.passwordTextField.text == self.confirmPasswordTextField.text {
                        if let e = error {
                            self.errorLabel.text = e.localizedDescription
                        } else {
                            
                            // Add a new document in collection "users"
                            let db = Firestore.firestore()
                            db.collection("users").document(authResult!.user.uid).setData([
                                "firstName": self.firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                                "lastName": self.lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                                "accessCode": self.accessCodeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                                "mySurgery": ""
                            ]) { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("Document successfully written!")
                                }
                            }
                            
                            self.firstNameTextField.text = ""
                            self.lastNameTextField.text = ""
                            self.emailTextField.text = ""
                            self.passwordTextField.text = ""
                            self.confirmPasswordTextField.text = ""
                            self.accessCodeTextField.text = ""
                            self.errorLabel.text = ""
                            self.performSegue(withIdentifier: Constants.SegueId.registerSegue, sender: self)
                        }
                    } else {
                        self.errorLabel.text = "Passwords do not match"
                    }
                }
            }
        }
    }
}
