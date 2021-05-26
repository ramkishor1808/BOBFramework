//
//  NotificationView.swift
//  BOB
//
//  Created by Anushree on 3/25/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import UIKit
import KUIPopOver

class NotificationView: UIViewController, KUIPopOverUsable {
   // var contentSize: CGSize
    var tableDataArr     = [[String : Any]]()
    @IBOutlet weak var tableView : UITableView!
 let cellReuseIdentifier = "cell"
    var contentSize: CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
   }
    
    var popOverBackgroundColor: UIColor? {
        return .blue
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        self.tableView?.register(UINib(nibName: "NotificationView", bundle: BOBAppdelegate.shared.resourceBundle), forCellReuseIdentifier: cellReuseIdentifier)
        
      //  self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
       notificationAPICalling()
    }
    
    func notificationAPICalling() {
    let identifier = UUID()
           //GlobleValue.IdentifierValue = "\(identifier)"
           let testString = "\(identifier)|BOBWealth"

             let json = ["RequestBody":["UserType": 1,"UserCode": "32","UserId": "admin","ClientType": "H"],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
                 let jsonString1 = json.jsonDic
             
                 let encToken = try! testString.aesEncrypt()
            
                 let enc = try! jsonString1.aesEncrypt()
             
           APIManager.shareInstance.AuthenticationRequest(method: "Alert/Premiums", TPA: encToken, parameter: enc){
               (netResponse) -> (Void) in
               if(netResponse.statusCode == 200){
                print(netResponse.responseDict as Any)
                self.tableDataArr = netResponse.responseDict as? [[String : Any]] ?? [[:]]
                DispatchQueue.main.async {
                                   if self.tableDataArr.isEmpty{
                                     // self.tableDataArr("Data not found", type: .info)
                                   }
                           self.tableView.reloadData()
                                    }
               }
           
               }
        }
       
   
   
}
class CustomPopOverView1: UIView, KUIPopOverUsable {
 
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

    extension NotificationView : UITableViewDataSource,UITableViewDelegate{
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return  tableDataArr.count
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell  =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
            cell.tag   =  indexPath.row
            cell.textLabel!.text = "\(tableDataArr[indexPath.row]["AlertType"] as? String ?? ""): \(tableDataArr[indexPath.row]["AlertDescription"] as? String ?? "")"
           cell.detailTextLabel?.text = tableDataArr[indexPath.row]["DueDate"] as? String ?? ""

            return cell
        }
      
    }

    class NotificationCell: UITableViewCell {
        @IBOutlet weak var NameLbl: UILabel!
        @IBOutlet weak var noLbl: UILabel!
        @IBOutlet weak var amountLbl: UILabel!
        @IBOutlet weak var dateLbl: UILabel!
       
        override class func awakeFromNib() {
            print("Abcd")
        }
        
      
    }
