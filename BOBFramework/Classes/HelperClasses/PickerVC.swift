//
//  PickerVC.swift
//  AhaCorporate
//
//  Created by mayank on 18/08/19.
//  Copyright © 2019 Mayank. All rights reserved.
//

import UIKit

protocol pickerDelegate {
    func setPickerVal(pickVal:String)
}

class PickerVC: UIViewController,UIGestureRecognizerDelegate,UIPickerViewDataSource,UIPickerViewDelegate {

    var delegate : pickerDelegate?
    var selectedInd = Int()
    var pickerArray = [String]()
    
    @IBOutlet weak var Picker: UIPickerView!
    @IBOutlet weak var pickerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        showAnimate()
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        self.pickerView.layer.cornerRadius   =  11
        self.pickerView.layer.shadowColor = UIColor.black.cgColor
        self.pickerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.pickerView.layer.shadowOpacity = 0.9
        self.pickerView.layer.shadowRadius = 5
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = true
        self.view.removeFromSuperview()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.view.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished)
            {
                self.navigationController?.isNavigationBarHidden = true
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        })
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        self.removeAnimate()
      //  if let selectedVal : Int = selectedInd{
            self.delegate?.setPickerVal(pickVal:self.pickerArray[selectedInd])
      //  }else{
         //   HelperClass.sharedHelper.showNormalAlert(message: "Please select one value from the list.", view: self)
      //  }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return self.pickerArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            //selectedInd = self.pickerArray[row]
            return "\(self.pickerArray[row])"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedInd = row
    }

}
