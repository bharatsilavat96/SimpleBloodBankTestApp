//
//  ComplaintVC.swift
//  BloodBank
//
//  Created by apple on 23/09/22.
//

import UIKit
import SwiftLoader

class ComplaintVC: UIViewController {

//    var ComplaintArray:[[String:Any]] = []
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var textViewComplaint: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setBorder(textField: textViewComplaint)
        self.setBorder(textField: txtFirstName)
        self.setBorder(textField: txtLastName)
        self.setBorder(textField: txtMobileNumber)
        self.setBorder(textField: btnSubmit)
        
       
    }
    func setBorder(textField:UIView){
        
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        textField.layer.shadowOffset = CGSize(width: 12,
                                          height: 12)
        textField.layer.shadowRadius = 7
        textField.layer.shadowOpacity = 1.0
    }

   

    @IBAction func actionSubmit(_ sender: Any) {
        let firstName = txtFirstName!.text
        let lastName = txtLastName!.text
        let complaintBox = textViewComplaint!.text
        let mobno = Int(txtMobileNumber!.text!) ?? nil
        SwiftLoader.show(title: "Loading...", animated: true)
        self.postAction()
        
        let ComplaintArray:[String:Any] = ["compl_f_name":firstName,"compl_l_name":lastName,"compl_phone":mobno,"compl_massage":complaintBox]
        
        //JSON CONVERSION
        do{
        let JsonData:Data = try JSONSerialization.data(withJSONObject: ComplaintArray, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let complaintURL:URL = URL(string: "http://bloodbanka.pythonanywhere.com/complain")!
        let session:URLSession = URLSession.shared
            
            
        var request:URLRequest = URLRequest.init(url:complaintURL)
            request.httpMethod = "POST"
            request.httpBody = JsonData
            request.addValue("\(JsonData.count)", forHTTPHeaderField: "Content-Length")
            request.addValue("json/application", forHTTPHeaderField: "Content-Type")
        
            let dataTask:URLSessionDataTask = session.dataTask(with: request, completionHandler: taskData(data:response:error:))
          
            
          
            dataTask.resume()
                             
        }catch{
            
            print("ERROR IN DATA POSTING")
        }
    }
    func postAction() {
        let firstName = txtFirstName!.text
        let lastName = txtLastName!.text
        let complaintBox = textViewComplaint!.text
        let mobno = Int(txtMobileNumber!.text!)!

        let Url = String(format: "http://bloodbanka.pythonanywhere.com/complain")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = ["compl_f_name":firstName!,"compl_l_name":lastName!,"compl_phone":mobno,"compl_massage":complaintBox!] as [String : Any]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            SwiftLoader.hide()
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    func taskData(data:Data?,response:URLResponse?,error:Error?)->Void{
//       print(data!)
//        print(response!)
        if (data != nil)
        {
            let responseCode = (response as! HTTPURLResponse).statusCode
            print(response ?? nil)

            if(responseCode == 200){
                
                do{
                    let ComplaintDict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:Any]
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Complain Send Sucessfully", message: "Message", preferredStyle: UIAlertController.Style.alert)
                        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive) { UIAlertAction in
                            self.navigationController?.popViewController(animated: true)
                            //self.dismiss(animated:true)
                        }
                        alert.addAction(ok)
                        
                        self.present(alert, animated: true)
                    }
                }catch{
                    
                    print("ERROR IN DICTIONARY COMPLAINT")
                }
            }
        }
    
        DispatchQueue.main.async {
            //self.navigationController?.popViewController(animated: true)
          
        }
    }

}
