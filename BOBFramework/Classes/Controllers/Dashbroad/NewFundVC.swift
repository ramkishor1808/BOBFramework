//
//  NewFundVC.swift
//  BOB
//
//  Created by Anushree on 3/14/21.
//  Copyright © 2021 Mayank. All rights reserved.
//
import Foundation
import UIKit
import CryptoSwift
  //import SVProgressHUD
@available(iOS 13.0, *)
class NewFundVC: BaseClass , CustomSegmentedControlDelegate, UITextFieldDelegate{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextflied: UITextField!
   
   
    var NewFundDataArr     = [[String : Any]]()
    var DebitArray = [[String : Any]]()
    var CashArray = [[String : Any]]()
    var EquityArray = [[String : Any]]()
    var SearchArray = [[String : Any]]()
     
    var tableArray     = [[String : Any]]()
    var selectedIndext = 0
   
    var SearchString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: 50), buttonTitle: ["Debt","Equity", "Cash"])
        codeSegmented.backgroundColor = .clear
        codeSegmented.delegate = self
        view.addSubview(codeSegmented)

        //              let Url = String(f
        
        self.setNavigationtitle(titleText : "NewFund",view: self,rightImage : "back")
       // self.navigationController?.setNavigationBarHidden(false, animated: true)
    //  APICalling()
       
        // Do any additional setup after loading the view.
        GetRecommandationsCalling()
    }

    func GetRecommandationsCalling(){
        
        start_Loader()
                let identifier = UUID()
                let testString = "\(identifier)|BOBWealth"
                let json = ["RequestBody":["clientcode":32],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
                                     let jsonString1 = json.jsonDic
    
                             let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
                           let encToken = try! testString.aesEncrypt()
                             let enc = try! str.aesEncrypt()
   
                 APIManager.shareInstance.AuthenticationRequest(method: "Client/GetRecommandations", TPA: encToken, parameter: enc){
                            (netResponse) -> (Void) in
                            if(netResponse.statusCode == 200){
                                self.stop_Loader()
                                
                                print(netResponse.responseDict as Any)
                              
                                let DictAllData = netResponse.responseDict as? [String:Any]
                                
                                self.DebitArray = DictAllData?["lstRecommandationDebt"] as? [[String:Any]] ?? [[:]]
                               print("Debit",self.DebitArray )
                                
                                self.EquityArray = DictAllData?["lstRecommandationEquity"] as? [[String:Any]] ?? [[:]]
                               print("Debit",self.EquityArray)
                                
                                self.CashArray = DictAllData?["lstRecommandationCash"] as? [[String:Any]] ?? [[:]]
                               print("Debit",self.CashArray )
                                
                                self.tableArray = self.DebitArray
                                self.SearchArray = self.tableArray
                                DispatchQueue.main.async {
                                if self.DebitArray.isEmpty{
                                   self.showMessage("Data not found", type: .info)
                                }

                                                 
                        self.tableView.reloadData()
                                 }
                               }
                            else{
                                  self.stop_Loader()
                    }
                            }
    }
    
    
    func APICalling() {
     
        start_Loader()
                let identifier = UUID()
                let testString = "\(identifier)|BOBWealth"
                let json = ["RequestBody":["MWIClientCode":257856,"SchemeCode":2113],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
                                     let jsonString1 = json.jsonDic
                         
                                   
                             let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
                           let encToken = try! testString.aesEncrypt()
                             let enc = try! str.aesEncrypt()
    //    SVProgressHUD.show()
                 APIManager.shareInstance.AuthenticationRequest(method: "FundDetails/FundDetails", TPA: encToken, parameter: enc){
                            (netResponse) -> (Void) in
                            if(netResponse.statusCode == 200){
                                self.stop_Loader()
                                
                                print(netResponse.responseDict as Any)
//                               self.NewFundDataArr = netResponse.responseDict as? [[String : Any]] ?? [[:]]
//                            print("NewFundArray",self.NewFundDataArr )
                                self.tableArray = self.NewFundDataArr
                               DispatchQueue.main.async {
                                if self.NewFundDataArr.isEmpty{
                                   self.showMessage("Data not found", type: .info)
                                }
//                                self.tableArray = self.NewFundDataArr.filter{ ($0["ProductTpe"] as! String) == "Debt" }
//                                print(self.tableArray.count)
                                                 
                        self.tableView.reloadData()
                                 }
                               }
                            else{
                                  self.stop_Loader()
                    }
                            }
    }
    override func viewDidLayoutSubviews() {
       
    }
    
    func searchWithName(searchkey:String) {
        self.tableArray.removeAll()
        let foundItems = SearchArray.filter { ($0["FundName"] as! String).contains(self.SearchString.lowercased())  || ($0["FundName"] as! String).contains(self.SearchString.uppercased()) }
        print(foundItems)
        self.tableArray = foundItems
        tableView.reloadData()
    }
    
    func change(to index:Int) {
       // "Debt","Equity", "Cash"]
        print("segmentedControl index changed to \(index)")
        selectedIndext = index
        if index == 0 {
            
                 tableArray.removeAll()
                 SearchArray.removeAll()
                 tableArray = self.DebitArray
                 SearchArray = tableArray
                print(tableArray.count)
                tableView.reloadData()
               }else if index == 1 {
                tableArray.removeAll()
                SearchArray.removeAll()
                tableArray = self.EquityArray
                SearchArray = tableArray
                 print(tableArray.count)
                tableView.reloadData()
               }else if index == 2{
                tableArray.removeAll()
                SearchArray.removeAll()
                
                tableArray = self.CashArray
                SearchArray = tableArray
                print(tableArray.count)
                tableView.reloadData()
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
                    self.change(to: selectedIndext)
                    
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
@available(iOS 13.0, *)
extension NewFundVC : UITableViewDataSource,UITableViewDelegate{
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewFundCell
        cell.tag   =  indexPath.row
     
         cell.NameLbl.text = tableArray[indexPath.row]["FundName"] as? String
      
         cell.month1Lbl.text = "\(tableArray[indexPath.row]["ReturnIn6Month"] as? Double ?? 0.0)"
         cell.month3Lbl.text = "\(tableArray[indexPath.row]["ReturnIn3Month"] as? Double ?? 0.0)"
         cell.year1Lbl.text = "\(tableArray[indexPath.row]["ReturnIn1Year"] as? Double ?? 0.0)"

        return cell
    }
    
    

}

class NewFundCell: UITableViewCell {
   
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var SubNameLbl: UILabel!
    @IBOutlet weak var ProductTpe: UILabel!
    @IBOutlet weak var sipBtn: UIButton!
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var facesheetBtn: UIButton!
    @IBOutlet weak var month1Lbl: UILabel!
    @IBOutlet weak var month3Lbl: UILabel!
    @IBOutlet weak var year1Lbl: UILabel!
   
//    var selectTransact : ((Int) -> ())?
    override class func awakeFromNib() {
        print("Abcd")
    }
    
    
}
