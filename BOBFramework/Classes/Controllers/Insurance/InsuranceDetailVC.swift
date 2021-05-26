//
//  InsuranceDetailVC.swift
//  BOB
//
//  Created by Anushree on 3/11/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import UIKit
import Foundation
@available(iOS 13.0, *)
class InsuranceDetailVC: BaseClass {
//@IBOutlet weak var tableView: UITableView!
     @IBOutlet weak var name: UILabel!
     @IBOutlet weak var amountLbl: UILabel!
     @IBOutlet weak var InsCompanyLbl: UILabel!
     @IBOutlet weak var policyLbl: UILabel!
     @IBOutlet weak var policyNoLbl: UILabel!
     @IBOutlet weak var policyTypeLbl: UILabel!
     @IBOutlet weak var fundValueLbl: UILabel!
     @IBOutlet weak var sumAssLbl: UILabel!
     @IBOutlet weak var PolicyDateLbl: UILabel!
     @IBOutlet weak var MaturityDateLbl: UILabel!
     @IBOutlet weak var preAmountLbl: UILabel!
     @IBOutlet weak var frequencyLbl: UILabel!
     @IBOutlet weak var annualPreLbl: UILabel!
     @IBOutlet weak var nextDueDateLbl: UILabel!
    
    
        var index = Int()
     override func viewDidLoad() {
         super.viewDidLoad()
  let str = GlobleValue.InsuranceDataArray[index]["ClientName"] as? String ?? ""
        let array : [String] = str.components(separatedBy: "-")

        name.text = array[0]
        if let Amount = GlobleValue.InsuranceDataArray[index]["Amount"] {
                           amountLbl.text =  "\(Amount)"
                      } else {
                          amountLbl.text = "0" // Was not a string
                      }
         InsCompanyLbl.text = GlobleValue.InsuranceDataArray[index]["InsuranceCompany"] as? String
        policyLbl.text = GlobleValue.InsuranceDataArray[index]["PolicyName"] as? String
        policyNoLbl.text = GlobleValue.InsuranceDataArray[index]["policyno"] as? String
         policyTypeLbl.text = GlobleValue.InsuranceDataArray[index]["PolicyType"] as? String
        fundValueLbl.text = "\(GlobleValue.InsuranceDataArray[index]["FundValue"] as? Int ?? 0)"
         sumAssLbl.text = GlobleValue.InsuranceDataArray[index]["PolicyType"] as? String
         let dateStr1 = GlobleValue.InsuranceDataArray[index]["Startdate"] as? String ?? "0"
            
         let result = convertDateFormat(inputDate: dateStr1)
               PolicyDateLbl.text = result
        
    let dateStr = GlobleValue.InsuranceDataArray[index]["policymaturitydate"] as? String ?? "0"
              
           let result2 = convertDateFormat(inputDate: dateStr)
                 MaturityDateLbl.text = result2
              
              //cell.PremiumdateLbl.text = "\(result.description)"
              if let preAmount = GlobleValue.InsuranceDataArray[index]["Premiumamount"] as? Double
              {
                  let x = preAmount.rounded(toPlaces: 1)
                  preAmountLbl.text = "\(x)"
              }else{
                   preAmountLbl.text = "0"
              }
        frequencyLbl.text = GlobleValue.InsuranceDataArray[index]["Frequency"] as? String
        annualPreLbl.text = "\(GlobleValue.InsuranceDataArray[index]["AnnualPremium"] as? Int ?? 0)"
        let dateStr2 = GlobleValue.InsuranceDataArray[index]["duedate"] as? String ?? "0"
           
        let result1 = convertDateFormat(inputDate: dateStr2)
        nextDueDateLbl.text = result1
        
         self.setNavigationtitle(titleText : "Holdings",view: self,rightImage : "menu")
         self.navigationController?.setNavigationBarHidden(false, animated: true)
     }
    func convertDateFormat(inputDate: String) -> String {

           let olDateFormatter = DateFormatter()
           olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

           let oldDate = olDateFormatter.date(from: inputDate)

           let convertDateFormatter = DateFormatter()
           convertDateFormatter.dateFormat = "yyyy-MM-dd"

           return convertDateFormatter.string(from: oldDate!)
      }
     override func viewDidLayoutSubviews() {
     //    self.searchView.set_View_Border(viewName: self.searchView, borderColor: .gray, borderWidth: 1, corner: 5)
     }
 }
