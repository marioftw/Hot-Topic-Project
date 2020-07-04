//
//  EditProfileViewController.swift
//  Vitality
//
//  Created by Mario Aguirre on 1/07/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import UIKit
import Firebase

class EditProfileViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mySurgeryTextField: UITextField!
    
    var docRef: DocumentReference!
    var userDataListener: ListenerRegistration!
    var userID = ""
    var firstName = ""
    var lastName = ""
    var emailVar = ""
    var passwordVar = ""
    var mySurgery = ""
    let db = Firestore.firestore()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Auth.auth().currentUser != nil {
          let user = Auth.auth().currentUser
          if let user = user {
              let email = user.email
              let uid = user.uid
              self.emailTextField.text = email
              self.emailVar = email!
              self.userID = uid
        } else {
          print("No user is signed in")
        }
        
        docRef = Firestore.firestore().collection("users").document(userID)
        
        userDataListener = docRef.addSnapshotListener() { (docSnapshot, error) in
            guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
            let userData = docSnapshot.data()
            let firstName = userData?["firstName"] as? String ?? ""
            let lastName = userData?["lastName"] as? String ?? ""
            let mySurgery = userData?["mySurgery"] as? String ?? "(none)"
            self.firstNameTextField.text = firstName
            self.firstName = firstName
            self.lastNameTextField.text = lastName
            self.lastName = lastName
            self.mySurgeryTextField.text = mySurgery
            self.mySurgery = mySurgery
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        userDataListener.remove()
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        if firstNameTextField.text != firstName ||
            lastNameTextField.text != lastName ||
            emailTextField.text != emailVar ||
            passwordTextField.text != passwordVar ||
            mySurgeryTextField.text != mySurgery {
            
            Auth.auth().currentUser?.updateEmail(to: emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) { (error) in
                if let err = error {
                    print("Error updating email: \(err)")
                } else {
                    print("Email successfully updated")
                }
            }
            
            Auth.auth().currentUser?.updatePassword(to: passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) { (error) in
                if let err = error {
                    print("Error updating password: \(err)")
                } else {
                    print("Password successfully updated")
                }
            }

            
            let docRef = db.collection("users").document(userID)

            docRef.updateData([
                "firstName": firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                "lastName": lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                "mySurgery": mySurgeryTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        }
    }
    

}
