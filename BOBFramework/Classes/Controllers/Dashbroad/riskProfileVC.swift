//
//  riskProfileVC.swift
//  BOB
//
//  Created by Anushree on 3/14/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import Foundation
import UIKit
@available(iOS 13.0, *)
class riskProfileVC: BaseClass {
    var riskProfileDic     = [String : Any]()
    var riskProfile     = [[String : Any]]()
    var riskProfileArr     = [[String : Any]]()
    var tableArray     = [[String : Any]]()
    var quesArray     = [[String : Any]]()
    var selectedCardIndex : Int = 0
     //var selectedCardIndex : St = 0
    var AnsArrList = [String]()
    var QuesArrList = [String]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var QuestionLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Risk Profile"
        GetRiskAPICalling()
    }
    func GetRiskAPICalling() {
        
        //  {"MWIClientCode":257856,"SchemeCode":2113}
        
        start_Loader()
        let identifier = UUID()
        let testString = "\(identifier)|BOBWealth"
        let json = ["RequestBody":["ClientCode": "32"],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
        let jsonString1 = json.jsonDic
        let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
        let encToken = try! testString.aesEncrypt()
        let enc = try! str.aesEncrypt()
        
        APIManager.shareInstance.AuthenticationRequest(method: "RiskProfile/RiskProfileQuestionnaire", TPA: encToken, parameter: enc){
            (netResponse) -> (Void) in
            if(netResponse.statusCode == 200){
                self.stop_Loader()
                print(netResponse.responseDict as Any)
              self.riskProfileDic = netResponse.responseDict as! [String : Any]
                  
                for arr in [self.riskProfileDic] {
                 
                    for arr1 in arr["RiskProfileQuestionCollection"] as! [[String : Any]]  {
                        self.riskProfileArr.append(arr1)
                    }
                }
              
                DispatchQueue.main.async {
                    if self.riskProfileArr.isEmpty{
                        self.showMessage("Data not found", type: .info)
                    }
                   
          self.QuestionLbl.text = self.riskProfileArr[self.selectedCardIndex]["QuestionDescription"] as? String
                    
          self.tableArray = self.riskProfileArr[self.selectedCardIndex]["AnswerCollection"]as! [[String : Any]]
                   
                    self.tableView.reloadData()
                }
            }
            else{
                self.stop_Loader()
            }
        }
    }
    @IBAction func nextIssueAction(_ sender: UIButton){
        
           if(self.riskProfileArr.count>0)
           {
               
               if(selectedCardIndex == self.riskProfileArr.count-1)
               {
                   selectedCardIndex = 0
              
                   submitBtn.setTitle("Submit", for: .normal)
              
                  
             
                
                 GetRiskResponseAPICalling()
                
               }else{
                   selectedCardIndex = selectedCardIndex  + 1
                submitBtn.setTitle("Next", for: .normal)
               }
            self.QuestionLbl.text = self.riskProfileArr[self.selectedCardIndex]["QuestionDescription"] as? String
                      
            self.tableArray = self.riskProfileArr[self.selectedCardIndex]["AnswerCollection"]as! [[String : Any]]
                     
                      self.tableView.reloadData()
           }
           
       }
    func GetRiskResponseAPICalling() {
       self.riskProfileDic["RiskProfileQuestionCollection"] = riskProfileArr
       print(riskProfileDic)
      
           start_Loader()
           let identifier = UUID()
           let testString = "\(identifier)|BOBWealth"
         let json = ["RequestBody":["RiskProfileQuestionnaire":riskProfileDic,"ClientCode":"32"],"Source" : "BOBWealth","UniqueIdentifier" : "\(identifier)"] as [String : Any]
           let jsonString1 = json.jsonDic
           
           
           let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
           let encToken = try! testString.aesEncrypt()
           let enc = try! str.aesEncrypt()
           
           APIManager.shareInstance.AuthenticationRequest(method: "Client/RiskProfileResponse", TPA: encToken, parameter: enc){
               (netResponse) -> (Void) in
               if(netResponse.statusCode == 200){
                   self.stop_Loader()
                   
                   print(netResponse.responseDict as Any)
                  DispatchQueue.main.async {
                    self.showMessage("Successful submit", type: .success)
                    self.navigationController?.popViewController(animated: true)
                }
                   
//                   for arr in [netResponse.responseDict as! [String : Any]] {
//
//                       for arr1 in arr["RiskProfileQuestionCollection"] as! [[String : Any]]  {
//                           self.riskProfileArr.append(arr1)
//                       }
//                   }
//                   print( self.riskProfileArr)
//                   DispatchQueue.main.async {
//                       if self.riskProfileArr.isEmpty{
//                           self.showMessage("Data not found", type: .info)
//                       }
//
//             self.QuestionLbl.text = self.riskProfileArr[self.selectedCardIndex]["QuestionDescription"] as? String
//
//             self.tableArray = self.riskProfileArr[self.selectedCardIndex]["AnswerCollection"]as! [[String : Any]]
//
//                       self.tableView.reloadData()
//                   }
               }
               else{
                   self.stop_Loader()
               }
           }
       }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    //MARK:- checkMarkTapped
     @IBAction func checkMarkTapped(sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
           // sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)

            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        })  { (success) in
            
           self.tableArray[sender.tag]["Selected"]   = 1
            
           // var someDictionary = ["Nepal":"Kathmandu", "China":"Beijing", "India":"NewDelhi"]
            // self.riskProfileDic[1]["RiskProfileQuestionCollection"][selectedCardIndex]["AnswerCollection"] = self.tableArray
            self.riskProfileArr[self.selectedCardIndex]["AnswerCollection"] = self.tableArray
           
           
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }

}
@available(iOS 13.0, *)
extension riskProfileVC : UITableViewDataSource,UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! riskCell
        cell.tag   =  indexPath.row
     
        cell.NameLbl.text = tableArray[indexPath.row]["AnswerDescription"] as? String ?? ""
        cell.checkBtn.isSelected = false
       // cell.frtyr56r4ddee  er3r4.tag = indexPath.row
        cell.checkBtn.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
        cell.checkBtn.setImage(UIImage(named:"Checkmark"), for: .selected)
        
        return cell
    }
    func RiskProfileResponseAPI() {
        
        
//        {"ClientCode":"1","RiskProfileQuestionnaire":{"QuestionSetCode":"6","RiskProfileQuestionCollection":[{"QuestionCode":"7","QuestionDescription":"Your Highest Qualification","AnswerCollection":[{"AnswerCode":"16","AnswerDescription":"MBBS","Selected":true},{"AnswerCode":"17","AnswerDescription":"SSC","Selected":false}]},{"QuestionCode":"17","QuestionDescription":"Your Secondary Highest Qualification","AnswerCollection":[{"AnswerCode":"47","AnswerDescription":"B.Sc.","Selected":true}]},{"QuestionCode":"18","QuestionDescription":"What is Your Height?","AnswerCollection":[{"AnswerCode":"48","AnswerDescription":"ok","Selected":true}]},{"QuestionCode":"8","QuestionDescription":"what is ur age","AnswerCollection":[{"AnswerCode":"18","AnswerDescription":"15","Selected":true},{"AnswerCode":"19","AnswerDescription":"20","Selected":false}]}]}}
        
         start_Loader()
               let identifier = UUID()
               let testString = "\(identifier)|BOBWealth"
               let json = ["ClientCode":"32","RiskProfileQuestionnaire":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
               let jsonString1 = json.jsonDic
               
               
               let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
               let encToken = try! testString.aesEncrypt()
               let enc = try! str.aesEncrypt()
               
               APIManager.shareInstance.AuthenticationRequest(method: " Client/RiskProfileResponse", TPA: encToken, parameter: enc){
                   (netResponse) -> (Void) in
                   if(netResponse.statusCode == 200){
                       self.stop_Loader()
                       
                       print(netResponse.responseDict as Any)
                       
                       for arr in [netResponse.responseDict as! [String : Any]] {
                           
                           for arr1 in arr["RiskProfileQuestionCollection"] as! [[String : Any]]  {
                               self.riskProfileArr.append(arr1)
                           }
                       }
                       print( self.riskProfileArr)
                       DispatchQueue.main.async {
                           if self.riskProfileArr.isEmpty{
                               self.showMessage("Data not found", type: .info)
                           }
                          print("Ques::\(self.riskProfileArr[self.selectedCardIndex]["QuestionDescription"]as! String)")
                 self.QuestionLbl.text = self.riskProfileArr[self.selectedCardIndex]["QuestionDescription"] as? String
                           
                 self.tableArray = self.riskProfileArr[self.selectedCardIndex]["AnswerCollection"]as! [[String : Any]]
                          
                           self.tableView.reloadData()
                       }
                   }
                   else{
                       self.stop_Loader()
                   }
               }
    }
   

   

    

}

class riskCell: UITableViewCell {
   
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    
   
   
//    var selectTransact : ((Int) -> ())?
    override class func awakeFromNib() {
        print("Abcd")
    }
    
    
}
