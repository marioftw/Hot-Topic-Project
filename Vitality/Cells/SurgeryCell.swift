//
//  SurgeriesTableViewCell.swift
//  Vitality
//
//  Created by Mario Aguirre on 29/06/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import UIKit

class SurgeryCell: UITableViewCell {

    @IBOutlet var surgeryNameLabel: UILabel!
    @IBOutlet var surgeryImage: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
