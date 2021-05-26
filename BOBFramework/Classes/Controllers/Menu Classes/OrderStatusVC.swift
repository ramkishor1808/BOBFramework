//
//  OrderStatusVC.swift
//  BOB
//
//  Created by mayank on 22/02/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import Foundation
import UIKit
import CryptoSwift
//import SVProgressHUD
@available(iOS 13.0, *)
class OrderStatusVC: BaseClass , CustomSegmentedControlDelegate {
    @IBOutlet weak var tableView: UITableView!
   
   
     var orderDataArr     = [[String : Any]]()
    var tableArray = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50), buttonTitle: ["Buy","SIP","Switch"])
              codeSegmented.backgroundColor = .clear
       codeSegmented.delegate = self
              view.addSubview(codeSegmented)

        //              let Url = String(f
        
        self.setNavigationtitle(titleText : "Order Status",view: self,rightImage : "menu")
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        APICalling()
       
        // Do any additional setup after loading the view.
    }
    func APICalling() {
        //{"FamCode":0,"HeadCode":34,"ClientCode":0,"FromDate":"2018-07-23T00:00:00","ToDate":"2018-09-21T00:00:00","ClientType":"H"}
                let identifier = UUID()
                let testString = "\(identifier)|BOBWealth"
                let json = ["RequestBody":["ClientCode":0,"ClientType":"H","FamCode":0,"FromDate":"2020-01-07T00:00:00","HeadCode":32,"ToDate":"2021-02-04T00:00:00"],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
                                     let jsonString1 = json.jsonDic
                         
                                   
                             let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
                           let encToken = try! testString.aesEncrypt()
                             let enc = try! str.aesEncrypt()
         self.start_Loader()
                 APIManager.shareInstance.AuthenticationRequest(method: "Client/OrderStatusReport", TPA: encToken, parameter: enc){
                            (netResponse) -> (Void) in
                            if(netResponse.statusCode == 200){
                                  self.stop_Loader()
                                print(netResponse.responseDict as Any)
                              self.orderDataArr = netResponse.responseDict as? [[String : Any]] ?? [[:]]
        
                          self.tableArray =  self.orderDataArr
                                
 // self.tableArray = self.orderDataArr.filter{ ($0["Order_Type"] as! String) == "Purchase"
                               DispatchQueue.main.async {
                                if self.orderDataArr.isEmpty{
                                   self.showMessage("Data not found", type: .info)
                                }
                        self.tableView.reloadData()
                                 }
                               }
                                else  {
                                 self.stop_Loader()
                    }
                            }
    }
       
    func change(to index:Int) {
        print("segmentedControl index changed to \(index)")
        if index == 0 {
           tableArray = self.orderDataArr.filter{ ($0["Order_Type"] as! String) == "Purchase" }
             print(tableArray.count)
            tableView.reloadData()
        }else if index == 1 {
            tableArray = self.orderDataArr.filter{ ($0["Order_Type"] as! String) == "SIP" }
                       
                       print(tableArray.count)
                       tableView.reloadData()
        }else if index == 2{
           tableArray = self.orderDataArr.filter{ ($0["Order_Type"] as! String) == "SWP" }
            
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
extension OrderStatusVC : UITableViewDataSource,UITableViewDelegate{
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  tableArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! orderCell
        cell.tag   =  indexPath.row
     
         cell.schemeLbl.text = tableArray[indexPath.row]["Fund_Name"] as? String
        let str1 = tableArray[indexPath.row]["ClientName"] as? String ?? ""
        let array : [String] = str1.components(separatedBy: "-")

        cell.nameLbl.text = array[0]
         //cell.nameLbl.text = orderDataArr[indexPath.row]["Client_Name"] as? String
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: tableArray[indexPath.row]["Value_Date"] as? String ?? "")
        print("date: \(String(describing: date))")
        
        if  let fulldate    = tableArray[indexPath.row]["Value_Date"] as? String{
        let dateArr = fulldate.components(separatedBy: "T")
        let datevalue    = dateArr[0]
        cell.dateLbl.text = datevalue
        }else{
            cell.dateLbl.text = ""
        }
         //cell.amountLbl.text = tableArray[indexPath.row]["Order_Amount"] as? Int
        
                if let amount = tableArray[indexPath.row]["Order_Amount"] as? Int{
                    cell.amountLbl.text  = "\(amount)"
                } else {
                    cell.amountLbl.text  = "\(tableArray[indexPath.row]["Order_Amount"] as? Double ?? 0.0)"
                }
        
        
        
        
        let str = tableArray[indexPath.row]["Order_Status"] as? String ?? ""
        cell.statusBtn.setTitle(str, for: .normal)
//        if let b = GlobleValue.HoldingDataArray[index]["MarketValue"] as? Double {
//            let x = b.rounded(toPlaces: 1)
//            MarketValueLbl.text =  "\(x)"
//        } else {
//            print("Error") // Was not a string
//        }
//        if let NetGain = GlobleValue.HoldingDataArray[index]["NetGain"] as? Double {
//                       print(NetGain) // Was a string
//
//            let x = NetGain.rounded(toPlaces: 2)
//
//            netGainLbl.text =  "\(x)"
//                   } else {
//                       print("Error") // Was not a string
//                   }
//        if let xirrPer = GlobleValue.HoldingDataArray[index]["GainLossPercentage"] as? Double {
//           let x = xirrPer.rounded(toPlaces: 1)
//            xxirLbl.text =  "\(x)%"
//        } else {
//            print("Error") // Was not a string
//        }
//
//
//        netGainPreLbl.text = GlobleValue.HoldingDataArray[index]["GainLossPercentage"] as? String
//       FolioLbl.text = GlobleValue.HoldingDataArray[index]["Folio"] as? String
//       unitLbl.text = GlobleValue.HoldingDataArray[index]["CurrentUnits"] as? String
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              // print(HoldingDataArr[indexPath.row])
//           let vc = self.storyboard?.instantiateViewController(identifier: "InsuranceDetailVC") as! InsuranceDetailVC
//           vc.index = indexPath.row
//           self.navigationController?.pushViewController(vc, animated: true)
           }
    
}

class orderCell: UITableViewCell {
    //    PolicyName
    //   Amount
    //   Premiumstdate
    //   Premiumamount
    @IBOutlet weak var schemeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var statusBtn: UIButton!
//    @IBOutlet weak var PremiumdateLbl: UILabel!
//    @IBOutlet weak var PremiumamountLbl: UILabel!
   
    var selectTransact : ((Int) -> ())?
    override class func awakeFromNib() {
        print("Abcd")
    }
    
    
}
