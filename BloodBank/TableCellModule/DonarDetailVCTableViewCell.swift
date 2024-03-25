//
//  DonarDetailVCTableViewCell.swift
//  BloodBank
//
//  Created by apple on 24/09/22.
//

import UIKit

class DonarDetailVCTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDonarBloodGroup: UILabel!
    @IBOutlet weak var lblDonarAddress: UILabel!
    @IBOutlet weak var lblDonarMobileNumber: UILabel!
    @IBOutlet weak var lblDonarCity: UILabel!
    @IBOutlet weak var lblDonarName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
