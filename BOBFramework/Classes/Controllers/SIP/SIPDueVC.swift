//
//  SIPDueVC.swift
//  BOB
//
//  Created by Anushree on 3/10/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import Foundation
import UIKit
//import SVProgressHUD
@available(iOS 13.0, *)
class SIPDueVC: BaseClass {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchView: UIView!
     @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var goBtn: UIButton!
       var SIPDataArr     = [[String : Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()

       self.pickerView.isHidden  =  true
        
        self.setNavigationtitle(titleText : "Holdings",view: self,rightImage : "menu")
           self.navigationController?.setNavigationBarHidden(false, animated: true)
        APICalling()
    }
    func APICalling(){
        //{"UserId":"admin","FamCode":0,"HeadCode":"32","ClientCode":0,"FromDate":"2020/06/14","ToDate":"2020/06/21","ClientType":"H","Ucc":"069409856","Report_Type":"SUMMARY"}
              let identifier = UUID()
              let testString = "\(identifier)|BOBWealth"
         self.start_Loader()
             let json = ["RequestBody":["UserId":"admin","FamCode":0,"HeadCode":"32","ClientCode":0,"FromDate":"2020/06/14","ToDate":"2020/06/21","ClientType":"H","Ucc":"069409856","Report_Type":"SUMMARY"],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
                              let jsonString1 = json.jsonDic
                              
                                  let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
                                  let encToken = try! testString.aesEncrypt()
                                  let enc = try! str.aesEncrypt()
        APIManager.shareInstance.AuthenticationRequest(method: "Client/SIPDueReport", TPA: encToken, parameter: enc){
                                 (netResponse) -> (Void) in
                                 if(netResponse.statusCode == 200){
                                      self.stop_Loader()
                                   //  print(netResponse.responseDict as Any)
                                     self.SIPDataArr = netResponse.responseDict as? [[String : Any]] ?? [[:]]
                                    // print(GlobleValue.SIPDueDataArray)
                                     self.SIPDataArr = GlobleValue.SIPDueDataArray
                                     print(self.SIPDataArr)
                                  DispatchQueue.main.async {
                                    if self.SIPDataArr.isEmpty{
                                                                        self.showMessage("Data not found", type: .info)
                                                                     }
                                      self.tableView.reloadData()
                                  }
                                 }else{
                                     self.stop_Loader()
            }
                                 }
    
}
//    override func viewDidLayoutSubviews() {
//        self.searchView.set_View_Border(viewName: self.searchView, borderColor: .gray, borderWidth: 1, corner: 5)
//    }
    @IBAction func GoAction(_ sender: Any) {
       }
       @IBAction func DateAction(_ sender: Any) {
           let formatter = DateFormatter()
               formatter.dateFormat = "dd-MMM-yyyy"
           dateBtn.setTitle(formatter.string(from: picker.date), for: .normal)
          
            self.pickerView.isHidden  =  false
       }
       @IBAction func pickerDoneAct(_ sender: Any) {
           self.pickerView.isHidden  =  true
       }
}
@available(iOS 13.0, *)
extension SIPDueVC : UITableViewDataSource,UITableViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  SIPDataArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SIPDueVCCell
        cell.tag   =  indexPath.row
       
        cell.schemeNameLbl.text = SIPDataArr[indexPath.row]["Fund_Name"] as? String
         cell.dateLbl.text = SIPDataArr[indexPath.row]["DueDate"] as? String
         cell.type.text = SIPDataArr[indexPath.row]["Type"] as? String
        cell.folioLbl.text = SIPDataArr[indexPath.row]["FolioNo"] as? String
        
        if let Amount = SIPDataArr[indexPath.row]["Amount"] as? Int {
          // let x = Amount.rounded(toPlaces: 1)
            cell.amountLbl.text =  "\(Amount)"
        } else {
            print("Error") // Was not a string
        }
       // cell.amountLbl.text = "\(SIPDataArr[indexPath.row]["Amount"] as? Int )"
       

       
//               cell.selectTransact  = {[weak self] (indexVal) in
//                   self?.pickerView.isHidden   = false
//                   self?.picker.reloadAllComponents()
//               }
        return cell
    }
}

class SIPDueVCCell: UITableViewCell {
    @IBOutlet weak var schemeNameLbl: UILabel!
    @IBOutlet weak var transactBtn: UIButton!
    
    @IBOutlet weak var folioLbl: UILabel!
    @IBOutlet weak var unitLbl: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    var selectTransact : ((Int) -> ())?
    override class func awakeFromNib() {
        print("Abcd")
    }
    
//    @IBAction func transactBtnAct(_ sender: Any) {
//        selectTransact?(self.tag)
//    }
}
