//
//  LoginVC.swift
//  BloodBank
//
//  Created by apple on 22/09/22.
//

import UIKit
import  IQKeyboardManagerSwift

class LoginVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var viewLogin: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        viewLogin.layer.cornerRadius = 8
        viewLogin.layer.borderWidth = 1
        viewLogin.layer.borderColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        viewLogin.layer.shadowOffset = CGSize(width: 12,
                                          height: 12)
        viewLogin.layer.shadowRadius = 5
        viewLogin.layer.shadowOpacity = 0.8

        // Do any additional setup after loading the view.
    }
  
    
    @IBAction func actionLogin(_ sender: UIButton) {
        
////        let userName = txtEmail!.text!
          let userName = "BharatSilavat"
////        let password = txtPassword!.text!
          let password = "Bharat@131021"
        //make swift dictionary and convert to JSON object
//        let bloodbankLoginArray:[String:Any] = ["username":userName, "password":password]
        
        if userName == txtEmail.text && password == txtPassword.text{
            let donarVC:DonarDetailsTableVC = self.storyboard?.instantiateViewController(withIdentifier: "DonarDetailsTableVC") as! DonarDetailsTableVC
            self.navigationController?.pushViewController(donarVC, animated: true)
        }
        
        
//        do{
//            let jsonData : Data =  try JSONSerialization.data(withJSONObject: bloodbankLoginArray, options: JSONSerialization.WritingOptions.prettyPrinted)
//
//            //send this data to server using POST request
//            let myURL:URL=URL(string: "https://bloodbanka.pythonanywhere.com/bloodbank_login")!
//            var req:URLRequest = URLRequest(url: myURL)
//            req.httpMethod="POST"
//            req.httpBody = jsonData
//            req.addValue("\(jsonData.count)", forHTTPHeaderField: "Content-Length")
//            req.addValue("json/application", forHTTPHeaderField: "Content-Type")
//
//            let session:URLSession = URLSession.shared
//            let dataTask:URLSessionDataTask = session.dataTask(with: req, completionHandler: handlePostResponse(data:response:error:) )
//
//            dataTask.resume()
//
//        }catch{
//            print("JSON conversion error", error)
//        }
        
    }
    
    //function to handle response

    func handlePostResponse(data:Data?, response:URLResponse?, error:Error?) ->Void
    {
        if(data != nil)
        {
            let respCode = (response as! HTTPURLResponse).statusCode
            if(respCode == 200){
                print("Blood Bank login  succesfully")
                do{
                let donar:[String:Any] = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:Any]
                    DispatchQueue.main.async {
                        UserDefaults.standard.setValue(donar, forKey: "userData")

                        let donarVC:DonarDetailsTableVC = self.storyboard?.instantiateViewController(withIdentifier: "DonarDetailsTableVC") as! DonarDetailsTableVC
                        self.navigationController?.pushViewController(donarVC, animated: true)
                    }
                    
                    
                print(donar)
                }catch{
                    print("login error", error)
                }
            }
        }
    
    }
    
    
    
        
    
    }
    
    
    

