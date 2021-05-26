//
//  CustomView.swift
//  PopupView
//
//  Created by he on 2017/12/25.
//  Copyright © 2017年 hezongjiang. All rights reserved.
//

import UIKit
import KUIPopOver

class CustomView: UIViewController, KUIPopOverUsable {
   // var contentSize: CGSize
  //  @IBOutlet weak var detailView : CustomPopOverView!
    @IBOutlet weak var check1Btn : UIButton!
    @IBOutlet weak var check2Btn : UIButton!
    @IBOutlet weak var check3Btn : UIButton!
    @IBOutlet weak var check1lbl : UILabel!
    @IBOutlet weak var check2lbl : UILabel!
    @IBOutlet weak var check3lbl  : UILabel!
    
    @IBOutlet weak var namelbl : UILabel!
    @IBOutlet weak var emaillbl : UILabel!
    @IBOutlet weak var mobileNolbl  : UILabel!
    @IBOutlet weak var submitBtn : UIButton!
    
    var contentSize: CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
   }
    
    var popOverBackgroundColor: UIColor? {
        return .blue
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       //  GlobleValue.ClientProfileArray
        check2lbl.text = "\(GlobleValue.ClientName) My Porfolio "
        check3lbl.text = "\(GlobleValue.ClientName) Held Away Porfolio "
        namelbl.text = "Relationship Manager: \(GlobleValue.ClientManagerName) "
        emaillbl.text = "Email: \(GlobleValue.ClientEmail)"
        mobileNolbl.text = "Mobile No: \(GlobleValue.ClientNO)"
        //check3lbl.text = "\(GlobleValue.ClientName) Held Away Porfolio "
       check1Btn.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
              check1Btn.setImage(UIImage(named:"Checkmark"), for: .selected)

              check2Btn.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
              check2Btn.setImage(UIImage(named:"Checkmark"), for: .selected)

              check3Btn.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
              check3Btn.setImage(UIImage(named:"Checkmark"), for: .selected)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
    }
    @IBAction func checkMarkTapped(sender: UIButton) {
           UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
              // sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)

               sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
           })  { (success) in
               UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                   sender.isSelected = !sender.isSelected
                   sender.transform = .identity
               }, completion: nil)
           }
       }
    @IBAction func submitAct(_ sender: Any) {
       // detailView.showPopover(sourceView: self.view) {
       //     print("CustomPopOverView.show.completion")
      //  }
//        detailView.showPopover(sourceView: self) {
//            print("CustomPopOverView.show.completion")
//        }
    }
}
class CustomPopOverView: UIView, KUIPopOverUsable {
 
    var contentSize: CGSize {
        return CGSize(width: 300.0, height: 400.0)
    }
    
    var popOverBackgroundColor: UIColor? {
        return .black
    }
    
    var arrowDirection: UIPopoverArrowDirection {
        return .up
    }
    

    
}
