//
//  BankDetailsTableVC.swift
//  BloodBank
//
//  Created by apple on 24/09/22.
//

import UIKit

class DonarDetailsTableVC
: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var donarArray:[[String:Any]] = []
    var indexPathToDelete:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        // Do any additional setup after loading the view.
    }
    //MARK: Tableview methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donarArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellId = "CellId"
        var cell  = tableView.dequeueReusableCell(withIdentifier: cellId) as? DonarDetailVCTableViewCell
        if (cell == nil){
            
            let arrCell = Bundle.main.loadNibNamed("DonarDetailVCTableViewCell", owner: self, options:nil)
            cell = arrCell?.last as? DonarDetailVCTableViewCell
        }
        let donarObj:[String:Any] = donarArray[indexPath.row]
        cell?.lblDonarName!.text = "\(donarObj["donor_name"] ?? "")"
        cell?.lblDonarCity!.text = "\(donarObj["donor_city"] ?? "")"
        cell?.lblDonarMobileNumber!.text = "\(donarObj["donor_contact_number"] ?? "")"
        cell?.lblDonarAddress!.text = "\(donarObj["donor_address"] ?? "")"
        cell?.lblDonarBloodGroup!.text = "\(donarObj["donor_blood_group"] ?? "")"
        
        // seperator in cell
        
        let separatorLineView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 3))
        separatorLineView.backgroundColor = UIColor.white
        cell?.contentView.addSubview(separatorLineView)
                                    
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        indexPathToDelete=nil
        
        let dataDictionary:[String:Any] = donarArray[indexPath.row]
       
        let id =  dataDictionary["id"]
        let name = dataDictionary["donor_name"] as! String
        
        //show options of delete and update on an alert
        let alert = UIAlertController(title: "Select operation", message: "\(name)", preferredStyle: UIAlertController.Style.alert)
        
        let delete = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive) {
        (action:UIAlertAction?) in
            
            //delete using delete API url
            let deleteCon:UpdateDonarVC = self.storyboard?.instantiateViewController(withIdentifier: "UpdateDonarVC") as! UpdateDonarVC
            self.navigationController?.pushViewController(deleteCon, animated: true)
            self.indexPathToDelete=indexPath
         
        }
        alert.addAction(delete)
        present(alert, animated: true)
        
        let update = UIAlertAction(title: "Update", style: UIAlertAction.Style.default)
        {
        (action:UIAlertAction?) in
            
            let updateCon:UpdateDonarVC = self.storyboard?.instantiateViewController(withIdentifier: "UpdateDonarVC") as! UpdateDonarVC
            updateCon.donarData = dataDictionary
            self.navigationController?.pushViewController(updateCon, animated: true)
            
        }
        alert.addAction(update)
        
       
        
     
    }
    override func viewDidAppear(_ animated: Bool) {
        let userData = UserDefaults.standard.value(forKey: "userData") as! NSDictionary
        
        let arrTEmp = userData.value(forKey: "data") as! NSArray
        print(arrTEmp ?? nil)
        let dictTemp = arrTEmp[0] as? NSDictionary
        print(dictTemp)
        let idData = dictTemp?.value(forKey: "id")
        let parameterDictionary = ["bloodbank_donor":idData!] as [String : Any]
        do{
            let jsonData : Data  = try JSONSerialization.data(withJSONObject: parameterDictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let myURL:URL = URL(string: "https://bloodbanka.pythonanywhere.com/bloodbank_donor")!

        var request:URLRequest = URLRequest(url: myURL)
        request.httpMethod="POST"
        request.httpBody = jsonData
        request.addValue("\(jsonData.count)", forHTTPHeaderField: "Content-Length")
        request.addValue("json/application", forHTTPHeaderField: "Content-Type")
        

        let session:URLSession = URLSession.shared
        
            let dataTask:URLSessionDataTask = session.dataTask(with: request, completionHandler: handlePostRequest(urlData:response:error:))
           
        //----start task
            dataTask.resume()
            
        }catch{
            print("JSON conversion error", error)
        }
    }
        func handlePostRequest(urlData:Data? , response:URLResponse? , error:Error?)->Void{
            //check response status code
            print(response)
            if(urlData != nil)
            {
               
                let respCode = (response as! HTTPURLResponse).statusCode
                if(respCode == 200){
                    print("Data loaded Sucessfully")
                    do{
                    let donarData:[String:Any] = try JSONSerialization.jsonObject(with: urlData!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:Any]
                        self.donarArray = donarData["data"] as! Array
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    print(donarArray)
                    }catch{
                        print("Data loading error", error)
                    }
                }
            }
        
        }
        
        
        

//show delete update option on row selection

 
    //delete completion handler
    
    func deleteHandler(data:Data?, response:URLResponse?, error:Error?)->Void
    {
        print(error,data,response)
        let respCode = (response as! HTTPURLResponse).statusCode
        if(respCode==200){
            print("Delete succesfull")
            donarArray.remove(at: indexPathToDelete!.row)
        }
        
        indexPathToDelete=nil
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
       
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
}
