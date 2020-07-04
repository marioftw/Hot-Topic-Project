//
//  MessagingViewController.swift
//  Vitality
//
//  Created by Mario Aguirre on 3/07/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import UIKit
import Firebase

class MessagingViewController: UIViewController {

    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.dataSource = self
        messageTableView.register(UINib(nibName: Constants.CellId.messageNibCell, bundle: nil), forCellReuseIdentifier: Constants.CellId.messageCell)
        loadMessages()
    }
    
    func loadMessages() {
        
        db.collection(Constants.Message.collectionName)
            .order(by: Constants.Message.dateField)
            .addSnapshotListener { (querySnapshot, error) in
                
                self.messages = []
                
            if let e = error {
                print("There was an error retrieving data to FireStore DB: \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[Constants.Message.senderField] as? String, let messageBody = data[Constants.Message.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.messageTableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.messageTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendButton(_ sender: UIButton) {
        
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(Constants.Message.collectionName)
                .addDocument(data: [
                    Constants.Message.senderField: messageSender,
                    Constants.Message.bodyField: messageBody,
                    Constants.Message.dateField: Date().timeIntervalSince1970]) {
                (error) in
                if let e = error {
                    print("There was an error saving data to FireStore DB: \(e)")
                } else {
                    self.messageTextField.text = ""
                    print("Message successfully saved to FireStore DB")
                }
            }
        }
    }
}

extension MessagingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellId.messageCell, for: indexPath) as! MessageCell
        cell.textLabel?.text = messages[indexPath.row].body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor.systemTeal
            cell.label.textColor = UIColor.black
        }
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor.systemOrange
            cell.label.textColor = UIColor.black
        }

        return cell
    }
}

//extension MessagingViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print (indexPath.row)
//    }
//}
