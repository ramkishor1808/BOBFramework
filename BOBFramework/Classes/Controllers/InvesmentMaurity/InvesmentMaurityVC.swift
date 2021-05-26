//
//  InvesmentMaurityVC.swift
//  BOB
//
//  Created by Anushree on 3/11/21.
//  Copyright © 2021 Mayank. All rights reserved.
//
import Foundation
import UIKit
import CryptoSwift
//import SVProgressHUD
@available(iOS 13.0, *)
class InvesmentMaurityVC: BaseClass {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var goBtn: UIButton!
    
    var tranactArr   =  ["Buy","SIP","Redeem","Switch","SWP","STP"]
     var InvestmentMaurityDataArr     = [[String : Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.picker.delegate  =  self
     self.pickerView.isHidden  =  true
        //              let Url = String(f
        
        self.setNavigationtitle(titleText : "Investment Maurities",view: self,rightImage : "menu")
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.pickerView.isHidden  =  true
        self.APICalling()
        // Do any additional setup after loading the view.
    }
   
    func APICalling(){
        //{"FromDate":"20200101","Head_Code":32,"Till_Date":"20210301"}
               self.start_Loader()
                let identifier = UUID()
                let testString = "\(identifier)|BOBWealth"
                let json = ["RequestBody":["FromDate":"20160101","Till_Date":"20200614","Head_Code":"32"],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
                let jsonString1 = json.jsonDic
                let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
                              let encToken = try! testString.aesEncrypt()
                             let enc = try! str.aesEncrypt()
                 APIManager.shareInstance.AuthenticationRequest(method: "Client/InvestmentMaturityReport", TPA: encToken, parameter: enc){
                            (netResponse) -> (Void) in
                            if(netResponse.statusCode == 200){
                                 self.stop_Loader()
                                print(netResponse.responseDict as Any)
                                self.InvestmentMaurityDataArr = netResponse.responseDict as? [[String : Any]] ?? [[:]]
                                
                                
                                DispatchQueue.main.async {
                                    if self.InvestmentMaurityDataArr.isEmpty{
                                       self.showMessage("Data not found", type: .info)
                                    }
                                    self.tableView.reloadData()
                                                           }
                            }else{
                                self.showMessage("Data not found", type: .success)
                                self.stop_Loader()
                    }
                            }
    }
    override func viewDidLayoutSubviews() {
        self.goBtn.set_View_Border(viewName: self.searchView, borderColor: .clear, borderWidth: 0, corner: 3)
        self.dateBtn.set_View_Border(viewName: self.searchView, borderColor: .gray, borderWidth: 1, corner: 0)
        self.pickerView.set_View_Border(viewName: self.pickerView, borderColor: .gray, borderWidth: 1, corner: 5)
    }
    
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
extension InvesmentMaurityVC : UITableViewDataSource,UITableViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.InvestmentMaurityDataArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InvesmentMaurityCell
        cell.tag   =  indexPath.row
         cell.schemeNameLbl.text = InvestmentMaurityDataArr[indexPath.row]["Sch_Name"] as? String
        
             if   let currentValue = InvestmentMaurityDataArr[indexPath.row]["CostOnInvestment"]  as? Int {
       
                          cell.currentValueLbl.text =  "\(currentValue)"
                      } else {
                          print("Error") // Was not a string
                      }

//             cell.InvestmentAccLbl.text = InvestmentMaurityDataArr[indexPath.row]["FolioNumber"] as? String
              
              
              cell.maurityDateLbl.text = InvestmentMaurityDataArr[indexPath.row]["Date"] as? String
        
        
        return cell
    }
    
    
    
    
}

class InvesmentMaurityCell: UITableViewCell {
    @IBOutlet weak var schemeNameLbl: UILabel!
    @IBOutlet weak var maurityDateLbl: UILabel!
    @IBOutlet weak var transactBtn: UIButton!
   
    @IBOutlet weak var currentValueLbl: UILabel!
    @IBOutlet weak var InvestmentAccLbl: UILabel!
    var selectTransact : ((Int) -> ())?
    override class func awakeFromNib() {
        print("Abcd")
    }
    
    @IBAction func transactBtnAct(_ sender: Any) {
        selectTransact?(self.tag)
    }
}
