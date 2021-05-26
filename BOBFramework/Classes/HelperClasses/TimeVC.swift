//
//  TimeVC.swift
//  AhaCustomer
//
//  Created by Mayank on 29/07/19.
//  Copyright © 2019 Mayank. All rights reserved.
//

import UIKit

protocol TimeDelegate {
    func setTimeVal(dateTime:String)
}
class TimeVC: UIViewController,UIGestureRecognizerDelegate {

    var delegate : TimeDelegate?
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var dateView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        showAnimate()
    }

    override func viewDidLayoutSubviews() {
        self.dateView.layer.cornerRadius   =  11
        self.dateView.layer.shadowColor = UIColor.black.cgColor
        self.dateView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.dateView.layer.shadowOpacity = 0.9
        self.dateView.layer.shadowRadius = 5
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
        let timeformatter = DateFormatter()
        timeformatter.timeZone = TimeZone.current
        timeformatter.dateFormat = "hh:mm:ss a"
        let time  =  timeformatter.string(from: self.timePicker.date)
        print(time)
        self.delegate?.setTimeVal(dateTime:time)
    }
    

}
