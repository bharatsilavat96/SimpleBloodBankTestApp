//
//  Splash4VC.swift
//  BloodBank
//
//  Created by apple on 21/09/22.
//

import UIKit

class Splash4VC: UIViewController {

    @IBOutlet weak var imgMan: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        imgMan.layer.borderColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        imgMan.layer.shadowOffset = CGSize(width: 12,
                                          height: 12)
        imgMan.layer.shadowRadius = 7
        imgMan.layer.shadowOpacity = 1.0

        
        perform(#selector(moveToNext), with: nil, afterDelay: 3)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    @objc func moveToNext() {
        
        let donatedVC:DonatedVC = self.storyboard?.instantiateViewController(withIdentifier: "DonatedVC") as! DonatedVC
        self.navigationController?.pushViewController(donatedVC, animated: true)
    }
}
