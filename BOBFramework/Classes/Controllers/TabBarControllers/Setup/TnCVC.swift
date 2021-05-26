//
//  TnCVC.swift
//  BOB
//
//  Created by Anushree on 3/18/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
class TnCVC : BaseClass {
//    @IBOutlet weak var schemeNameLbl : UILabel!
//    @IBOutlet weak var investmentAccLbl : UILabel!
//    @IBOutlet weak var folioNoBtn : UIButton!
//    @IBOutlet weak var amountBtn : UIButton!
//    @IBOutlet weak var addToCartLbl : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
// self.setNavigationtitle(titleText: "SET UP", view: self, rightImage: "chevron.left")
//      self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    @IBAction func cancelAct(_ sender: Any) {
            
              self.navigationController?.popToRootViewController(animated: true)
          }
    @IBAction func submitAct(_ sender: Any) {
            
             self.navigationController?.popToRootViewController(animated: true)
          }
         func submitAPICalling() {
           
            let identifier = UUID()
                   let testString = "\(identifier)|BOBWealth"
                   let json = ["Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
                   let jsonString1 = json.jsonDic
                   let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
                   let encToken = try! testString.aesEncrypt()
                   let enc = try! str.aesEncrypt()
                   self.start_Loader()
                   APIManager.shareInstance.AuthenticationRequest(method: "Comman/CallClientCreationActivation", TPA: encToken, parameter: enc){
                       (netResponse) -> (Void) in
                       if(netResponse.statusCode == 200){
                           self.stop_Loader()
                        print(netResponse.responseDict as Any)
   //  self.GetNationalResponse(responeDataArr : netResponse.responseDict as! [[String : Any]] )
                       }
                       else  {
                           self.stop_Loader()
                       }
                   }
           }

}

