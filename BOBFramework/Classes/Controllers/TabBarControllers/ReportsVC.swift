//
//  ReportsVC.swift
//  BOB
//
//  Created by mayank on 17/02/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import UIKit
import MMDrawerController

@available(iOS 13.0, *)
class ReportsVC: BaseClass {
var reportsDataArray = GlobleValue.HoldingDataArray
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func RealiszedGainLoss(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "RealizedGainLoss") as! RealizedGainLoss
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func CorporateAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "CoprateActionVC") as! CoprateActionVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func InsuranceAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "InsuranceVC") as! InsuranceVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func InvestMaurityAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "InvesmentMaurityVC") as! InvesmentMaurityVC
              self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func SipAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "SIPDueVC") as! SIPDueVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func TransactionAct(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "TranscationVC") as! TranscationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func HoldingBtnAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "HoldingsVC") as! HoldingsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func menuBtnAct(_ sender: Any) {
        print("Abcd")
        if #available(iOS 13.0, *) {
   //   let appdelegate = UIApplication.shared.delegate as! AppDelegate
                            
            BOBAppdelegate.shared.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
            BOBAppdelegate.shared.centerContainer!.closeDrawer(animated: true, completion: nil)
//      
        }
        else
        {
        }
    }
    @IBAction func HoldingAction(_ sender: Any) {
           print("Abcd")
        
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
