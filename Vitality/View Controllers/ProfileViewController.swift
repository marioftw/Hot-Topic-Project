//
//  ProfileViewController.swift
//  Vitality
//
//  Created by Mario Aguirre on 28/06/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var surgeryLabel: UILabel!
    
    var docRef: DocumentReference!
    var userDataListener: ListenerRegistration!
    var userID = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Auth.auth().currentUser != nil {
          let user = Auth.auth().currentUser
          if let user = user {
              let email = user.email
              let uid = user.uid
              self.emailLabel.text = email
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
            self.nameLabel.text = "\(firstName) \(lastName)"
            self.surgeryLabel.text = mySurgery
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        
//        docRef = Firestore.firestore().collection("users").document(userID)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        userDataListener.remove()
    }
    
}
