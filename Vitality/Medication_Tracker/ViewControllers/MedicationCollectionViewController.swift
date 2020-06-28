//
//  MedicationCollectionViewController.swift
//  MedicationTracker
//
//  Created by admin on 9/23/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MedicationCell"

class MedicationCollectionViewController: UICollectionViewController {

    let medicationController = MedicationController()
    
    var time = Date(timeIntervalSinceNow: 0)
    
    var medication: Medication?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView?.reloadData()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMedicationSegue" {
            
            let addMedicationVC = segue.destination as? AddMedicationViewController
            addMedicationVC?.medicationController = medicationController
            
        } else if segue.identifier == "MedicationDetailShowSegue" {
            
            if let medicationDetailVC = segue.destination as? MedicationDetailViewController {
                if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                    medicationDetailVC.medicationController = medicationController
                    medicationDetailVC.medication = medicationController.medications[indexPath.row]
                }
            }
            
        } else if segue.identifier == "EditShowSegue" {
            if let medicationEditVC = segue.destination as? EditMedicationViewController {
                if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                    medicationEditVC.medicationController = medicationController
                    medicationEditVC.medication = medicationController.medications[indexPath.row]
                }
            }
            
        }
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return medicationController.medications.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MedicationCollectionViewCell else { return UICollectionViewCell() }
        
        let aMedication = medicationController.medications[indexPath.item]
        cell.medication = aMedication
       
        if time == medication?.takeTime {
            cell.layer.borderColor = UIColor.red.cgColor
        } else {
            cell.layer.borderColor = UIColor.black.cgColor
        }
        
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 8
    
        return cell
    }

}
