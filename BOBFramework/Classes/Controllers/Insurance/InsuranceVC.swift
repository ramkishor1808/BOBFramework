//
//  InsuranceVC.swift
//  BOB
//
//  Created by Anushree on 3/11/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import Foundation
import UIKit
import CryptoSwift
///???/  b?. import SVProgressHUD
@available(iOS 13.0, *)
class InsuranceVC: BaseClass , CustomSegmentedControlDelegate {
    @IBOutlet weak var tableView: UITableView!
   
   
     var InsuranceDataArr     = [[String : Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50), buttonTitle: ["Life Insurance","General Insurance"])
              codeSegmented.backgroundColor = .clear
        codeSegmented.delegate = self
              view.addSubview(codeSegmented)

        //              let Url = String(f
        
        self.setNavigationtitle(titleText : "Insurance",view: self,rightImage : "menu")
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        APICalling()
       
        // Do any additional setup after loading the view.
    }
    func APICalling() {
          self.start_Loader()
                let identifier = UUID()
                let testString = "\(identifier)|BOBWealth"
                let json = ["RequestBody":["clientcode":0,"HeadclientCode":"32","famcode":0,"clienttype":"H"],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
                                     let jsonString1 = json.jsonDic
                         
                                   
                             let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
                           let encToken = try! testString.aesEncrypt()
                             let enc = try! str.aesEncrypt()
       
                 APIManager.shareInstance.AuthenticationRequest(method: "Client/LifeInsurance", TPA: encToken, parameter: enc){
                            (netResponse) -> (Void) in
                            if(netResponse.statusCode == 200){
                                   self.stop_Loader()
                                print(netResponse.responseDict as Any)
                              GlobleValue.InsuranceDataArray = netResponse.responseDict as? [[String : Any]] ?? [[:]]
        //                        print(GlobleValue.InsuranceDataArray)
                               self.InsuranceDataArr = GlobleValue.InsuranceDataArray
                               DispatchQueue.main.async {
                                if self.InsuranceDataArr.isEmpty{
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
    func GenralAPICalling() {
         
                 let identifier = UUID()
                 let testString = "\(identifier)|BOBWealth"
                 let json = ["RequestBody":["rmcode": 0,
                 "client_code": 32,
                 "categoryid": 0,
                 "product": 0,
                 "insurancecompid": 5,
                 "fromdate": "2021-03-15T10:58:41.5659054+05:30",
                 "todate": "2021-03-15T10:58:41.5659054+05:30",
                 "status": "1",
                 "type": "A",
                 "musrid": "admin",
                 "clientType": "H"],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
                                      let jsonString1 = json.jsonDic
                          
                                    
                              let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
                            let encToken = try! testString.aesEncrypt()
                              let enc = try! str.aesEncrypt()
          self.start_Loader()
                  APIManager.shareInstance.AuthenticationRequest(method: "Client/GeneralInsurance", TPA: encToken, parameter: enc){
                             (netResponse) -> (Void) in
                             if(netResponse.statusCode == 200){
                                   self.stop_Loader()
                                 print(netResponse.responseDict as Any)
                               GlobleValue.InsuranceDataArray = netResponse.responseDict as? [[String : Any]] ?? [[:]]
         //                        print(GlobleValue.InsuranceDataArray)
                                self.InsuranceDataArr = GlobleValue.InsuranceDataArray
                                DispatchQueue.main.async {
                                    if self.InsuranceDataArr.isEmpty{
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
    override func viewDidLayoutSubviews() {
       
    }
    func change(to index:Int) {
        print("segmentedControl index changed to \(index)")
        if index == 0{
            APICalling()
        }else{
            GenralAPICalling()
           
            

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
    
}
@available(iOS 13.0, *)
extension InsuranceVC : UITableViewDataSource,UITableViewDelegate{
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  InsuranceDataArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InsuranceCell
        cell.tag   =  indexPath.row
     //    PolicyName
     //
     //   Premiumstdate
     //   Premiumamount
       cell.PolicyNameLbl.text = InsuranceDataArr[indexPath.row]["PolicyName"] as? String
                if let Amount = InsuranceDataArr[indexPath.row]["Amount"] {
                     cell.AmountLbl.text =  "\(Amount)"
                } else {
                    cell.AmountLbl.text = "" // Was not a string
                }
        let dateStr = InsuranceDataArr[indexPath.row]["policymaturitydate"] as? String ?? "0"
        
     let result = convertDateFormat(inputDate: dateStr)
           cell.PremiumdateLbl.text = result
        
        //cell.PremiumdateLbl.text = "\(result.description)"
        if let preAmount = InsuranceDataArr[indexPath.row]["Premiumamount"] as? Double
        {
            let x = preAmount.rounded(toPlaces: 1)
            cell.PremiumamountLbl.text = "\(x)"
        }else{
             cell.PremiumamountLbl.text = ""
        }
               // cell.PremiumamountLbl.text = (InsuranceDataArr[indexPath.row]["Premiumamount"] as? Double ?? "0")
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              // print(HoldingDataArr[indexPath.row])
           let vc = self.storyboard?.instantiateViewController(identifier: "InsuranceDetailVC") as! InsuranceDetailVC
           vc.index = indexPath.row
           self.navigationController?.pushViewController(vc, animated: true)
           }
    
}

class InsuranceCell: UITableViewCell {
    //    PolicyName
    //   Amount
    //   Premiumstdate
    //   Premiumamount
    @IBOutlet weak var PolicyNameLbl: UILabel!
    @IBOutlet weak var AmountLbl: UILabel!
    @IBOutlet weak var transactBtn: UIButton!
    @IBOutlet weak var PremiumdateLbl: UILabel!
    @IBOutlet weak var PremiumamountLbl: UILabel!
   
//    var selectTransact : ((Int) -> ())?
    override class func awakeFromNib() {
        print("Abcd")
    }
    
    
}
