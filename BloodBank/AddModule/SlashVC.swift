//
//  SlashVC.swift
//  BloodBank
//
//  Created by apple on 21/09/22.
//

import UIKit

class SlashVC: UIViewController {

    @IBOutlet weak var lblBloodBank: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var imgHalfHeart: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        perform(#selector(moveToNext), with: nil, afterDelay: 3)
        
        
        self.setBorder(textField: lblBloodBank)
        self.setBorder(textField: imgLogo)
        self.setBorder(textField: imgHalfHeart)
        
        
        // Do any additional setup after loading the view.
    }
    func setBorder(textField:UIView){
               
               textField.layer.borderColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
               textField.layer.shadowOffset = CGSize(width: 6,
                                          height: 6)
               textField.layer.shadowRadius = 4
        textField.layer.shadowOpacity = 0.7

       }

    @objc func moveToNext() {
        
        let viewVC:splashViewCon = self.storyboard?.instantiateViewController(withIdentifier: "splashViewCon") as! splashViewCon
        
//        present(viewVC, animated: true)
        self.navigationController?.pushViewController(viewVC, animated: true)
    }

}
