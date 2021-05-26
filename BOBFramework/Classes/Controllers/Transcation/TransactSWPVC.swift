//
//  TransactSWPVC.swift
//  BOB
//
//  Created by Anushree on 3/17/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
class TrasactSWPVC : BaseClass {
    @IBOutlet weak var schemeNameLbl : UILabel!
    @IBOutlet weak var investmentAccLbl : UILabel!
     @IBOutlet weak var frequencyBtn : UIButton!
     @IBOutlet weak var dayBtn : UIButton!
     @IBOutlet weak var SIPdateBtn : UILabel!
     @IBOutlet weak var cancelBtn : UIButton!
    @IBOutlet weak var folioNoBtn : UIButton!
    @IBOutlet weak var amountBtn : UIButton!
    @IBOutlet weak var addToCartLbl : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

            // self.setNavigationtitle(titleText: "Redeem", view: self, rightImage: "chevron.left")
    }

}
