//
//  DemandHoldingVC.swift
//  BOB
//
//  Created by Anushree on 3/11/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import Foundation
import UIKit
import CryptoSwift
@available(iOS 13.0, *)
class DemandHoldingVC: BaseClass {
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
       if #available(iOS 13.4, *) {
        picker.preferredDatePickerStyle = .wheels
       }
       self.navigationController?.setNavigationBarHidden(false, animated: true)
       self.setNavigationtitle(titleText : "Demand Holdings",view: self,rightImage : "menu")
       
        
      
       
        // Do any additional setup after loading the view.
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
extension DemandHoldingVC : UITableViewDataSource,UITableViewDelegate{
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  GlobleValue.HoldingDataArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DemandHoldingCell
        cell.tag   =  indexPath.row
        cell.ScripNameLbl.text = GlobleValue.HoldingDataArray[indexPath.row]["SchemeName"] as? String
     if let Qunt = GlobleValue.HoldingDataArray[indexPath.row]["Quantity"]  as? Double {
                   cell.QuantityLbl.text =  "\(Qunt)"
              } else {
                  cell.QuantityLbl.text = "" // Was not a string
              }
          if let Price = GlobleValue.HoldingDataArray[indexPath.row]["CurrentPrice"]  as? Double {
       
                         cell.PriceLbl.text =  "\(Price)"
                      } else {
                        cell.PriceLbl.text  = ""// Was not a string
                      }
        if let MarketValue = GlobleValue.HoldingDataArray[indexPath.row]["MarketValue"]  as? Double {
        
                          cell.MarketValueLbl.text =  "\(MarketValue)"
                       } else {
                            cell.MarketValueLbl.text = ""// Was not a string
                       }

        
        
        return cell
    }
    
    
    
    
}

class DemandHoldingCell: UITableViewCell {
    @IBOutlet weak var ScripNameLbl: UILabel!
    @IBOutlet weak var QuantityLbl: UILabel!
    @IBOutlet weak var transactBtn: UIButton!
    @IBOutlet weak var PriceLbl: UILabel!
    @IBOutlet weak var MarketValueLbl: UILabel!
    override class func awakeFromNib() {
        print("Abcd")
    }
}
