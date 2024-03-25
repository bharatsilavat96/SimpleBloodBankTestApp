//
//  BloodBankDetailsTableCell.swift
//  BloodBank
//
//  Created by apple on 23/09/22.
//

import UIKit

class BloodBankDetailsTableCell: UITableViewCell {
    
    

    @IBOutlet weak var bloodCellView: UIView!
    @IBOutlet weak var lblCellAddress: UILabel!
    @IBOutlet weak var lblCellMobileNumber: UILabel!
    @IBOutlet weak var lblCellName: UILabel!
    @IBOutlet weak var lblCellCity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
    
    
    
}
