//
//  DashboardVC.swift
//  BOB
//
//  Created by mayank on 15/02/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import UIKit
import KUIPopOver
@available(iOS 13.0, *)

@available(iOS 13.0, *)
class DashboardVC: BaseClass {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currentValueLbl: UILabel!
    @IBOutlet weak var investedAmountLbl: UILabel!
    @IBOutlet weak var GainLossLbl: UILabel!
    @IBOutlet weak var dividendInterestLbl: UILabel!
    @IBOutlet weak var iRRLbl: UILabel!
    @IBOutlet weak var netGainLbl: UILabel!
    @IBOutlet weak var netGainPercen: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var reAssessRisk: UIButton!
    
    @objc func buttonClicked() {
        print("Button Clicked")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationtitle(titleText : "DASHBOARD",view: self,rightImage : "menu")
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        AuthenticationApiCall()
    }
    
    
    override func viewDidLayoutSubviews() {
        self.startBtn.set_Button_Border(button: self.startBtn, borderColor: .clear, borderWidth: 0, corner: 6)
        self.reAssessRisk.set_Button_Border(button: self.reAssessRisk, borderColor: .clear, borderWidth: 0, corner: 6)
        self.netGainPercen.set_Label_Border(label: self.netGainPercen, corner: 5)
    }
    
    func PortfolioPerformanceAPICalling(completion: @escaping(_ result: [String:Any]) -> Void){
        let identifier = UUID()
        let testString = "\(identifier)|BOBWealth"
        //start_Loader()
        let json = ["RequestBody":["ClientCode": "447",
                                   "UserID": "admin",
                                   "IndexType": "0",
                                   "LastBusinessDate": "2021-03-15T11:32:20.0921684+05:30",
                                   "CurrencyCode": 5,
                                   "AmountDenomination": 0,
                                   "AccountLevel": 0,
                                   "FromDate": "1900-01-01T11:32:20.0921684+05:30",
                                   "IsFundware": false,
                                   "ClientType": "H"],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
        let jsonString1 = json.jsonDic
        let encToken = try! testString.aesEncrypt()
        let enc = try! jsonString1.aesEncrypt()
        APIManager.shareInstance.AuthenticationRequest(method: "Client/PortfolioPerformance", TPA: encToken, parameter: enc){
            (netResponse) -> (Void) in
            completion(netResponse.responseDict as? [String : Any] ?? [:])
            
        }
    }
    func AuthenticationApiCall() {
        let identifier = UUID()
        let testString = "\(identifier)|BOBWealth"
       // self.start_Loader()
        //{"FLAG":"0","IsAuthenticated":"true","IsFundware":"false","UCC":"069409856","channel":"14","tandc":"0"}
        let json = ["RequestBody":["FLAG":"0","IsAuthenticated":"true","IsFundware":"false","UCC":"069409856","channel":"14","tandc":"0"],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
        let jsonString1 = json.jsonDic
        let encToken = try! testString.aesEncrypt()
        let enc = try! jsonString1.aesEncrypt()
        APIManager.shareInstance.AuthenticationRequest(method: "Authentication/Authenticate", TPA: encToken, parameter: enc){
            (netResponse) -> (Void) in
            print(netResponse.responseDict as Any)
            self.stop_Loader()
            if((netResponse.responseDict!["UserID"]) != nil)
            {
                 let dispatchGroup = DispatchGroup()
                 dispatchGroup.enter()
               // self.start_Loader()
                self.HoldingsAPICalling() { (response) in
                    print(response)
                    self.stop_Loader()
                    GlobleValue.HoldingDataArray = response
                    dispatchGroup.leave()
                }
                
                dispatchGroup.enter()
                self.clientProfileAPICalling() { (response) in
                    print(response)
                    //  self.stop_Loader()
                    GlobleValue.ClientProfileArray = response
                    let str = GlobleValue.ClientProfileArray[0]["ClientName"] as? String ?? ""
                    let array : [String] = str.components(separatedBy: "-")
                    GlobleValue.ClientName  = array[0]
                    GlobleValue.ClientManagerName = GlobleValue.ClientProfileArray[0]["PrimaryRMName"] as? String ?? ""
                    GlobleValue.ClientEmail = GlobleValue.ClientProfileArray[0]["PrimaryRMEmail"] as? String ?? ""
                    GlobleValue.ClientNO = GlobleValue.ClientProfileArray[0]["PrimaryRMContactNo"] as? String ?? ""
                    
                    dispatchGroup.leave()
                }
                dispatchGroup.enter()
                self.PortfolioPerformanceAPICalling() { (response) in
                    print(response)
                    GlobleValue.potfolioDataDic = response
                    DispatchQueue.main.async {
                        if let value = response["InvestmentMarketValue"]! as? Double {
                            let x = value.rounded(toPlaces: 1)
                            self.currentValueLbl.text =  "\(x)"
                        } else {
                            print("0") // Was not a string
                        }
                        if let value = response["ProfitLoss"]! as? Double {
                            let x = value.rounded(toPlaces: 1)
                            self.GainLossLbl.text =  "\(x)"
                        } else {
                            print("0") // Was not a string
                        }
                        if let value = response["InvestmentCostValue"]! as? Double {
                            let x = value.rounded(toPlaces: 1)
                            self.investedAmountLbl.text =  "\(x)"
                        } else {
                            print("0") // Was not a string
                        }
                        if let value = response["dividentInterest"]! as? Double {
                            let x = value.rounded(toPlaces: 1)
                            self.dividendInterestLbl.text =  "\(x)"
                        } else {
                            print("0") // Was not a string
                        }
                        //                            if let value = response["ReturnSinceInception"] ?? "0.0" as? Double {
                        //                                        let x = value.rounded(toPlaces: 1)
                        //                                        self.iRRLbl.text =  "\(x)"
                        //                                    } else {
                        //                                        print("0") // Was not a string
                        //                                    }
                        if let value =  response["GainLossPercent"]! as? Double {
                            let x = value.rounded(toPlaces: 1)
                            self.netGainPercen.text =  "\(x)"
                        } else {
                            print("0") // Was not a string
                        }
                        
                        if let value = response["dividentInterest"]! as? Double,  let value1 = response["ProfitLoss"]! as? Double{
                            self.netGainLbl.text =  "\(value.rounded(toPlaces: 1) + value1.rounded(toPlaces: 1))"
                        }
                    }
                    dispatchGroup.leave()
                }
                dispatchGroup.enter()
                
                self.TransactionsAPICalling() { (response) in
                print("Transaction Api",response)
                dispatchGroup.leave()
                }
               
            }else{
                let vc = self.storyboard?.instantiateViewController(identifier: "setUpVc") as! setUpVc
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
    func AuthData()  {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        self.HoldingsAPICalling() { (response) in
            print(response)
            // self.stop_Loader()
            GlobleValue.HoldingDataArray = response
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        self.clientProfileAPICalling() { (response) in
            print(response)
            //  self.stop_Loader()
            GlobleValue.ClientProfileArray = response
            let str = GlobleValue.ClientProfileArray[0]["ClientName"] as? String ?? ""
            let array : [String] = str.components(separatedBy: "-")
            GlobleValue.ClientName  = array[0]
            GlobleValue.ClientManagerName = GlobleValue.ClientProfileArray[0]["PrimaryRMName"] as? String ?? ""
            GlobleValue.ClientEmail = GlobleValue.ClientProfileArray[0]["PrimaryRMEmail"] as? String ?? ""
            GlobleValue.ClientNO = GlobleValue.ClientProfileArray[0]["PrimaryRMContactNo"] as? String ?? ""
            
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        self.PortfolioPerformanceAPICalling() { (response) in
            print(response)
            GlobleValue.potfolioDataDic = response
            DispatchQueue.main.async {
                if let value = response["InvestmentMarketValue"]! as? Double {
                    let x = value.rounded(toPlaces: 1)
                    self.currentValueLbl.text =  "\(x)"
                } else {
                    print("0") // Was not a string
                }
                if let value = response["ProfitLoss"]! as? Double {
                    let x = value.rounded(toPlaces: 1)
                    self.GainLossLbl.text =  "\(x)"
                } else {
                    print("0") // Was not a string
                }
                if let value = response["InvestmentCostValue"]! as? Double {
                    let x = value.rounded(toPlaces: 1)
                    self.investedAmountLbl.text =  "\(x)"
                } else {
                    print("0") // Was not a string
                }
                if let value = response["dividentInterest"]! as? Double {
                    let x = value.rounded(toPlaces: 1)
                    self.dividendInterestLbl.text =  "\(x)"
                } else {
                    print("0") // Was not a string
                }
                //                            if let value = response["ReturnSinceInception"] ?? "0.0" as? Double {
                //                                        let x = value.rounded(toPlaces: 1)
                //                                        self.iRRLbl.text =  "\(x)"
                //                                    } else {
                //                                        print("0") // Was not a string
                //                                    }
                if let value =  response["GainLossPercent"]! as? Double {
                    let x = value.rounded(toPlaces: 1)
                    self.netGainPercen.text =  "\(x)"
                } else {
                    print("0") // Was not a string
                }
                
                if let value = response["dividentInterest"]! as? Double,  let value1 = response["ProfitLoss"]! as? Double{
                    self.netGainLbl.text =  "\(value.rounded(toPlaces: 1) + value1.rounded(toPlaces: 1))"
                }
            }
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        self.TransactionsAPICalling() { (response) in
                   print(response)
                   
                   
                   dispatchGroup.leave()
               }
        dispatchGroup.wait()
    }
    func HoldingsAPICalling(completion: @escaping(_ result: [[String:Any]]) -> Void)
    {
        let identifier = UUID()
        let testString = "\(identifier)|BOBWealth"
        // start_Loader()
        let json = ["RequestBody":["AccountLevel":"0","AmountDenomination":"0","CurrencyCode":"1","LastBusinessDate":"2020-06-14T00:00:00","UserCode":"32","UserId":"069409856","UserType":"2"],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
        let jsonString1 = json.jsonDic
        let encToken = try! testString.aesEncrypt()
        let enc = try! jsonString1.aesEncrypt()
        APIManager.shareInstance.AuthenticationRequest(method: "Client/Holdings", TPA: encToken, parameter: enc){
            (netResponse) -> (Void) in
            completion(netResponse.responseDict as! [[String : Any]])
            
        }
    }
    
    func clientProfileAPICalling(completion: @escaping(_ result: [[String:Any]]) -> Void){
        let identifier = UUID()
        let testString = "\(identifier)|BOBWealth"
        let json = ["RequestBody":["UserId":"adminchecker","UserType":2,"UserCode":"1","LastBusinessDate":"2018-02-07T00:00:00","CurrencyCode":1,"AmountDenomination":0,"AccountLevel":0],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
        let jsonString1 = json.jsonDic
        let encToken = try! testString.aesEncrypt()
        let enc = try! jsonString1.aesEncrypt()
        //   start_Loader()
        APIManager.shareInstance.AuthenticationRequest(method: "Client/Profile", TPA: encToken, parameter: enc){
            (netResponse) -> (Void) in
            completion(netResponse.responseDict as! [[String : Any]])
            
        }
    }
    
func TransactionsAPICalling(completion: @escaping(_ result: [[String:Any]]) -> Void) {
            let identifier = UUID()
            let testString = "\(identifier)|BOBWealth"
            let json = ["RequestBody":["ClientType":"H","IsFundware":"false","AccountLevel":0,"AmountDenomination":0,"CurrencyCode":1,"DateFrom":"2021-03-02T19:47:38","DateTo":"2021-03-09T19:47:38","OnlineAccountCode":"32","OrderType":"1","PageIndex":"0","PageSize":"0","SchemeCode":"0","UserId":"069409856"],"Source":"BOBWealth","UniqueIdentifier":"\( identifier)"] as [String : Any]
                     let jsonString1 = json.jsonDic
                     let str1 = jsonString1.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
                                    let str2 = str1.replacingOccurrences(of: "//", with: "/", options: NSString.CompareOptions.literal, range: nil)
                         let encToken = try! testString.aesEncrypt()
                         let enc = try! str2.aesEncrypt()
    
  
                 // self.start_Loader()
                  APIManager.shareInstance.AuthenticationRequest(method: "Client/Transactions", TPA: encToken, parameter: enc){
                        (netResponse) -> (Void) in
                  completion(netResponse.responseDict as! [[String : Any]])

       }
    }
    
    @IBAction func currentValueAct(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "HoldingsVC") as! HoldingsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func startNowAct(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "NewFundVC") as! NewFundVC
        // vc.index = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func existingProfile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "TransactVC") as! TransactVC
        // vc.index = indexPath.row
        vc.isComingDashboard = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func newFundAct(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "NewFundVC") as! NewFundVC
        // vc.index = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func riskprofileAct(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "riskProfileVC") as! riskProfileVC
        // vc.index = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


@available(iOS 13.0, *)
extension DashboardVC : UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    //MARK::-- Table Cell DataSource & Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TransactionCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //MARK::-- Collection Cell DataSource & Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FundCell
        if indexPath.item == 0 {
            cell.textLbl.text = "Equity Funds"
        } else if indexPath.item == 1 {
            cell.textLbl.text = "Debt Funds"
        }else if indexPath.item == 2{
            cell.textLbl.text = "Taxing Funds"
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width/3.5, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "NewFundVC") as! NewFundVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

class TransactionCell: UITableViewCell {
    @IBOutlet weak var dateView: UIView!
    override class func awakeFromNib() {
        print("Abcd")
    }
    override func layoutIfNeeded() {
        self.dateView.set_View_Border(viewName: self.dateView, borderColor: .clear, borderWidth: 0, corner: 6)
    }
}

class FundCell: UICollectionViewCell {
    @IBOutlet weak var textLbl: UILabel!
    override class func awakeFromNib() {
        print("Abcd")
    }
}
