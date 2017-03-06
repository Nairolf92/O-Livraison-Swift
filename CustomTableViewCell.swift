//
//  CustomTableViewCell.swift
//  MVCJSONBlank
//
//  Created by dotemin konate on 02/03/2017.
//  Copyright © 2017 FlyLab. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell
{
    @IBOutlet var referenceLabel : UILabel?
    @IBOutlet var nomLabel : UILabel?
    @IBOutlet var adresseLabel : UILabel?
    @IBOutlet var contactLabel : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
