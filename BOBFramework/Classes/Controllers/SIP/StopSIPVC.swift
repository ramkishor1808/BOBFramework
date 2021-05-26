//
//  StopSIPVC.swift
//  BOB
//
//  Created by Anushree on 3/16/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import Foundation
import UIKit
import CryptoSwift
//import SVProgressHUD
@available(iOS 13.0, *)
class StopSIPVC: BaseClass , CustomSegmentedControlDelegate {
    @IBOutlet weak var tableView: UITableView!
   
   
     var SIPStopDataArr     = [[String : Any]]()
     var tableArray     = [[String : Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50), buttonTitle: ["SIP","SWP"])
              codeSegmented.backgroundColor = .clear
        codeSegmented.delegate = self
              view.addSubview(codeSegmented)

        //              let Url = String(f
        
        self.setNavigationtitle(titleText : "Stop Systematic Transaction",view: self,rightImage : "menu")
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        APICalling()
       
        // Do any additional setup after loading the view.
    }
    func APICalling() {
          self.start_Loader()
                let identifier = UUID()
                let testString = "\(identifier)|BOBWealth"
                let json = ["RequestBody":[
                  "FamCode": 0,
                  "HeadCode": 32,
                  "ClientCode": 0,
                  "FromDate": "2021-03-15T10:54:33.0991458+05:30",
                  "ToDate": "2021-03-15T10:54:33.0991458+05:30",
                  "ClientType": "H",
                  "usr_id": "admin",
                  "Report_Type": "Summary"
],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
                                     let jsonString1 = json.jsonDic
                         
                                   
                             let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
                           let encToken = try! testString.aesEncrypt()
                             let enc = try! str.aesEncrypt()
       
                 APIManager.shareInstance.AuthenticationRequest(method: "Client/SIPDueReport", TPA: encToken, parameter: enc){
                            (netResponse) -> (Void) in
                            if(netResponse.statusCode == 200){
                                   self.stop_Loader()
                                print(netResponse.responseDict as Any)
                             self.SIPStopDataArr = netResponse.responseDict as? [[String : Any]] ?? [[:]]
                                self.tableArray =  self.SIPStopDataArr
                               DispatchQueue.main.async {
                                if  self.SIPStopDataArr.isEmpty{
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
        if index == 0 {
           tableArray = self.SIPStopDataArr.filter{ ($0["Type"] as! String) == "SIP" }
                       
                       print(tableArray.count)
                       tableView.reloadData()
        }else if index == 1{
           tableArray = self.SIPStopDataArr.filter{ ($0["Type"] as! String) == "SWP" }
            
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
    
}
@available(iOS 13.0, *)
extension StopSIPVC : UITableViewDataSource,UITableViewDelegate{
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  tableArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StopSIPCell
        cell.tag   =  indexPath.row
     
    cell.NameLbl.text = tableArray[indexPath.row]["Fund_Name"] as? String
                if let Amount = tableArray[indexPath.row]["Amount"] {
                     cell.AmountLbl.text =  "\(Amount)"
                } else {
                    cell.AmountLbl.text = "" // Was not a string
                }
        cell.FolioNo.text = "\(tableArray[indexPath.row]["FolioNo"] as? String ?? "") |"
        if tableArray[indexPath.row]["Type"] as? String == "SIP" {
             cell.FerquencyLbl.text = "Frequency:"
        }
        if tableArray[indexPath.row]["Type"] as? String == "SWP" {
             cell.FerquencyLbl.text = "SWP:"
        }
       
        cell.FerquencyTxtLbl.text = "\( tableArray[indexPath.row]["Frequency"] as? String ?? "") |"
        
        if tableArray[indexPath.row]["Type"] as? String == "SIP" {
             cell.EndDteLbl.text = "SIPEndDate:"
        }
        if tableArray[indexPath.row]["Type"] as? String == "SWP" {
             cell.EndDteLbl.text = "SWPEndDate"
        }
        
        let dateStr = SIPStopDataArr[indexPath.row]["EndDate"] as? String ?? "0"

     let result = convertDateFormat(inputDate: dateStr)
           cell.EndDteTxtLbl.text = result

        //cell.PremiumdateLbl.text = "\(result.description)"
//        if let preAmount = SIPStopDataArr[indexPath.row]["Premiumamount"] as? Double
//        {
//            let x = preAmount.rounded(toPlaces: 1)
//            cell.PremiumamountLbl.text = "\(x)"
//        }else{
//             cell.PremiumamountLbl.text = ""
//        }
               // cell.PremiumamountLbl.text = (InsuranceDataArr[indexPath.row]["Premiumamount"] as? Double ?? "0")
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              // print(HoldingDataArr[indexPath.row])
           
    
}
}

class StopSIPCell: UITableViewCell {
    //    PolicyName
    //   Amount
    //   Premiumstdate
    //   Premiumamount
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var AmountLbl: UILabel!
    @IBOutlet weak var FolioNo: UILabel!
    @IBOutlet weak var FerquencyLbl: UILabel!
    @IBOutlet weak var FerquencyTxtLbl: UILabel!
    @IBOutlet weak var EndDteLbl: UILabel!
    @IBOutlet weak var EndDteTxtLbl: UILabel!
   
//    var selectTransact : ((Int) -> ())?
    override class func awakeFromNib() {
        print("Abcd")
    }
    
    
}
