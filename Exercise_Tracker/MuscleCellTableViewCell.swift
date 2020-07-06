//
//  MuscleCellTableViewCell.swift
//  Vitality
//
//  Created by Simran on 5/07/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import UIKit

protocol MuscleCellDelegate: class {
    func toggleMuscleWorked(sender: MuscleCellTableViewCell)
}

class MuscleCellTableViewCell: UITableViewCell {

    @IBOutlet var muscleName: UILabel!
    
    @IBOutlet var muscleSelected: UISwitch!
    
    var delegate: MuscleCellDelegate?
    
    @IBAction func muscleSwitchToggle(_ sender: UISwitch) {
        delegate?.toggleMuscleWorked(sender: self)
    }
    
    
}
