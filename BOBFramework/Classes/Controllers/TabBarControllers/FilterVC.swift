//
//  FilterVC.swift
//  BOB
//
//  Created by mayank on 19/02/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class FilterVC: BaseClass {
    @IBOutlet weak var commodetiesView: UIView!
    @IBOutlet weak var debtView: UIView!
    @IBOutlet weak var equityView: UIView!
    @IBOutlet weak var growthView: UIView!
    @IBOutlet weak var dividentPayoutView: UIView!
    @IBOutlet weak var dividentReinvestView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
GetAssetTypesAPICalling()
    }
    func GetAssetTypesAPICalling() {
          
           let identifier = UUID()
                  let testString = "\(identifier)|BOBWealth"
                  let json = ["RequestBody":["AccountLevel":"0","AllocationType":"2","ClientCode":"32","CurrencyCode":"1.0","LastBusinessDate":"2018-02-07T00:00:00","UserId":"069409856"],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
                  let jsonString1 = json.jsonDic
                  let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
                  let encToken = try! testString.aesEncrypt()
                  let enc = try! str.aesEncrypt()
                  self.start_Loader()
                  APIManager.shareInstance.AuthenticationRequest(method: "AssetType/AssetTypes", TPA: encToken, parameter: enc){
                      (netResponse) -> (Void) in
                      if(netResponse.statusCode == 200){
                          self.stop_Loader()
                       print(netResponse.responseDict as Any)
    self.GetAssetTypeResponse(responeDataArr : netResponse.responseDict as! [[String : Any]] )
                      }
                      else  {
                          self.stop_Loader()
                      }
                  }
          }
         func GetAssetTypeResponse(responeDataArr : [[String :Any]]) {
           print(responeDataArr)
            print(responeDataArr[0]["AssetClassName"] ?? "")
       }
    func GetIssuerAPICalling() {
          
           let identifier = UUID()
                  let testString = "\(identifier)|BOBWealth"
                  let json = ["RequestBody":["ClientCode":"32"],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
                  let jsonString1 = json.jsonDic
                  let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
                  let encToken = try! testString.aesEncrypt()
                  let enc = try! str.aesEncrypt()
                  self.start_Loader()
                  APIManager.shareInstance.AuthenticationRequest(method: "Issuer/Issuers", TPA: encToken, parameter: enc){
                      (netResponse) -> (Void) in
                      if(netResponse.statusCode == 200){
                          self.stop_Loader()
                       print(netResponse.responseDict as Any)
    self.GetIssuerResponse(responeDataArr : netResponse.responseDict as! [[String : Any]] )
                      }
                      else  {
                          self.stop_Loader()
                      }
                  }
          }
         func GetIssuerResponse(responeDataArr : [[String :Any]]) {
           print(responeDataArr)
       }
    func GetFundTypeAPICalling() {
          
           let identifier = UUID()
                  let testString = "\(identifier)|BOBWealth"
                  let json = ["RequestBody":["ClientCode":"32"],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
                  let jsonString1 = json.jsonDic
                  let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
                  let encToken = try! testString.aesEncrypt()
                  let enc = try! str.aesEncrypt()
                  self.start_Loader()
                  APIManager.shareInstance.AuthenticationRequest(method: "FundType/FundTypes", TPA: encToken, parameter: enc){
                      (netResponse) -> (Void) in
                      if(netResponse.statusCode == 200){
                          self.stop_Loader()
                       print(netResponse.responseDict as Any)
    self.GetFundTypeResponse(responeDataArr : netResponse.responseDict as! [[String : Any]] )
                      }
                      else  {
                          self.stop_Loader()
                      }
                  }
          }
         func GetFundTypeResponse(responeDataArr : [[String :Any]]) {
           print(responeDataArr)
       }


  


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
