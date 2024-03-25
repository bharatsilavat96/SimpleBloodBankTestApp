//
//  BloodBankDetailVCViewController.swift
//  BloodBank
//
//  Created by apple on 23/09/22.
//

import UIKit

class BloodBankDetailVCViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    
    @IBOutlet weak var tableView: UITableView!
    
   
    var bloodBankArray:[[String:Any]] = []
//    var indexPathToDelete:IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(bloodBankArray)
        // Do any additional setup after loading the view.
    }
   // MARK : TABLEVIEW METHODS
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bloodBankArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellId = "CellId"
        var cell  = tableView.dequeueReusableCell(withIdentifier: cellId) as? BloodBankDetailsTableCell
        if (cell == nil){
            
            let arrCell = Bundle.main.loadNibNamed("BloodBankDetailsTableCell", owner: self, options:nil)
            cell = arrCell?.last as? BloodBankDetailsTableCell
        }
        let bankObj:[String:Any] = bloodBankArray[indexPath.row]
        cell?.lblCellName!.text = "\(bankObj["blood_bank_name"] ?? "")"
        cell?.lblCellCity!.text = "\(bankObj["city"] ?? "")"
        cell?.lblCellMobileNumber!.text = "\(bankObj["contact_number"] ?? "")"
        cell?.lblCellAddress!.text = "\(bankObj["address"] ?? "")"
        
        
        // seperator in cell
        
        let separatorLineView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 3))
        separatorLineView.backgroundColor = UIColor.white
        cell?.contentView.addSubview(separatorLineView)
                                    
        return cell!
    }
    

       

    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
