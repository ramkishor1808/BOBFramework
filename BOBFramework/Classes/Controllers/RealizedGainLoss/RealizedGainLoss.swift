//
//  RealizedGainLoss.swift
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
class RealizedGainLoss: BaseClass {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var pickerView: UIView!
   
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var goBtn: UIButton!
    var tranactArr   =  ["Buy","SIP","Redeem","Switch","SWP","STP"]
     var RealizedGainLossDataArr     = [[String : Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.isHidden  =  true

        //              let Url = String(f
        
        self.setNavigationtitle(titleText : "RealizedGainLoss",view: self,rightImage : "menu")
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.pickerView.isHidden  =  true
        APICalling()
        // Do any additional setup after loading the view.
    }
    func APICalling(){
        //SVProgressHUD.show()
                let identifier = UUID()
                let testString = "\(identifier)|BOBWealth"
         start_Loader()
                let json = ["RequestBody":["FamClient":"H","BOCode":"32","ScripCode":0,"FromDate":"2016/01/01","ToDate":"2020/06/14","UserId":"admin","SchemeCode":0,"FamCode":0,"InvestType":"A","CurrencyCode":1,"AmountIn":"0","IsFundware":"false"],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
                                     let jsonString1 = json.jsonDic
               
           
                let str1 = jsonString1.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
              let str2 = str1.replacingOccurrences(of: "//", with: "/", options: NSString.CompareOptions.literal, range: nil)

                
                              let encToken = try! testString.aesEncrypt()
                             let enc = try! str2.aesEncrypt()
              
                 APIManager.shareInstance.AuthenticationRequest(method: "Client/RealisedGainLoss", TPA: encToken, parameter: enc){
                            (netResponse) -> (Void) in
                            if(netResponse.statusCode == 200){
                                //SVProgressHUD.dismiss()
                                print(netResponse.responseDict as Any)
                                self.RealizedGainLossDataArr = netResponse.responseDict as? [[String : Any]] ?? [[:]]
                                //print(GlobleValue.RealizedGainLossDataArray)
                              //  self.RealizedGainLossDataArr = GlobleValue.RealizedGainLossDataArray
                                DispatchQueue.main.async {
                                    if self.RealizedGainLossDataArr.isEmpty{
                                       self.showMessage("Data not found", type: .info)
                                    }
                                    self.stop_Loader()
                                    self.tableView.reloadData()
                                }
                            }else{
                                 self.stop_Loader()
                    }
                            }
    }
    override func viewDidLayoutSubviews() {
       // self.searchView.set_View_Border(viewName: self.searchView, borderColor: .gray, borderWidth: 1, corner: 5)
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
    func convertDateFormat(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "yyyy-MM-dd"

         return convertDateFormatter.string(from: oldDate!)
    }
    // MARK: - Delegate Methods
    
    
    func setDateVal(date: String) {
       // self.dateField.text   =   date
    }
}
@available(iOS 13.0, *)
extension RealizedGainLoss : UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.RealizedGainLossDataArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RealizedGainLossCell
        cell.tag   =  indexPath.row
      cell.schemeNameLbl.text = RealizedGainLossDataArr[indexPath.row]["ShortName"] as? String
        if let folio = RealizedGainLossDataArr[indexPath.row]["AccountNumber"] {
             cell.foliocNoLbl.text =  "\(folio)"
        } else {
            cell.foliocNoLbl.text = "" // Was not a string
        }
        cell.DateofPuracheLbl.text = convertDateFormat(inputDate:RealizedGainLossDataArr[indexPath.row]["OpenDate"] as? String ?? "")
        cell.DateofSaleLbl.text = convertDateFormat(inputDate: RealizedGainLossDataArr[indexPath.row]["CloseDate"] as? String ?? "")
if let Qunt = RealizedGainLossDataArr[indexPath.row]["Quantity"]  as? Double {
     let x = Qunt.rounded(toPlaces: 2)
    cell.quantityLbl.text =  "\(x)"
       } else {
           cell.quantityLbl.text = "" // Was not a string
       }
   if let PurRate = RealizedGainLossDataArr[indexPath.row]["PurchasePrice"]  as? String {
   // let x = PurRate.rounded(toPlaces: 2)
    cell.purchaseRate.text =  PurRate
               } else {
                 cell.purchaseRate.text  = "0"// Was not a string
               }
 if let sellRate = RealizedGainLossDataArr[indexPath.row]["SalePrice"]  as? String {
// let x = sellRate.rounded(toPlaces: 2)
    cell.sellRateLbl.text = "\(Double(sellRate)!.rounded(toPlaces: 1))"
                } else {
                     cell.sellRateLbl.text = "0"// Was not a string
                }
        if let acu = RealizedGainLossDataArr[indexPath.row]["CostBasis"]  as? String {
            print(acu)
           // let x = Double(acu)!.rounded(toPlaces: 1)
         cell.AcqAmountLbl.text = "\(Double(acu)!.rounded(toPlaces: 1))"
                       } else {
                            cell.AcqAmountLbl.text = "0"// Was not a string
                       }

        if let shortTerm = RealizedGainLossDataArr[indexPath.row]["ShortTerm"]  as? String {
              // let x = shortTerm.rounded(toPlaces: 2)
            cell.shortTremLbl.text =  "\(Double(shortTerm)!.rounded(toPlaces: 1))"
                              } else {
                                   cell.shortTremLbl.text = "0"// Was not a string
                              }
        if let longTrem = RealizedGainLossDataArr[indexPath.row]["LongTerm"] as? String  {
               // let x = longTrem.rounded(toPlaces: 2)
            cell.longTremLbl.text =  "\(Double(longTrem)!.rounded(toPlaces: 1))"
                              } else {
                                   cell.longTremLbl.text = "0"// Was not a string
                              }
        if let liq = RealizedGainLossDataArr[indexPath.row]["Proceeds"]  as? String {
             //  let x = liq.rounded(toPlaces: 2)
            cell.liquidAmtLbl.text =  "\(Double(liq)!.rounded(toPlaces: 1))"
                              } else {
                                   cell.liquidAmtLbl.text = "0"// Was not a string
                              }

        
        
        return cell
    }
    
    
    
    
}

class RealizedGainLossCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var schemeNameLbl: UILabel!
    @IBOutlet weak var foliocNoLbl: UILabel!
    @IBOutlet weak var transactBtn: UIButton!
    @IBOutlet weak var DateofPuracheLbl: UILabel!
    @IBOutlet weak var DateofSaleLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var purchaseRate: UILabel!
    @IBOutlet weak var sellRateLbl: UILabel!
    @IBOutlet weak var AcqAmountLbl: UILabel!
    @IBOutlet weak var shortTremLbl: UILabel!
    @IBOutlet weak var longTremLbl: UILabel!
    @IBOutlet weak var liquidAmtLbl: UILabel!
    var selectTransact : ((Int) -> ())?
    override class func awakeFromNib() {
        print("Abcd")
    }
    override func layoutSubviews() {
        self.mainView.shadowOpacity(view: self.mainView, radius: 8)
    }
    
    
    
}
