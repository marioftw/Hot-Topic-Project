//
//  LoginController.swift
//  Vitality
//
//  Created by Mario Aguirre on 19/06/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func LoginButton(_ sender: UIButton)
    {
        let user = userNameTextField.text
        let password = passwordTextField.text!
        if (user?.isEmpty)! || (password.isEmpty)
            {
                showMessage(type: "Empty Field", msg: "Make sure you have entered your email and password.")
            }
        else if user == "user" && password == "password"
            {
            userNameTextField.text = ""
            passwordTextField.text = ""
            self.performSegue(withIdentifier: "Tab Bar Controller Scene", sender: nil)
            }
        else
            {
                showMessage(type: "Incorrect Details", msg: "Please enter correct login details.")
            }
    }
        
    @IBAction func registerButton(_ sender: UIButton)
    {
    }
        
    
    func showMessage (type: String, msg: String)
    {
        let alert = UIAlertController(title: type, message: msg, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Ok", style: .default, handler:
        {
            action in self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(action)
        present (alert, animated: true, completion: nil)
    }
}
