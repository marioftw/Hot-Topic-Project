//
//  LoginController.swift
//  Vitality
//
//  Created by Mario Aguirre on 19/06/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func LoginButton(_ sender: UIButton)
    {
        if let email = userNameTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                if let e = error {
                    self.errorLabel.text = e.localizedDescription
                } else {
                    self.userNameTextField.text = ""
                    self.passwordTextField.text = ""
                    self.errorLabel.text = ""
                    self.performSegue(withIdentifier: Constants.SegueId.loginSegue, sender: self)
                }
            }
        }
    }

}
