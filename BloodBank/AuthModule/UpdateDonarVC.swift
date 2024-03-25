//
//  UpdateDonarVC.swift
//  BloodBank
//
//  Created by apple on 29/09/22.
//

import UIKit

class UpdateDonarVC: UIViewController {
    
    
    var donarData:[String:Any] = [:]
    var donarCon:DonarDetailsTableVC?
    @IBOutlet weak var lblUpdateGroup: UILabel!
    @IBOutlet weak var lblUpdateDate: UILabel!
    @IBOutlet weak var lblDonarId: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var lblUpdateAddress: UILabel!
    @IBOutlet weak var lblUpdateCity: UILabel!
    @IBOutlet weak var lblUpateDonarName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblDonarId!.text = "id - \(donarData["id"] as! Int) "
        lblUpateDonarName!.text = donarData["donor_name"] as? String
        lblUpdateCity!.text = donarData["donor_city"] as! String
        lblMobileNumber!.text = donarData["donor_contact_number"] as! String
        lblUpdateAddress!.text = donarData["donor_address"] as! String
        lblUpdateDate!.text = donarData["donor_collection_date"] as! String
        lblUpdateGroup!.text = donarData["donor_blood_group"] as! String
        
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func actionDelete(_ sender: UIButton) {
       
        let delUrl=URL(string: "https://bloodbanka.pythonanywhere.com/blooddonor/\(lblDonarId)/")
        var request:URLRequest = URLRequest(url: delUrl!)
        let session:URLSession = URLSession.shared
        
        let deleteTask = session.dataTask(with: delUrl!, completionHandler: self.deleteHandler(data:response:error:) )
        
    }
    func deleteHandler(data:Data?, response:URLResponse?, error:Error?)->Void
    {
        print(error,data,response)
        let respCode = (response as! HTTPURLResponse).statusCode
        if(respCode==200){
            print("Delete succesfull")
            donarData.removeValue(forKey: "\(lblDonarId)")
        }
        
//        indexPathToDelete=nil
        DispatchQueue.main.async {
//            DonarDetailsTableVC!.tableView.reloadData()
        }
       
    }
    
    
    
    
    
    @IBAction func actionUpdate(_ sender: UIButton) {
        
        let name = lblUpateDonarName!.text!
        let mobno = Int(lblMobileNumber!.text!)!
        let city = lblUpdateCity!.text!
        
        //make swift dictionary and convert to JSON object
        var patientNewData:[String:Any] = ["name":name, "age":mobno, "gender":city]
        
        do{
            let jsonData : Data =  try JSONSerialization.data(withJSONObject: patientNewData, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //send this data to server using POST request
            let myURL:URL=URL(string: "https://todearhemant.pythonanywhere.com/patient/api/patients/\(donarData["id"] as! Int)/")!
            
            var req:URLRequest = URLRequest(url: myURL)
            req.httpMethod="PUT"
            req.httpBody = jsonData
            req.addValue("\(jsonData.count)", forHTTPHeaderField: "Content-Length")
            req.addValue("json/application", forHTTPHeaderField: "Content-Type")
            
            let session:URLSession = URLSession.shared
            let dataTask:URLSessionDataTask = session.dataTask(with: req, completionHandler: handlePutResponse(data:response:error:) )
            
            dataTask.resume()
            
        }catch{
            print("JSON conversion error", error)
        }
        
    }
    
    
    //function to handle response
    func handlePutResponse(data:Data?, response:URLResponse?, error:Error?) ->Void
    {
        if(data != nil)
        {
            let respCode = (response as! HTTPURLResponse).statusCode
            if(respCode == 200){
                print("Patient record updated succesfully")
                do{
                let patient:[String:Any] = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:Any]
                print(patient)
                }catch{
                    print("JSON error", error)
                }
            }
        }
     
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
       
        
    }
    
    
    @IBAction func actionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
}
    

