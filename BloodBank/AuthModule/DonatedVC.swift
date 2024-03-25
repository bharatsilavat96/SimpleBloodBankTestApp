//
//  DonatedVC.swift
//  BloodBank
//
//  Created by apple on 22/09/22.
//

import UIKit

class DonatedVC: UIViewController {
    
    
    @IBOutlet weak var lblDonated: UILabel!
    @IBOutlet weak var btnGuest: UIButton!
    @IBOutlet weak var btnComplaint: UIButton!
    @IBOutlet weak var btnbegin: UIButton!
    @IBOutlet weak var imgSittingMan: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setBorder(textField: lblDonated)
        self.setBorder(textField: btnGuest)
        self.setBorder(textField: btnComplaint)
        self.setBorder(textField: btnbegin)
        self.setBorder(textField: imgSittingMan)
        
        if self.isKeyPresentInUserDefaults() {
            let donarVC:DonarDetailsTableVC = self.storyboard?.instantiateViewController(withIdentifier: "DonarDetailsTableVC") as! DonarDetailsTableVC
            self.navigationController?.pushViewController(donarVC, animated: false)
            return
        }
        
        
        // Do any additional setup after loading the view.
    }
    func isKeyPresentInUserDefaults() -> Bool {
        return UserDefaults.standard.object(forKey: "userData") != nil
    }
 func setBorder(textField:UIView){
            
            textField.layer.borderColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
            textField.layer.shadowOffset = CGSize(width: 12,
                                       height: 12)
            textField.layer.shadowRadius = 7
            textField.layer.shadowOpacity = 1.0

    }

    @IBAction func actionBegin(_ sender: UIButton) {
         
        let loginVC:LoginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(loginVC, animated: true)
        
    }
    
    @IBAction func actionComplaint(_ sender: UIButton) {
        
        let complaintVC:ComplaintVC = storyboard?.instantiateViewController(withIdentifier: "ComplaintVC") as! ComplaintVC
        
        self.navigationController?.pushViewController(complaintVC, animated: true)
        
        
    }
    
    @IBAction func actionGuest(_ sender: Any) {
        
        let findBankVC:FindBankVC = storyboard?.instantiateViewController(withIdentifier:"FindBankVC") as! FindBankVC
        
        self.navigationController?.pushViewController(findBankVC, animated: true)
    }
    
    
}
