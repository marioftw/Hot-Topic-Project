//
//  SurgeriesViewController.swift
//  Vitality
//
//  Created by Mario Aguirre on 28/06/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import UIKit
import CoreData

class SurgeriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var SurgeryTableView: UITableView!
    
    let surgeryName = ["C-section", "Mastectomy", "Tonsillectomy", "Hernia Repair", "Lower Back", "Bypass"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Surgeries"
        let nib = UINib(nibName: "SurgeryTableCell", bundle: nil)
        SurgeryTableView.register(nib, forCellReuseIdentifier: "SurgeryTableCell")
        SurgeryTableView.delegate = self
        SurgeryTableView.dataSource = self
    }
    
    func tableView(_ SurgeryTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surgeryName.count
    }
    
    func tableView(_ SurgeryTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SurgeryTableView.dequeueReusableCell(withIdentifier: "SurgeryTableCell", for: indexPath) as! SurgeryCell
        
        cell.surgeryNameLabel.text = surgeryName[indexPath.row]
        cell.surgeryImage.backgroundColor = .lightGray

        return cell
    }
    
//    func DemoCoreData() {
//        // Create
//        guard let newSurgery = SurgeryCoreDataManager.shared.addSurgery(name: "C-section", about: "Cesarean delivery (C-section) is a surgical procedure used to deliver a baby through incisions in the abdomen and uterus. A C-section might be planned ahead of time if you develop pregnancy complications or you've had a previous C-section and aren't considering a vaginal birth after cesarean (VBAC). Often, however, the need for a first-time C-section doesn't become obvious until labor is underway.") else { return }
//        print("Created \(newSurgery)")
//
//        // Read
//        guard let surgeries = SurgeryCoreDataManager.shared.fetchSurgery() else { return }
//    }
    
}

//  Handle interactions of the cell
//extension SurgeriesViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: indexPath)
//}
//
//  Number of cells and reuse of cells
//extension SurgeriesViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return surgeryName.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: indexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SurgeryTableCell", for: indexPath) as! SurgeryTableViewCell
//
//        cell.myLabel.text = surgeryName[indexPath.row]
//        cell.imageView.backgroundColor = .grey
//
//        return cell
//    }
//}
