//
//  TansactBuyVC.swift
//  BOB
//
//  Created by Anushree on 3/16/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
class TansactBuyVC : BaseClass {
    @IBOutlet weak var schemeNameLbl : UILabel!
    @IBOutlet weak var investmentAccLbl : UILabel!
    @IBOutlet weak var folioNoBtn : UIButton!
    @IBOutlet weak var amountBtn : UIButton!
    @IBOutlet weak var addToCartLbl : UIButton!
    var index = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(GlobleValue.HoldingDataArray[index])
        schemeNameLbl.text = GlobleValue.HoldingDataArray[index]["SchemeName"] as? String
        if let Folio = GlobleValue.HoldingDataArray[index]["Folio"]  as? Int {
              
            folioNoBtn.setTitle("\(Folio)", for: .normal)
                             } else {
            folioNoBtn.setTitle(GlobleValue.HoldingDataArray[index]["Folio"] as? String ?? "", for: .normal)
                             }
        if let CostofInvestment = GlobleValue.HoldingDataArray[index]["CostofInvestment"]  as? Int {
                     
                   amountBtn.setTitle("\(CostofInvestment)", for: .normal)
                                    } else {
                   amountBtn.setTitle("", for: .normal)
            }
        
//        if let AccofInvestment = GlobleValue.InvestertAccDataArray[index]["CostofInvestment"]  as? Int {
//          
//        amountBtn.setTitle("\(AccofInvestment)", for: .normal)
//                         } else {
//        amountBtn.setTitle("", for: .normal)
//                         }
        
        
     //   self.setNavigationtitle(titleText: "Buy", view: self, rightImage: "chevron.left")
    }

    @IBAction func folioAction(_ sender: Any) {
    }
    @IBAction func amountAction(_ sender: Any) {
    }
    @IBAction func addCart(_ sender: Any) {
        
//        [{"MWIClientCode":547188,"LatestNAV":10.8,"TransactionType":"SIP","SchemeCode":169,"SchemeName":"Aditya Birla SL Arbitrage-D Reinvestment","ValueResearchRating":"1","FundRiskRating":"","AssetClassCode":"0","inputmode":2,"TxnAmountUnit":5001.0,"IsDividend":true,"DividendOption":"P","ParentChannelID":"WMSPortal","L4ClientCode":601029,"CurrentUnits":"0","CurrentFundValue":"0","CostofInvestment":"0","frequency":"Weekly","AllorPartial":"P","AmountOrUnit":"U","StartDate":"20180921","TargetFundCode":"0","Period":"70","NoofMonth":"0","ICDID":"15194","SettlementBankCode":0,"SipStartDates":"4,5,6,7,10,11,12,13,14,17,18,19,20,21,24,25,26,27,28,3|1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28","NomineeName1":"Dipa","DateOfBirth1":"19800101","NomineeRelationship1":"Sister","NomineeShare1":50.0,"NomineeAddress1":"Mumbai","NomineeIsMinor1":false,"NomineeName2":"Pravakar","DateOfBirth2":"20050402","NomineeRelationship2":"Brother","NomineeShare2":20.0,"NomineeAddress2":"Delhi","NomineeIsMinor2":false,"GuardianName2":"Sangita","NomineeName3":"Drishti","DateOfBirth3":"19940304","NomineeRelationship3":"Sister","NomineeShare3":30.0,"NomineeAddress3":"Darjeeling","NomineeIsMinor3":false,"GuardianName3":"Varun","IsApplyNominee":true}]
//
        
        // self.start_Loader()
                     let identifier = UUID()
                     let testString = "\(identifier)|BOBWealth"
            var uploadArray = [[String: Any]]()
           
           
                     let json = ["MWIClientCode":547188,"LatestNAV":10.8,"TransactionType":"SIP","SchemeCode":169,"SchemeName":"Aditya Birla SL Arbitrage-D Reinvestment","ValueResearchRating":"1","FundRiskRating":"","AssetClassCode":"0","inputmode":2,"TxnAmountUnit":5001.0,"IsDividend":true,"DividendOption":"P","ParentChannelID":"WMSPortal","L4ClientCode":601029,"CurrentUnits":"0","CurrentFundValue":"0","CostofInvestment":"0","frequency":"Weekly","AllorPartial":"P","AmountOrUnit":"U","StartDate":"20180921","TargetFundCode":"0","Period":"70","NoofMonth":"0","ICDID":"15194","SettlementBankCode":0,"SipStartDates":"4,5,6,7,10,11,12,13,14,17,18,19,20,21,24,25,26,27,28,3|1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28","NomineeName1":"Dipa","DateOfBirth1":"19800101","NomineeRelationship1":"Sister","NomineeShare1":50.0,"NomineeAddress1":"Mumbai","NomineeIsMinor1":false,"NomineeName2":"Pravakar","DateOfBirth2":"20050402","NomineeRelationship2":"Brother","NomineeShare2":20.0,"NomineeAddress2":"Delhi","NomineeIsMinor2":false,"GuardianName2":"Sangita","NomineeName3":"Drishti","DateOfBirth3":"19940304","NomineeRelationship3":"Sister","NomineeShare3":30.0,"NomineeAddress3":"Darjeeling","NomineeIsMinor3":false,"GuardianName3":"Varun","IsApplyNominee":true] as [String : Any]
                         uploadArray.append(json)
                                        //  let jsonString1 = json.jsonDic
        
                              
//
//                                  let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
//                                let encToken = try! testString.aesEncrypt()
//                                  let enc = try! str.aesEncrypt()
//
//                      APIManager.shareInstance.AuthenticationRequest(method: "Order/AddInvCart", TPA: encToken, parameter: enc){
//                                 (netResponse) -> (Void) in
//                                 if(netResponse.statusCode == 200){
//                                        self.stop_Loader()
//                                     print(netResponse.responseDict as Any)
//                                  GlobleValue.InvestertAccDataArray = netResponse.responseDict as? [[String : Any]] ?? [[:]]
//
//
//                         }
//                        self.stop_Loader()
//                                 }
        
    }
}
