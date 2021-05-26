//
//  HoldingDetailVC.swift
//  BOB
//
//  Created by Anushree on 3/10/21.
//  Copyright © 2021 Mayank. All rights reserved.
//
import UIKit
import Foundation
@available(iOS 13.0, *)
class HoldingDetailVC: BaseClass {
//@IBOutlet weak var tableView: UITableView!
     @IBOutlet weak var name: UILabel!
     @IBOutlet weak var amountLbl: UILabel!
     @IBOutlet weak var netGainLbl: UILabel!
    @IBOutlet weak var netGainPreLbl: UILabel!
     @IBOutlet weak var xxirLbl: UILabel!
     @IBOutlet weak var costLbl: UILabel!
     @IBOutlet weak var MarketValueLbl: UILabel!
     @IBOutlet weak var FolioLbl: UILabel!
     @IBOutlet weak var unitLbl: UILabel!
        var index = Int()
    var netValue = Double()
     override func viewDidLoad() {
         super.viewDidLoad()
 
        name.text = GlobleValue.HoldingDataArray[index]["SchemeName"] as? String
         if let b = GlobleValue.HoldingDataArray[index]["MarketValue"] as? Double {
             let x = b.rounded(toPlaces: 1)
             MarketValueLbl.text =  "\(x)"
         } else {
             MarketValueLbl.text =  "" // Was not a string
         }
         if let NetGain = GlobleValue.HoldingDataArray[index]["NetGain"] as? Double {
                        print(NetGain) // Was a string
                       
             netValue = NetGain.rounded(toPlaces: 1)
             
             netGainLbl.text =  "\(netValue)"
                    } else {
                       netGainLbl.text =  "" // Was not a string
                    }
         if let xirrPer = GlobleValue.HoldingDataArray[index]["GainLossPercentage"] as? Double {
            let x = xirrPer.rounded(toPlaces: 1)
             xxirLbl.text =  "\(x)%"
         } else {
              xxirLbl.text =  "" // Was not a string
         }
        if let value = GlobleValue.HoldingDataArray[index]["ValueOfCost"] as? Double {
                     
                     
       let Cost = value.rounded(toPlaces: 1)
         netGainPreLbl.text = "\((netValue / Cost * 100).rounded(toPlaces: 1))"
         }
//        if let xirrPer = GlobleValue.HoldingDataArray[index]["GainLossPercentage"] as? Double {
//                   let x = xirrPer.rounded(toPlaces: 1)
//                     netGainPreLbl.text =  "\(x)%"
//                } else {
//                    print("Error") // Was not a string
//                }
         //netGainPreLbl.text = "\(x1)"
        FolioLbl.text = GlobleValue.HoldingDataArray[index]["Folio"] as? String
        unitLbl.text = GlobleValue.HoldingDataArray[index]["CurrentUnits"] as? String
         self.setNavigationtitle(titleText : "Holdings Detail",view: self,rightImage : "menu")
        self.navigationController?.setNavigationBarHidden(false, animated: true)
     }

     override func viewDidLayoutSubviews() {
     //    self.searchView.set_View_Border(viewName: self.searchView, borderColor: .gray, borderWidth: 1, corner: 5)
     }
 }
