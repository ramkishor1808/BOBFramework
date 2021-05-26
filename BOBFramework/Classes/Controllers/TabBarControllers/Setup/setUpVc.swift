//
//  setUpVc.swift
//  BOB
//
//  Created by Anushree on 3/14/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class setUpVc : BaseClass {
//    @IBOutlet weak var schemeNameLbl : UILabel!
//    @IBOutlet weak var investmentAccLbl : UILabel!
//    @IBOutlet weak var folioNoBtn : UIButton!
//    @IBOutlet weak var amountBtn : UIButton!
//    @IBOutlet weak var addToCartLbl : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//    self.setNavigationtitle(titleText: "SET UP", view: self, rightImage: "chevron.left")
//         self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.setNavigationtitle(titleText : "SET UP",view: self,rightImage : "menu")
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    @IBAction func nextAct(_ sender: Any) {
          let vc = self.storyboard?.instantiateViewController(identifier: "RegistationVc") as! RegistationVc
        self.navigationController?.pushViewController(vc, animated: true)
       }
    @IBAction func cancelAct(_ sender: Any) {
            
              self.navigationController?.popToRootViewController(animated: true)
          }
}
