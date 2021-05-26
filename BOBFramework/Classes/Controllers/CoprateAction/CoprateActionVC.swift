//
//  CoprateActionVC.swift
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
class CoprateActionVC: BaseClass {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var pickerView: UIView!
   
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var goBtn: UIButton!
    var tranactArr   =  ["Buy","SIP","Redeem","Switch","SWP","STP"]
     var CoprateDataArr     = [[String : Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
       self.pickerView.isHidden  =  true

        //              let Url = String(f
        
        self.setNavigationtitle(titleText : "CoprateAction",view: self,rightImage : "")
        self.navigationController?.setNavigationBarHidden(false, animated: true)
         self.tableView.isHidden = false
        APICalling()
        // Do any additional setup after loading the view.
    }
    func APICalling() {
       
         let identifier = UUID()
         let testString = "\(identifier)|BOBWealth"
        let json = ["RequestBody":["ClientType":"H","IsFundware":"false","AccountLevel":"0","AmountDenomination":"0","CurrencyCode":"1","DateFrom":"2021-03-02T19:47:38","DateTo":"2021-03-09T19:47:38","OnlineAccountCode":"32","OrderType":"1","PageIndex":"0","PageSize":"0","SchemeCode":"0","UserId":"069409856"],"Source":"BOBWealth","UniqueIdentifier":"\( identifier)"] as [String : Any]
                              let jsonString1 = json.jsonDic
                  
                            let str1 = jsonString1.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
                                 let str2 = str1.replacingOccurrences(of: "//", with: "/", options: NSString.CompareOptions.literal, range: nil)

                                    print(str2)
                      let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
                       let encToken = try! testString.aesEncrypt()
                      let enc = try! str2.aesEncrypt()
      self.start_Loader()
          APIManager.shareInstance.AuthenticationRequest(method: "Client/Transactions", TPA: encToken, parameter: enc){
                     (netResponse) -> (Void) in
                     if(netResponse.statusCode == 200){
                          self.stop_Loader()
                         print(netResponse.responseDict as Any)
                         GlobleValue.CoprateActionDataArray = netResponse.responseDict as? [[String : Any]] ?? [[:]]
                         print(GlobleValue.CoprateActionDataArray)
                         self.CoprateDataArr = GlobleValue.CoprateActionDataArray
                         DispatchQueue.main.async {
                                                            if self.CoprateDataArr.isEmpty{
                                                                self.tableView.isHidden = true;          self.showMessage("Data not found", type: .info)
                                                            }else{
                                                                self.tableView.isHidden = false;  self.tableView.reloadData()
                            }
                                                          }
                     }else{
                        self.stop_Loader()
            }
                     }
    }
    override func viewDidLayoutSubviews() {
        self.searchView.set_View_Border(viewName: self.searchView, borderColor: .gray, borderWidth: 1, corner: 5)
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
extension CoprateActionVC : UITableViewDataSource,UITableViewDelegate{
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 //self.CoprateDataArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CoprateActionCell
        cell.tag   =  indexPath.row
       // cell.schemeNameLbl.text = CoprateDataArr[indexPath.row]["Security"] as? String
//            let xirrPer = tranactDataArr[indexPath.row]["FolioNumber"]  as? Double {
//                 let x = xirrPer.rounded(toPlaces: 1)
//                  cell.foliocNoLbl.text =  "\(x)%"
//              } else {
//                  print("Error") // Was not a string
//              }
//               cell.foliocNoLbl.text = tranactDataArr[indexPath.row]["FolioNumber"] as? String
              
        //       cell.unitNoLbl.text = CoprateDataArr[indexPath.row]["Quantity"] as? String
              // cell.xirrPerLbl.text = tranactDataArr[indexPath.row]["GainLossPercentage"] as? String
        
        
        return cell
    }
    
    
    
    
}

class CoprateActionCell: UITableViewCell {
    @IBOutlet weak var schemeNameLbl: UILabel!
    @IBOutlet weak var foliocNoLbl: UILabel!
    @IBOutlet weak var transactBtn: UIButton!
    @IBOutlet weak var unitNoLbl: UILabel!
    @IBOutlet weak var netGainNoLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    var selectTransact : ((Int) -> ())?
    override class func awakeFromNib() {
        print("Abcd")
    }
    
    
}
