//
//  EditMedicationViewController.swift
//  MedicationTracker
//
//  Created by admin on 9/26/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import UserNotifications

class EditMedicationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var medicationNameEditTextField: UITextField!
    @IBOutlet weak var dosageEditTextField: UITextField!
    @IBOutlet weak var sIEditTextField: UITextField!
    @IBOutlet weak var medicationEditImageView: UIImageView!
    @IBOutlet weak var editTakeTImePicker: UIDatePicker!
    

    var medication: Medication?
    
    var medicationController: MedicationController?
    
    var medicationCell: MedicationCollectionViewCell?
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.timeZone = .autoupdatingCurrent
        return formatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func uploadPhotoButton(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Please select your source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Camera Unavailable", message: "We were unable to access your camera", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        medicationEditImageView.image = selectedImage
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func setAlarm(medication: Medication?) {
        guard let medication = medication else { return }
        guard case medication.takeTime = medication.takeTime else { return }
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        
        content.title = "Time to take your medicine"
        content.body = "It's time to take \(medication.name)"
        content.sound = UNNotificationSound.default
        content.threadIdentifier = "local-notification temp"
        
        let date = Date(timeInterval: 0, since: medication.takeTime!)
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if error != nil {
                print (error as Any)
            }
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    @IBAction func saveEditButton(_ sender: UIButton) {
        
        
       // medicationController?.deleteMedication(medication: medication!)
        
        
        guard let medication = medication.self else { return }
        
        

        
        
        guard let name = medicationNameEditTextField.text,
            let dosage = dosageEditTextField.text,
            let takeTime = editTakeTImePicker?.date,
            let image = medicationEditImageView.image else { return }
        
        
        medicationController?.addMedication(name: name, dosage: dosage, takeTime: takeTime, image: image)
        setAlarm(medication: medication)
        
        self.navigationController!.popToRootViewController(animated: true)
    }

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

