//
//  FindBankVC.swift
//  BloodBank
//
//  Created by apple on 23/09/22.
//

import UIKit

class FindBankVC: UIViewController{
    
    
    @IBOutlet weak var btnOnegative: UIButton!
    @IBOutlet weak var btnOpositive: UIButton!
    @IBOutlet weak var btnBnegative: UIButton!
    @IBOutlet weak var btnBpositive: UIButton!
    @IBOutlet weak var btnABnegative: UIButton!
    @IBOutlet weak var btnABpositive: UIButton!
    @IBOutlet weak var btnAnegative: UIButton!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var btnApositive: UIButton!
    @IBOutlet weak var viewFindBlood: UIView!
    
    var strBloodGroup = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewFindBlood.layer.cornerRadius = 8
        viewFindBlood.layer.borderWidth = 1
        viewFindBlood.layer.borderColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        viewFindBlood.layer.shadowOffset = CGSize(width: 12,
                                                  height: 12)
        viewFindBlood.layer.shadowRadius = 5
        viewFindBlood.layer.shadowOpacity = 0.8
        // Do any additional setup after loading the view.
        
        
    }
    
    
    
    @IBAction func actionButtons(_ sender: UIButton) {
        strBloodGroup = getBloodGroup(sender: sender)
    }
    
    
    
    @IBAction func actionRequest(_ sender: Any) {
        
        let loct = txtLocation!.text!
        
        //make swift dictionary and convert to JSON object
        
        let loctArray:[String:Any] = ["blood_bank_city":loct, "donor_blood_group":strBloodGroup]
        
        do{
            let jsonData : Data =  try JSONSerialization.data(withJSONObject: loctArray, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //send this data to server using POST request
            let myURL:URL=URL(string: "http://bloodbanka.pythonanywhere.com/search_bloodbank")!
            var req:URLRequest = URLRequest(url: myURL)
            req.httpMethod="POST"
            req.httpBody = jsonData
            req.addValue("\(jsonData.count)", forHTTPHeaderField: "Content-Length")
            req.addValue("json/application", forHTTPHeaderField: "Content-Type")
            
            let session:URLSession = URLSession.shared
            let dataTask:URLSessionDataTask = session.dataTask(with: req, completionHandler: handlePostResponse(data:response:error:) )
            
            dataTask.resume()
            
        }catch{
            print("JSON conversion error", error)
        }
        
    }
    func getBloodGroup(sender:UIButton) -> String {
        switch sender {
        case btnAnegative:
            return "A-"
        case btnApositive: return "A+"
        case btnBpositive: return "B+"
        case btnBnegative: return "B-"
        case btnOpositive: return "O+"
        case btnOnegative: return "O-"
        case btnABpositive: return "AB+"
        case btnABnegative: return "AB-"
        default:
            return ""
        }
    }
    //function to handle response
    
    func handlePostResponse(data:Data?, response:URLResponse?, error:Error?) ->Void
    {
        if(data != nil)
        {
            let respCode = (response as! HTTPURLResponse).statusCode
            if(respCode == 200){
                print(" Search Succesfull")
                do{
                    let donar:[String:Any] = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:Any]
                    print(donar)

                    DispatchQueue.main.async {
                       
                           
                        let bloodVC:BloodBankDetailVCViewController = self.storyboard?.instantiateViewController(withIdentifier: "BloodBankDetailVCViewController") as! BloodBankDetailVCViewController
                        bloodVC.bloodBankArray = donar["data"] as! [[String : Any]]
                        self.navigationController?.pushViewController(bloodVC, animated: true)
                    }
                    
                    print(donar)
                }catch{
                    print("Searching error", error)
                }
            }
        }
    }
}
    


