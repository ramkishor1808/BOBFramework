//
//  TransactVC.swift
//  BOB
//
//  Created by mayank on 18/02/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import UIKit
//import CryptoSwift
@available(iOS 13.0, *)
class TransactVC: BaseClass ,UITextFieldDelegate{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var picker: UIPickerView!
    var index = Int()
    var tranactArr   =  ["Buy","SIP","Redeem","Switch","SWP","STP"]
    var tranactDataArr     = [[String : Any]]()
    var SearchString = String()
    var SearchArray = [[String : Any]]()
    var isSearchEnable = false
    var isComingDashboard = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate  =  self
        self.searchField.delegate = self
        
      //  let identifier = UUID()
    //    let testString = "\(identifier)|BOBWealth"

        if(isComingDashboard == true)
        {
            self.setNavigationtitle(titleText : "Transact",view: self,rightImage : "back")
        }else{
            self.setNavigationtitle(titleText : "Transact",view: self,rightImage : "menu")
        }
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.pickerView.isHidden  =  true
        AccountAPICalling()
        // Do any additional setup after loading the view.
    }
    func AccountAPICalling() {
    //  {"ClientCode":34,"L4ClientCode":70,"BankAccountTranNo":2,"IsPortal":1}
               self.start_Loader()
               let identifier = UUID()
               let testString = "\(identifier)|BOBWealth"
      
               let json = ["RequestBody":["ClientCode":34],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
                   let jsonString1 = json.jsonDic
                    
                let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
                let encToken = try! testString.aesEncrypt()
                let enc = try! str.aesEncrypt()
      
                APIManager.shareInstance.AuthenticationRequest(method: "Client/Accounts", TPA: encToken, parameter: enc){
                           (netResponse) -> (Void) in
                           if(netResponse.statusCode == 200){
                                  self.stop_Loader()
                               print(netResponse.responseDict as Any)
                            GlobleValue.InvestertAccDataArray = netResponse.responseDict as? [[String : Any]] ?? [[:]]
                              

                }
                self.stop_Loader()
                }
    }
    override func viewDidLayoutSubviews() {
        self.searchView.set_View_Border(viewName: self.searchView, borderColor: .gray, borderWidth: 1, corner: 5)
        self.pickerView.set_View_Border(viewName: self.pickerView, borderColor: .gray, borderWidth: 1, corner: 5)
    }
    @IBAction func pickerDoneAct(_ sender: Any) {
        self.pickerView.isHidden  =  true
    }
    
    func searchWithName(searchkey:String) {
        isSearchEnable = true
        self.SearchArray.removeAll()
        let foundItems = GlobleValue.HoldingDataArray.filter { ($0["SchemeName"] as! String).contains(self.SearchString.lowercased()) || ($0["SchemeName"] as! String).contains(self.SearchString.uppercased()) }
        print(foundItems)
        self.SearchArray = foundItems
        tableView.reloadData()
    }
    
}
@available(iOS 13.0, *)
extension TransactVC : UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearchEnable == false){
        return  GlobleValue.HoldingDataArray.count
        }else{
            return SearchArray.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TransactCell
        cell.tag   =  indexPath.row
        index  =  indexPath.row
        cell.schemeNameLbl.text = GlobleValue.HoldingDataArray[indexPath.row]["SchemeName"] as? String
        if let Folio = GlobleValue.HoldingDataArray[indexPath.row]["Folio"]  as? Int {
        
                          cell.foliocNoLbl.text =  "\(Folio)"
                       } else {
                            cell.foliocNoLbl.text = GlobleValue.HoldingDataArray[indexPath.row]["Folio"] as? String ?? ""
                       }
        if let unit = GlobleValue.HoldingDataArray[indexPath.row]["Quantity"]  as? Double {
        
                          cell.unitNoLbl.text =  "\(unit)"
                       } else {
                            cell.unitNoLbl.text = ""// Was not a string
                       }
        if let cost = GlobleValue.HoldingDataArray[indexPath.row]["ValueOfCost"]  as? Double {
        
                          cell.costLbl.text =  "\(cost)"
                       } else {
                            cell.costLbl.text = ""// Was not a string
                       }
        if let netGain = GlobleValue.HoldingDataArray[indexPath.row]["NetGain"]  as? Double {
               
                                 cell.netGainNoLbl.text =  "\(netGain)"
                              } else {
                                   cell.netGainNoLbl.text = ""// Was not a string
                              }
        
        if let MarketValue = GlobleValue.HoldingDataArray[indexPath.row]["MarketValue"]  as? Double {
        
                          cell.marketValueLbl.text =  "\(MarketValue)"
                       } else {
                            cell.marketValueLbl.text = ""// Was not a string
                       }
        if let xirrPer = GlobleValue.HoldingDataArray[indexPath.row]["GainLossPercentage"]  as? Double {
        
                          cell.xirrLbl.text =  "\(xirrPer)"
                         cell.netGainPerLbl.text = "\(xirrPer)"
                       } else {
                            cell.xirrLbl.text = ""// Was not a string
                       }
//            let xirrPer = tranactDataArr[indexPath.row]["FolioNumber"]  as? Double {
//                 let x = xirrPer.rounded(toPlaces: 1)
//                  cell.foliocNoLbl.text =  "\(x)%"
//              } else {
//                  print("Error") // Was not a string
//              }
//               cell.foliocNoLbl.text = tranactDataArr[indexPath.row]["FolioNumber"] as? String
              
        cell.unitNoLbl.text = "\(GlobleValue.HoldingDataArray[indexPath.row]["Quantity"] as? Double ?? 0.0)"
              // cell.xirrPerLbl.text = tranactDataArr[indexPath.row]["GainLossPercentage"] as? String
        
        cell.selectTransact  = {[weak self] (indexVal) in
            self?.pickerView.isHidden   = false
            self?.picker.reloadAllComponents()
        }
        return cell
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.tranactArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.tranactArr[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0{
            let vc = self.storyboard?.instantiateViewController(identifier: "TansactBuyVC") as! TansactBuyVC
            vc.index = index
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if row == 1{
            let vc = self.storyboard?.instantiateViewController(identifier: "TrasactSTPVC") as! TrasactSTPVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if row == 2{
            let vc = self.storyboard?.instantiateViewController(identifier: "TranacstRedeemVC") as! TranacstRedeemVC
                   
                      self.navigationController?.pushViewController(vc, animated: true)
        }else if row == 3{
            let vc = self.storyboard?.instantiateViewController(identifier: "TrasactSwitchVC") as! TrasactSwitchVC
                   
                      self.navigationController?.pushViewController(vc, animated: true)
        }else if row == 4{
            let vc = self.storyboard?.instantiateViewController(identifier: "TrasactSWPVC") as! TrasactSWPVC
                   
                      self.navigationController?.pushViewController(vc, animated: true)
        }else if row == 5{
            let vc = self.storyboard?.instantiateViewController(identifier: "TrasactSTPVC") as! TrasactSTPVC
                   
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    //MARK:: UITextField Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.SearchString = String()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print(string.count)
        if(string.count>0)
        {
            
            self.SearchString = self.SearchString + string
            print(self.SearchString)
         //   self.searchWithName(0, searchStr: self.SearchString)
            self.searchWithName(searchkey: self.SearchString)
            
        }else{
            
            if(self.SearchString.count>0)
            {
                print(self.SearchString)
                self.SearchString.removeLast()
                
                print(self.SearchString)
                if(self.SearchString.count == 0)
                {
                    //not hit becouse str count 0
                    SearchArray.removeAll()
                    isSearchEnable = false
                    tableView.reloadData()
                    
                    
                }else{
                self.searchWithName(searchkey: self.SearchString)
                }
            }
            
        }
        
        
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // textField.resignFirstResponder();
        return true;
    }
    
}

class TransactCell: UITableViewCell {
    @IBOutlet weak var schemeNameLbl: UILabel!
    @IBOutlet weak var foliocNoLbl: UILabel!
    @IBOutlet weak var transactBtn: UIButton!
    @IBOutlet weak var unitNoLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var netGainNoLbl: UILabel!
    @IBOutlet weak var netGainPerLbl: UILabel!
    @IBOutlet weak var marketValueLbl: UILabel!
    @IBOutlet weak var xirrLbl: UILabel!
    var selectTransact : ((Int) -> ())?
    override class func awakeFromNib() {
        print("Abcd")
    }
    
    @IBAction func transactBtnAct(_ sender: Any) {
        selectTransact?(self.tag)
    }
}
