//
//  splashViewCon.swift
//  BloodBank
//
//  Created by apple on 21/09/22.
//

import UIKit

class splashViewCon: UIViewController {

    @IBOutlet weak var imgHeart: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
          
        imgHeart.layer.borderColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        imgHeart.layer.shadowOffset = CGSize(width: 12,
                                          height: 12)
        imgHeart.layer.shadowRadius = 7
        imgHeart.layer.shadowOpacity = 1.0

        
        perform(#selector(moveToNext), with: nil, afterDelay: 3)
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func moveToNext() {
        
        let splashVC:Splash4VC = self.storyboard?.instantiateViewController(withIdentifier: "Splash4VC") as! Splash4VC
        self.navigationController?.pushViewController(splashVC, animated: true)
    }


}
