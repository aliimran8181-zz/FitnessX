//
//  TableViewCell.swift
//  FitnessX
//
//  Created by Ali on 18/11/2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var fname: UILabel!
    
    @IBOutlet weak var lname: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var dob: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
