//
//  HoldingsVC.swift
//  BOB
//
//  Created by mayank on 25/02/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class HoldingsVC: BaseClass {
   @IBOutlet weak var tableView: UITableView!
        @IBOutlet weak var searchField: UITextField!
        @IBOutlet weak var searchView: UIView!
           var HoldingDataArr     = [[String : Any]]()
        override func viewDidLoad() {
            super.viewDidLoad()
    
          HoldingDataArr = GlobleValue.HoldingDataArray
            self.setNavigationtitle(titleText : "Holdings",view: self,rightImage : "back")
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }

        override func viewDidLayoutSubviews() {
            //self.searchView.set_View_Border(viewName: self.searchView, borderColor: .gray, borderWidth: 1, corner: 5)
        }
    }
    @available(iOS 13.0, *)
    extension HoldingsVC : UITableViewDataSource,UITableViewDelegate{
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return  HoldingDataArr.count
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell  =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HoldingsCell
            cell.tag   =  indexPath.row
            var netgain : Double = 0.0
            var Cost : Double = 0.0
            cell.schemeNameLbl.text = HoldingDataArr[indexPath.row]["SchemeName"] as? String
            if let b = HoldingDataArr[indexPath.row]["MarketValue"] as? Double {
                let x = b.rounded(toPlaces: 1)
                cell.currentVaule.text =  "\(x)"
            } else {
                print("Error") // Was not a string
            }
            if let NetGain = HoldingDataArr[indexPath.row]["NetGain"] as? Double {
                           print(NetGain) // Was a string
                          
             netgain = NetGain.rounded(toPlaces: 2)
                
                cell.netGainLbl.text =  "\(netgain)"
                       } else {
                           print("Error") // Was not a string
                       }
            if let xirrPer = HoldingDataArr[indexPath.row]["GainLossPercentage"] as? Double {
               let x = xirrPer.rounded(toPlaces: 1)
                cell.xirrPerLbl.text =  "\(x)%"
            } else {
                print("Error") // Was not a string
            }
         
if let value = HoldingDataArr[indexPath.row]["ValueOfCost"] as? Double {
                        
                        
           Cost = value.rounded(toPlaces: 2)
            cell.NGPer.text = "\((netgain / Cost * 100).rounded(toPlaces: 1))"
            }
           
           
    //               cell.selectTransact  = {[weak self] (indexVal) in
    //                   self?.pickerView.isHidden   = false
    //                   self?.picker.reloadAllComponents()
    //               }
            return cell
        }

       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print(HoldingDataArr[indexPath.row])
        let vc = self.storyboard?.instantiateViewController(identifier: "HoldingDetailVC") as! HoldingDetailVC
        vc.index = indexPath.row
       // vc.netPer = cell.NGPer.text
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    class HoldingsCell: UITableViewCell {
        @IBOutlet weak var schemeNameLbl: UILabel!
        @IBOutlet weak var transactBtn: UIButton!
        
        @IBOutlet weak var netGainLbl: UILabel!
        @IBOutlet weak var xirrPerLbl: UILabel!
        @IBOutlet weak var currentVaule: UILabel!
        @IBOutlet weak var NGPer: UILabel!
        var selectTransact : ((Int) -> ())?
        override class func awakeFromNib() {
            print("Abcd")
        }
        
        @IBAction func transactBtnAct(_ sender: Any) {
            selectTransact?(self.tag)
        }
    }
