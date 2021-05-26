//
//  InvertmentCartVC.swift
//  BOB
//
//  Created by Anushree on 3/17/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import Foundation
import UIKit
import CryptoSwift
//import SVProgressHUD
@available(iOS 13.0, *)
class InvertmentCartVC: BaseClass , CustomSegmentedControlDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerSubView: UIView!
    @IBOutlet weak var producTypeLbl: UILabel!
    @IBOutlet weak var fundLbl: UILabel!
    @IBOutlet weak var AmountLbl: UILabel!
    @IBOutlet weak var InvestAmtLbl: UILabel!
    @IBOutlet weak var BankAccLbl: UILabel!
    @IBOutlet weak var InvestAmtBtn: UIButton!
    @IBOutlet weak var BankAccBtn: UIButton!
    @IBOutlet weak var pickerView: UIView!
    
    @IBOutlet weak var picker: UIPickerView!
    var pickerFlag : Bool!
    var BankAccDataArr     = [[String : Any]]()
    var InvestmentCartDataArr     = [[String : Any]]()
    var tableArray     = [[String : Any]]()
    var AccDataArr     = [[String : Any]]()
    var countDataArr     = [[String : Any]]()
    var pickerDataArr     = [[String : Any]]()
    
    let formatter = NumberFormatter()
   
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        self.pickerView.isHidden  =  true
        self.picker.isHidden  =  true
        
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50), buttonTitle: ["Buy","SIP","Redeem","Switch","SWP","STP"])
        codeSegmented.backgroundColor = .clear
        codeSegmented.delegate = self
        view.addSubview(codeSegmented)
        
        
        
        self.setNavigationtitle(titleText : "InvertmentCart",view: self,rightImage : "back")
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        countAPICalling()
        // InvestmentCartDetailsAPICalling()
        
        // Do any additional setup after loading the view.
        
        formatter.numberStyle = .currency
       // formatter.locale = .current
    }
    func countAPICalling() {
        //{"ClientCode":34,"ParentChannelID":"WMSPortal"}
        self.start_Loader()
        let identifier = UUID()
        let testString = "\(identifier)|BOBWealth"
        
        let json = ["RequestBody":["ClientCode":32,"ParentChannelID":"WMSPortal"],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
        let jsonString1 = json.jsonDic
        let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
        let encToken = try! testString.aesEncrypt()
        let enc = try! str.aesEncrypt()
        
        APIManager.shareInstance.AuthenticationRequest(method: "Order/InvestmentCartCount", TPA: encToken, parameter: enc){ [self]
            (netResponse) -> (Void) in
            if(netResponse.statusCode == 200){
                self.stop_Loader()
                print(netResponse.responseDict as Any)
                self.countDataArr = netResponse.responseDict as? [[String : Any]] ?? [[:]]
                print(self.countDataArr)
                ShowTranCount(Index: 0)
                DispatchQueue.main.async {
                    if self.countDataArr.isEmpty{
                        self.showMessage("Data not found", type: .info)
                    }else{
                        self.AccountAPICalling()
                    }
                }
            }
            self.stop_Loader()
        }
    }
    
    func ShowTranCount(Index:Int)
    {
        let count = self.countDataArr[Index]["TranCount"] as? Int ?? 0
        DispatchQueue.main.async {
        self.fundLbl.text = "\(count) Founds"
        }
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
                self.AccDataArr = netResponse.responseDict as? [[String : Any]] ?? [[:]]
                DispatchQueue.main.async {
                    
                    if self.AccDataArr.isEmpty{
                        self.showMessage("Data not found", type: .info)
                    }else{
                        self.BankAccountAPICalling()
                    }
                    
                    
                }
                
            }
            self.stop_Loader()
        }
    }
    func BankAccountAPICalling() {
        //  {"ClientCode":34,"L4ClientCode":70,"BankAccountTranNo":2,"IsPortal":1}
        self.start_Loader()
        let identifier = UUID()
        let testString = "\(identifier)|BOBWealth"
        
        let json = ["RequestBody":["ClientCode":32,"L4ClientCode":70,"BankAccountTranNo":2,"IsPortal":1],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
        let jsonString1 = json.jsonDic
        
        
        let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
        let encToken = try! testString.aesEncrypt()
        let enc = try! str.aesEncrypt()
        
        APIManager.shareInstance.AuthenticationRequest(method: "Client/BankAccount", TPA: encToken, parameter: enc){
            (netResponse) -> (Void) in
            if(netResponse.statusCode == 200){
                self.stop_Loader()
                print(netResponse.responseDict as Any)
                self.BankAccDataArr = netResponse.responseDict as? [[String : Any]] ?? [[:]]
                DispatchQueue.main.async {
                    if self.BankAccDataArr.isEmpty{
                        self.showMessage("Data not found", type: .info)
                    }
                    self.InvestmentCartDetailsAPICalling()
                    
                }
                
            }
            self.stop_Loader()
        }
    }
    func InvestmentCartDetailsAPICalling() {
        self.start_Loader()
        let identifier = UUID()
        let testString = "\(identifier)|BOBWealth"
        //{"RequestBody":{"ClientCode":"32","ParentChannelID":"WMSPortal"},"Source":"BOBWealth","UniqueIdentifier":"c172d268-0ace-45b9-adeb-1931824b3248"}
        let json = ["RequestBody":["ClientCode":"32","ParentChannelID":"WMSPortal"],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
        let jsonString1 = json.jsonDic
        let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
        let encToken = try! testString.aesEncrypt()
        let enc = try! str.aesEncrypt()
        
        APIManager.shareInstance.AuthenticationRequest(method: "Order/InvestmentCartDetails", TPA: encToken, parameter: enc){
            (netResponse) -> (Void) in
            if(netResponse.statusCode == 200){
                self.stop_Loader()
                print(netResponse.responseDict as Any)
                self.InvestmentCartDataArr = netResponse.responseDict as? [[String : Any]] ?? [[:]]
                //
                DispatchQueue.main.async {
                    if self.InvestmentCartDataArr.isEmpty{
                        self.showMessage("Data not found", type: .info)
                    }
                    self.tableArray = self.InvestmentCartDataArr.filter{ ($0["TransactionType"] as! String) == "BUY" }
                    print(self.tableArray.count)
               //     self.tableArray = self.InvestmentCartDataArr
                    var taxAmtArr  = [Int]()
                    for Arr in  self.tableArray{
                        taxAmtArr.append(Arr["TxnAmountUnit"] as! Int )
                    }
                    print(taxAmtArr)
                    let total = taxAmtArr.sum()
                    print(total)
                //    self.AmountLbl.text = "\(total)"
                    self.AmountLbl.text = self.formatter.string(from: NSNumber(value: total))
                    self.tableView.reloadData()
                }
            }
            else{
                self.stop_Loader()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.headerSubView.shadowOpacity(view: self.headerSubView, radius: 2)
        self.InvestAmtBtn.set_View_Border(viewName: self.InvestAmtBtn, borderColor: .lightGray, borderWidth: 1, corner: 5)
        self.BankAccBtn.set_View_Border(viewName: self.BankAccBtn, borderColor: .lightGray, borderWidth: 1, corner: 5)
    }
    func change(to index:Int) {
        print("segmentedControl index changed to \(index)")
        if index == 0 {
            tableArray = self.InvestmentCartDataArr.filter{ ($0["TransactionType"] as! String) == "BUY" }
            print(tableArray.count)
            tableView.reloadData()
        }else if index == 1 {
            tableArray = self.InvestmentCartDataArr.filter{ ($0["TransactionType"] as! String) == "SIP" }
            print(tableArray.count)
            tableView.reloadData()
        }else if index == 2{
            tableArray = self.InvestmentCartDataArr.filter{ ($0["TransactionType"] as! String) == "Redeem" }
            print(tableArray.count)
            
            tableView.reloadData()
        }else if index == 3{
            tableArray = self.InvestmentCartDataArr.filter{ ($0["TransactionType"] as! String) == "Switch" }
            
            print(tableArray.count)
            tableView.reloadData()
        }else if index == 4{
            tableArray = self.InvestmentCartDataArr.filter{ ($0["TransactionType"] as! String) == "SWP" }
            
            print(tableArray.count)
            tableView.reloadData()
        }
        else if index == 5{
            tableArray = self.InvestmentCartDataArr.filter{ ($0["TransactionType"] as! String) == "STP" }
            
            print(tableArray.count)
            tableView.reloadData()
        }
        
        DispatchQueue.main.async {
            if self.tableArray.isEmpty{
                self.showMessage("Data not found!", type: .info)
            }
        }
    }
    func convertDateFormat(inputDate: String) -> String {
        
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let oldDate = olDateFormatter.date(from: inputDate)
        
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "yyyy-MM-dd"
        
        return convertDateFormatter.string(from: oldDate!)
    }
    @IBAction func pickerDoneAct(_ sender: Any) {
        self.pickerView.isHidden  =  true
        self.picker.isHidden  =  true
    }
    @IBAction func bankAccAct(_ sender: Any) {
        pickerFlag = false
        self.pickerView.isHidden  =  false
        self.picker.isHidden  =  false
        self.picker.reloadAllComponents()
    }
    @IBAction func investAccAct(_ sender: Any) {
        pickerFlag = true
        self.pickerView.isHidden  =  false
        self.picker.isHidden  =  false
        self.picker.reloadAllComponents()
    }
}
@available(iOS 13.0, *)
extension InvertmentCartVC : UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerFlag == true{
            return self.AccDataArr.count
        }else{
            return self.BankAccDataArr.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerFlag == true{
            return self.AccDataArr[row]["ClientName"] as? String
        }else{
            return self.BankAccDataArr[row]["BankName"] as? String
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerFlag == true{
            InvestAmtBtn.setTitle(self.AccDataArr[row]["ClientName"] as? String ?? "", for: .normal)
        }else{
            BankAccBtn.setTitle(self.BankAccDataArr[row]["BankName"] as? String ?? "", for: .normal)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  tableArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InvertmentCartCell
        cell.tag   =  indexPath.row
        
        cell.schemeNamelbl.text = tableArray[indexPath.row]["FundName"] as? String
       // cell.AmountLbl.text = "\(tableArray[indexPath.row]["TxnAmountUnit"] as? Double ?? 0.0)"
        cell.AmountLbl.text = self.formatter.string(from: NSNumber(value: tableArray[indexPath.row]["TxnAmountUnit"] as? Double ?? 0.0))
        
        if tableArray[indexPath.row]["TransactionType"] as? String == "BUY" {
            cell.subView2.isHidden = true
            cell.subview3.isHidden = true
            cell.subView2HeightCont.constant = 0
            cell.subView3HeightCont.constant = 0
            cell.lblSubView1.isHidden = false
            
        }
        else  if tableArray[indexPath.row]["TransactionType"] as? String == "SIP"{
            cell.folioLbl.text = "No of Installments: "
            cell.folioNoLbl.text = "\(tableArray[indexPath.row]["Period"] as? Int ?? 0) | "
            cell.frequencyTxtLbl.text = "\(tableArray[indexPath.row]["Frequency"] as? String ?? "0") |  "
            cell.dayNolbl.text = tableArray[indexPath.row]["SIPStartDate"] as? String
            cell.subview3.isHidden = true
            cell.subView2HeightCont.constant = 47
            cell.subView3HeightCont.constant = 0
            cell.subView2.isHidden = false
            cell.lblSubView1.isHidden = true
        }else if tableArray[indexPath.row]["TransactionType"] as? String == "Redeem"{
            cell.subView2.isHidden = true
            
            cell.subview3.isHidden = false
            cell.currentFundVauleTxtLbl.text = "\(tableArray[indexPath.row]["CurrentFundValue"] as? Int ?? 0)"
            cell.currentUnitTxtLbl.text = "\(tableArray[indexPath.row]["CurrentUnits"] as? Int ?? 0)"
            cell.withdawlAmtTxtLbl.text = tableArray[indexPath.row]["AmountOrUnit"] as? String
            cell.transferToFundTxtLbl.text = tableArray[indexPath.row]["TargetFundName"] as? String
            cell.lblSubView1.isHidden = true
        }else if tableArray[indexPath.row]["TransactionType"] as? String == "Switch"{
            cell.subView2.isHidden = false
            cell.subview3.isHidden = false
            cell.subView2HeightCont.constant = 47
            cell.subView3HeightCont.constant = 169
            cell.lblSubView1.isHidden = true
            
            cell.folioLbl.text = "Folio No :"
            cell.folioNoLbl.text = "\( tableArray[indexPath.row]["FolioNo"] as? String ?? "")|"
            cell.frequencyTxtLbl.text = "\( tableArray[indexPath.row]["Frequency"] as? String ?? "")|"
            cell.dayNolbl.text = tableArray[indexPath.row]["SIPStartDate"] as? String
            cell.currentFundVauleLbl.text = "Current Fund Vaule"
            cell.currentFundVauleTxtLbl.text = "\(tableArray[indexPath.row]["CurrentFundValue"] as? Int ?? 0)"
            cell.currentUnitLbl.text = "Current Units"
            cell.currentUnitTxtLbl.text = "\(tableArray[indexPath.row]["CurrentUnits"] as? Int ?? 0)"
            cell.withdawlAmtTxtLbl.text = tableArray[indexPath.row]["AmountOrUnit"] as? String
            cell.transferToFundTxtLbl.text = tableArray[indexPath.row]["TargetFundName"] as? String
        }else if tableArray[indexPath.row]["TransactionType"] as? String == "SWP"{
            cell.subView2.isHidden = false
            cell.subView2HeightCont.constant = 47
            cell.subView3HeightCont.constant = 169
            cell.lblSubView1.isHidden = true
            cell.subview3.isHidden = false
            cell.folioLbl.text = "Folio No :"
            cell.folioNoLbl.text = tableArray[indexPath.row]["FolioNo"] as? String
            cell.frequencyTxtLbl.text = tableArray[indexPath.row]["Frequency"] as? String
            cell.dayNolbl.text = tableArray[indexPath.row]["SIPStartDate"] as? String
            
            cell.currentFundVauleLbl.text = "Current Fund Vaule"
            cell.currentFundVauleTxtLbl.text = "\(tableArray[indexPath.row]["CurrentFundValue"] as? Int ?? 0)"
            cell.currentUnitLbl.text = "Current Units"
            cell.currentUnitTxtLbl.text = "\(tableArray[indexPath.row]["CurrentUnits"] as? Int ?? 0)"
            cell.transferTypeLbl.text = "Transfer Type"
            cell.transferTypeTxtLbl.text = tableArray[indexPath.row]["AmountOrUnit"] as? String
            cell.withdawlAmtLbl.text = "Withdraw Amount"
            cell.withdawlAmtTxtLbl.text = tableArray[indexPath.row]["AmountOrUnit"] as? String
            
            cell.transferToFundLbl.text = "Transfer To Fund"
            cell.transferToFundTxtLbl.text = tableArray[indexPath.row]["TargetFundName"] as? String
            
        }else if tableArray[indexPath.row]["TransactionType"] as? String == "STP"{
            cell.subView2.isHidden = false
            cell.subView2HeightCont.constant = 47
            cell.subView3HeightCont.constant = 169
            cell.lblSubView1.isHidden = true
            cell.subview3.isHidden = false
            cell.folioLbl.text = "Folio No :"
            cell.folioNoLbl.text = "\( tableArray[indexPath.row]["FolioNo"] as? String ?? "" )|"
            cell.frequencyTxtLbl.text = "\( tableArray[indexPath.row]["Frequency"] as? String ?? "")|"
            cell.dayNolbl.text = tableArray[indexPath.row]["SIPStartDate"] as? String
            
            cell.currentFundVauleLbl.text = "Current Fund Vaule"
            cell.currentFundVauleTxtLbl.text =  "\(tableArray[indexPath.row]["CurrentFundValue"] as? Int ?? 0)"
            cell.currentUnitLbl.text = "Current Units"
            cell.currentUnitTxtLbl.text =  "\(tableArray[indexPath.row]["CurrentUnits"] as? Int ?? 0)"
            
            cell.transferTypeLbl.text = "Transfer Type"
            cell.transferTypeTxtLbl.text = tableArray[indexPath.row]["AmountOrUnit"] as? String
            
            cell.withdawlAmtTxtLbl.text = tableArray[indexPath.row]["AmountOrUnit"] as? String
            cell.transferToFundTxtLbl.text = tableArray[indexPath.row]["TargetFundName"] as? String
        }
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(HoldingDataArr[indexPath.row])
        //           let vc = self.storyboard?.instantiateViewController(identifier: "InsuranceDetailVC") as! InsuranceDetailVC
        //           vc.index = indexPath.row
        //           self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

class InvertmentCartCell: UITableViewCell {
    //    PolicyName
    //   Amount
    //   Premiumstdate
    //   Premiumamount
    
    @IBOutlet weak var subView1: UIView!
    @IBOutlet weak var schemeNamelbl: UILabel!
    @IBOutlet weak var AmountLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var subView2: UIView!
    @IBOutlet weak var folioLbl: UILabel!
    @IBOutlet weak var folioNoLbl: UILabel!
    @IBOutlet weak var frequencyLbl: UILabel!
    @IBOutlet weak var frequencyTxtLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var subview3: UIView!
    @IBOutlet weak var dayNolbl: UILabel!
    @IBOutlet weak var currentFundVauleLbl: UILabel!
    @IBOutlet weak var currentFundVauleTxtLbl: UILabel!
    @IBOutlet weak var currentUnitLbl: UILabel!
    @IBOutlet weak var currentUnitTxtLbl: UILabel!
    @IBOutlet weak var transferTypeLbl: UILabel!
    @IBOutlet weak var transferTypeTxtLbl: UILabel!
    @IBOutlet weak var withdawlAmtLbl: UILabel!
    @IBOutlet weak var withdawlAmtTxtLbl: UILabel!
    @IBOutlet weak var transferToFundLbl: UILabel!
    @IBOutlet weak var transferToFundTxtLbl: UILabel!
    @IBOutlet weak var transactBtn: UIButton!
    @IBOutlet weak var subView2HeightCont: NSLayoutConstraint!
    @IBOutlet weak var subView3HeightCont: NSLayoutConstraint!
    @IBOutlet weak var lblSubView1 : UILabel!
    
    
    
    //    var selectTransact : ((Int) -> ())?
    override class func awakeFromNib() {
        print("Abcd")
    }
    
    
}
extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element { reduce(.zero, +) }
}
