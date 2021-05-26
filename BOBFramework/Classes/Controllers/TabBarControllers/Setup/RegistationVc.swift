//
//  RegistationVc.swift
//  BOB
//
//  Created by Anushree on 3/19/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
class RegistationVc : BaseClass,DateDelegate,pickerDelegate, UITextFieldDelegate {
    @IBOutlet weak var panNoTxt : UITextField!
    @IBOutlet weak var nameTxt : UITextField!
    @IBOutlet weak var dateOfBirthBtn : UIButton!
    @IBOutlet weak var forHNmaeTxt : UITextField!
    @IBOutlet weak var motherMaidenTxt : UITextField!
    @IBOutlet weak var nationalBtn : UIButton!
    @IBOutlet weak var genderBtn : UIButton!
    @IBOutlet weak var marreidStatusBtn : UIButton!
    @IBOutlet weak var emailTxt : UITextField!
    @IBOutlet weak var mobileTxt : UITextField!
    @IBOutlet weak var addressTypeBtn : UIButton!
    @IBOutlet weak var addressLine1Txt : UITextField!
    @IBOutlet weak var addressLine2Txt : UITextField!
    @IBOutlet weak var addressLine3Txt : UITextField!
    @IBOutlet weak var cityBtn : UIButton!
    @IBOutlet weak var stateBtn : UIButton!
    @IBOutlet weak var countryBtn : UIButton!
    @IBOutlet weak var pinTxt : UITextField!
    
    @IBOutlet weak var birthPlaceTxt : UITextField!
    @IBOutlet weak var birthCountryBtn : UIButton!
    @IBOutlet weak var occupationBtn : UIButton!
    @IBOutlet weak var politicalExposedBtn : UIButton!
    @IBOutlet weak var grossAnnualBtn : UIButton!
    @IBOutlet weak var wealthSourceBtn : UIButton!
    @IBOutlet weak var currentNetTxt : UITextField!
    @IBOutlet weak var addNomineeYesBtn : UIButton!
    @IBOutlet weak var addNomineeNoBtn : UIButton!
    @IBOutlet weak var nameNomineeTxt : UITextField!
    @IBOutlet weak var dobBtn : UIButton!
    @IBOutlet weak var relationshipTxt : UITextField!
    @IBOutlet weak var nomineeShareTxt : UITextField!
    @IBOutlet weak var address1Txt : UITextField!
    @IBOutlet weak var address2Txt : UITextField!
    @IBOutlet weak var isMinorYesBtn : UIButton!
    @IBOutlet weak var isMinorNoBtn : UIButton!
    @IBOutlet weak var guardianNameTxt : UITextField!
    @IBOutlet weak var nextBtn : UIButton!
    @IBOutlet weak var cancelBtn : UIButton!
    
    var fieldDataArr = [[String : Any]]()
    var cityDataArr = [[String : Any]]()
    var stateDataArr = [[String : Any]]()
    var countryDataArr = [[String : Any]]()
    var MaritalStatusDataArr = [[String : Any]]()
    var genderDataArr = [[String : Any]]()
   
    var SourceOFWealthDataArr = [[String : Any]]()
    var OccupationDataArr = [[String : Any]]()
    var AddressTypeDataArr = [[String : Any]]()
    var GrossAnnIncomeDataArr = [[String : Any]]()
    var  TitleDataArr = [[String : Any]]()
    var PoliticalFigureDataArr = [[String : Any]]()
     var nationalDataArr = [[String : Any]]()
   
    
  
      
    override func viewDidLoad() {
        super.viewDidLoad()
 //self.setNavigationtitle(titleText: "SET UP", view: self, rightImage: "chevron.left")
      //  self.navigationController?.setNavigationBarHidden(false, animated: true)
        
         let dispatchGroup = DispatchGroup()
                dispatchGroup.enter()
                GetFinacleClientDetailsAPICalling() { (response) in
                    print("GetFinacleClientDetails",response)
                    self.GetFinacleClientDetailsResponse(responeDataArr: response)
                    dispatchGroup.leave()
                }
                
                dispatchGroup.enter()
                GetKYCAPICalling() { (response) in
                    print("GetDropDownDatasForKYCRegistered",response)
                    self.GetKYCResponse(responeDataArr: response)
                    dispatchGroup.leave()
                }
                dispatchGroup.enter()
                GetNationalityAPICalling() { (response) in
                    print("Nationalities",response)
                    self.GetNationalResponse(responeDataArr: [response])
                    dispatchGroup.leave()
                }
              //   dispatchGroup.wait()
    }
    override func viewDidLayoutSubviews() {
        self.dateOfBirthBtn.set_View_Border(viewName: self.dateOfBirthBtn, borderColor: .gray, borderWidth: 1, corner: 5)
        self.genderBtn.set_View_Border(viewName: self.genderBtn, borderColor: .gray, borderWidth: 1, corner: 5)
        self.cityBtn.set_View_Border(viewName: self.cityBtn, borderColor: .gray, borderWidth: 1, corner: 5)
        self.stateBtn.set_View_Border(viewName: self.stateBtn, borderColor: .gray, borderWidth: 1, corner: 5)
        self.marreidStatusBtn.set_View_Border(viewName: self.marreidStatusBtn, borderColor: .gray, borderWidth: 1, corner: 5)
        self.nationalBtn.set_View_Border(viewName: self.nationalBtn, borderColor: .gray, borderWidth: 1, corner: 5)
        self.countryBtn.set_View_Border(viewName: self.countryBtn, borderColor: .gray, borderWidth: 1, corner: 5)
        
        self.grossAnnualBtn.set_View_Border(viewName: self.grossAnnualBtn, borderColor: .gray, borderWidth: 1, corner: 5)
        self.wealthSourceBtn.set_View_Border(viewName: self.wealthSourceBtn, borderColor: .gray, borderWidth: 1, corner: 5)
        self.politicalExposedBtn.set_View_Border(viewName: self.politicalExposedBtn, borderColor: .gray, borderWidth: 1, corner: 5)
        self.occupationBtn.set_View_Border(viewName: self.occupationBtn, borderColor: .gray, borderWidth: 1, corner: 5)
         self.birthCountryBtn.set_View_Border(viewName: self.birthCountryBtn, borderColor: .gray, borderWidth: 1, corner: 5)
         self.addressTypeBtn.set_View_Border(viewName: self.addressTypeBtn, borderColor: .gray, borderWidth: 1, corner: 5)
         self.dobBtn.set_View_Border(viewName: self.dobBtn, borderColor: .gray, borderWidth: 1, corner: 5)
        
    
    }
    func GetFinacleClientDetailsAPICalling(completion: @escaping(_ result: [String:Any]) -> Void) {

        let identifier = UUID()
        let testString = "\(identifier)|BOBWealth"
        let json = ["RequestBody":["pInfinityID":"069409856"],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
        let jsonString1 = json.jsonDic
        let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
        let encToken = try! testString.aesEncrypt()
        let enc = try! str.aesEncrypt()
      //  self.start_Loader()
        APIManager.shareInstance.AuthenticationRequest(method: "Comman/GetFinacleClientDetails", TPA: encToken, parameter: enc){
            (netResponse) -> (Void) in
            completion(netResponse.responseDict as! [String : Any] )

        }
       }
        
    func GetFinacleClientDetailsResponse(responeDataArr : [String :Any]) {
         print(responeDataArr)
        DispatchQueue.main.async {
        self.panNoTxt.text = responeDataArr["PAN"] as? String ?? ""
        self.nameTxt.text = responeDataArr["Name"] as? String ?? ""
        self.dateOfBirthBtn.setTitle(responeDataArr["BirthDt"] as? String ?? "", for: .normal)
        
        self.forHNmaeTxt.text = responeDataArr["FatherOrHusbandName"] as? String ?? ""
        self.motherMaidenTxt.text = responeDataArr["MotherName"] as? String ?? ""
        self.nationalBtn.setTitle(responeDataArr["Nationality"] as? String ?? "", for: .normal)
        self.genderBtn.setTitle(responeDataArr["Gender"] as? String ?? "" , for: .normal)
        self.marreidStatusBtn.setTitle(responeDataArr["MaritalStatus"] as? String ?? "" , for: .normal)
        self.emailTxt.text = responeDataArr["Email"] as? String ?? ""
        self.mobileTxt.text = responeDataArr["MobNo"] as? String  ?? ""
        self.addressTypeBtn.setTitle(responeDataArr["AddressType"] as? String ?? "", for: .normal)
        self.addressLine1Txt.text = responeDataArr["MAddrLine1"] as? String ?? ""
        self.addressLine2Txt.text = responeDataArr["MAddrLine2"] as? String ?? ""
        self.addressLine3Txt.text = responeDataArr["MAddrLine3"] as? String ?? ""
        self.cityBtn.setTitle(responeDataArr["MCity"] as? String ?? "", for: .normal)
        self.stateBtn.setTitle(responeDataArr["MState"] as? String ?? "", for: .normal)
        self.countryBtn.setTitle(responeDataArr["MCountry"] as? String ?? "", for: .normal)
        self.pinTxt.text = responeDataArr["MPostalCode"] as? String ?? ""
        
        self.birthPlaceTxt.text = responeDataArr["BirthPlace"] as? String ?? ""
        self.birthCountryBtn.setTitle(responeDataArr["BirthCountry"] as? String ?? "", for: .normal)
        self.occupationBtn.setTitle(responeDataArr["occupationcode"] as? String ?? "", for: .normal)
        self.grossAnnualBtn.setTitle(responeDataArr["grossannualincome"] as? String  ?? "", for: .normal)
        self.politicalExposedBtn.setTitle(responeDataArr["PoliticallyExposed"] as? String  ?? "", for: .normal)
        self.wealthSourceBtn.setTitle(responeDataArr["WealthSource"] as? String  ?? "", for: .normal)
        self.currentNetTxt.text = responeDataArr["EstimatedFinancialGrowth"] as? String  ?? ""
        self.dateOfBirthBtn.setTitle(responeDataArr["BirthDt"] as? String  ?? "", for: .normal)
        self.nameNomineeTxt.text = responeDataArr[""] as? String ?? ""
        self.relationshipTxt.text = responeDataArr[""] as? String ?? ""
        self.nomineeShareTxt.text = responeDataArr[""] as? String ?? ""
        self.guardianNameTxt.text = responeDataArr[""] as? String ?? ""
        self.address1Txt.text = responeDataArr[""] as? String ?? ""
        self.address2Txt.text = responeDataArr[""] as? String ?? ""
           // self.GetKYCAPICalling()
        }
       
    }
    func GetKYCAPICalling(completion: @escaping(_ result: [String:Any]) -> Void) {
        let identifier = UUID()
               let testString = "\(identifier)|BOBWealth"
               let json = ["Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
               let jsonString1 = json.jsonDic
               let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
               let encToken = try! testString.aesEncrypt()
               let enc = try! str.aesEncrypt()
            //   self.start_Loader()
               APIManager.shareInstance.AuthenticationRequest(method: "Comman/GetDropDownDatasForKYCRegistered", TPA: encToken, parameter: enc){
                   (netResponse) -> (Void) in
                completion(netResponse.responseDict as! [String : Any])
//                   if(netResponse.statusCode == 200){
//                       self.stop_Loader()
//                    //print(netResponse.responseDict as Any)
//                    self.GetKYCResponse(responeDataArr : netResponse.responseDict as! [String : Any] )
//                   }
//                   else  {
//                       self.stop_Loader()
//                   }
               }
    }
    func GetKYCResponse(responeDataArr : [String :Any]) {
        
        print(responeDataArr["State"] as! [[String : Any]])
        self.stateDataArr = responeDataArr["State"] as! [[String : Any]]
  
        self.cityDataArr = responeDataArr["City"] as! [[String : Any]]
        self.genderDataArr = responeDataArr["Gender"] as! [[String : Any]]
        self.AddressTypeDataArr = responeDataArr["AddressType"] as! [[String : Any]]
        self.countryDataArr = responeDataArr["Country"]  as! [[String : Any]]
        self.MaritalStatusDataArr = responeDataArr["MaritalStatus"]  as! [[String : Any]]
        
        self.OccupationDataArr = responeDataArr["Occupation"] as! [[String : Any]]
        self.SourceOFWealthDataArr = responeDataArr["SourceOFWealth"]  as! [[String : Any]]
        
        self.GrossAnnIncomeDataArr = responeDataArr["GrossAnnIncome"]  as! [[String : Any]]
    
        self.TitleDataArr = responeDataArr["Title"]  as! [[String : Any]]
        self.PoliticalFigureDataArr = responeDataArr["PoliticalFigure"]  as! [[String : Any]]
        DispatchQueue.main.async {
     //   self.GetNationalityAPICalling()
        }
    }
    
     func GetNationalityAPICalling(completion: @escaping(_ result: [String:Any]) -> Void) {
       
        let identifier = UUID()
               let testString = "\(identifier)|BOBWealth"
               let json = ["Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
               let jsonString1 = json.jsonDic
               let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
               let encToken = try! testString.aesEncrypt()
               let enc = try! str.aesEncrypt()
             //  self.start_Loader()
               APIManager.shareInstance.AuthenticationRequest(method: "Nationality/Nationalities", TPA: encToken, parameter: enc){
                   (netResponse) -> (Void) in
            //    completion(netResponse.responseDict as? [String : Any] ?? "r" )
//                   if(netResponse.statusCode == 200){
//                       self.stop_Loader()
//                    print(netResponse.responseDict as Any)
//     self.GetNationalResponse(responeDataArr : netResponse.responseDict as! [[String : Any]] )
//                   }
//                   else  {
//                       self.stop_Loader()
//                   }
               }
       }
    func GetNationalResponse(responeDataArr : [[String :Any]]) {
      self.nationalDataArr = responeDataArr
    }
    @IBAction func nextAct(_ sender: Any) {
        
        
        
//        let dic : [String : String] = ["AddressType": self.addressTypeBtn.,"BirthCountry":"\(birthCountryBtn.t)","BirthDt":"\(self.dateOfBirthBtn)","birthplace":"\()","clientip":"","clientstatus":"","clienttaxid":"","constitutioncode":"","custstatus":"","dateofbirth1":"3/23/2021","dateofbirth2":"","dateofbirth3":"","dateofincorporation":"","defaultaddrtype":"","email":self.emailTxt.text,"ErrorMessage":"","EstimatedFinancialGrowth":"10","FatherOrHusbandName":forHNmaeTxt.text,"FirstName":self.nameTxt.text,"Gender":self.genderBtn.setTitle,"IsApplyNominee":"true","IsNRE":"","KYCDescription":"","KYCVerified":"false","LastName":"","MAddrLine1":"GFWTIF%XZS%YT\\JW%H89%L%GQTHP","MAddrLine2":"GPH%GFSIWF%JFXY","MAddrLine3":"xbxb","MCity":"2071","MCountry":"243","MPostalCode":"400051","MState":"360","MaritalStatus":self.marreidStatusBtn,"MiddleName":"","MobNo":self.mobileTxt.text,"MotherName":self.motherMaidenTxt.text,"Name":"SIMRANJIT SINGH","Nationality":self.nationalBtn,"NomineeAddress1":"qwerty","NomineeIsMinor1":"true","NomineeIsMinor2":"false","NomineeIsMinor3":"false","NomineeName1":self.nameNomineeTxt.text,"NomineeRelationship1":"sis","NomineeShare1":"10","NomineeShare2":"0.0","NomineeShare3":"0.0","Occupation":"2","PAN":self.panNoTxt.text,"PassportNum":"","Pin":"400051","PoliticallyExposed":"Yes","Title":"MR.","UCC":"","WealthSource":"Business Income","email1":"","grossannualincome":"1Lac - 3Lacs","isofflineclient":"0","occupation_code":"","pInfinityID":"069409856","pan_no1":""]
//        
//        
//        
//        GobleValue.setupRequestDataArray
        let vc = self.storyboard?.instantiateViewController(identifier: "TnCVC") as! TnCVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func cancelAct(_ sender: Any) {
         
           self.navigationController?.popToRootViewController(animated: true)
       }
       @IBAction func nationalityForFieldAct(_ sender: Any) {
               nationalBtn.isSelected = true
              
              let vc = PickerVC()
              vc.delegate       =   self
              vc.view.center    = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
              vc.view.frame     = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
              for arr in nationalDataArr {
            // vc.pickerArray.append(arr["ConutryName"]  )
              }
             
              self.addChild(vc)
              self.view.addSubview(vc.view)
              vc.didMove(toParent: self)
             // self.dateField.resignFirstResponder()
          }
    @IBAction func conutryForFieldAct(_ sender: Any) {
         countryBtn.isSelected = true
        
        let vc = PickerVC()
        vc.delegate       =   self
        vc.view.center    = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        vc.view.frame     = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
        for arr in countryDataArr {
            vc.pickerArray.append(arr["Name"] as! String)
        }
       
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
       // self.dateField.resignFirstResponder()
    }
    @IBAction func birthCountryForFieldAct(_ sender: Any) {
            birthCountryBtn.isSelected = true
           
           let vc = PickerVC()
           vc.delegate       =   self
           vc.view.center    = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
           vc.view.frame     = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
           for arr in countryDataArr {
               vc.pickerArray.append(arr["Name"] as! String)
           }
          
           self.addChild(vc)
           self.view.addSubview(vc.view)
           vc.didMove(toParent: self)
          // self.dateField.resignFirstResponder()
       }
    @IBAction func addressTypeForFieldAct(_ sender: Any) {
         addressTypeBtn.isSelected = true
           let vc = PickerVC()
           vc.delegate       =   self
           vc.view.center    = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
           vc.view.frame     = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
           for arr in AddressTypeDataArr {
               vc.pickerArray.append(arr["Name"] as! String)
           }
          
           self.addChild(vc)
           self.view.addSubview(vc.view)
           vc.didMove(toParent: self)
          // self.dateField.resignFirstResponder()
       }
    @IBAction func genderForFieldAct(_ sender: Any) {
        let vc = PickerVC()
        vc.delegate       = self
        vc.view.center    = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        vc.view.frame     = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
        genderBtn.isSelected = true
        for arr in genderDataArr {
            vc.pickerArray.append(arr["Name"] as! String)
        }
       
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
       // self.dateField.resignFirstResponder()
    }
    @IBAction func StateForFieldAct(_ sender: Any) {
        stateBtn.isSelected = true
        let vc = PickerVC()
        vc.delegate       =   self
        vc.view.center    = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        vc.view.frame     = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
        for arr in stateDataArr {
            vc.pickerArray.append(arr["Name"] as! String)
        }
       
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
       // self.dateField.resignFirstResponder()
    }
    @IBAction func cityForFieldAct(_ sender: Any) {
        cityBtn.isSelected = true
        let vc = PickerVC()
        vc.delegate       =   self
        vc.view.center    = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        vc.view.frame     = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
        for arr in cityDataArr {
            vc.pickerArray.append(arr["Name"] as! String)
        }
       
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
       // self.dateField.resignFirstResponder()
    }
    @IBAction func marriedForFieldAct(_ sender: Any) {
        marreidStatusBtn.isSelected = true
           let vc = PickerVC()
           vc.delegate       =   self
           vc.view.center    = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
           vc.view.frame     = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
           for arr in MaritalStatusDataArr {
               vc.pickerArray.append(arr["Name"] as! String)
           }
          
           self.addChild(vc)
           self.view.addSubview(vc.view)
           vc.didMove(toParent: self)
          // self.dateField.resignFirstResponder()
       }
    @IBAction func occuForFieldAct(_ sender: Any) {
        occupationBtn.isSelected = true
              let vc = PickerVC()
              vc.delegate       =   self
              vc.view.center    = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
              vc.view.frame     = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
              for arr in OccupationDataArr {
                  vc.pickerArray.append(arr["Name"] as! String)
              }
             
              self.addChild(vc)
              self.view.addSubview(vc.view)
              vc.didMove(toParent: self)
             // self.dateField.resignFirstResponder()
          }
    @IBAction func WSourceForFieldAct(_ sender: Any) {
         wealthSourceBtn.isSelected = true
           let vc = PickerVC()
           vc.delegate       =   self
           vc.view.center    = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
           vc.view.frame     = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
           for arr in SourceOFWealthDataArr {
               vc.pickerArray.append(arr["Name"] as! String)
           }
          
           self.addChild(vc)
           self.view.addSubview(vc.view)
           vc.didMove(toParent: self)
          // self.dateField.resignFirstResponder()
       }
    @IBAction func politicalForFieldAct(_ sender: Any) {
         politicalExposedBtn.isSelected = true
              let vc = PickerVC()
              vc.delegate       =   self
              vc.view.center    = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
              vc.view.frame     = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
              for arr in PoliticalFigureDataArr {
                  vc.pickerArray.append(arr["Name"] as! String)
              }
             
              self.addChild(vc)
              self.view.addSubview(vc.view)
              vc.didMove(toParent: self)
             // self.dateField.resignFirstResponder()
          }
    @IBAction func grossForFieldAct(_ sender: Any) {
         grossAnnualBtn.isSelected = true
                 let vc = PickerVC()
                 vc.delegate       =   self
                 vc.view.center    = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
                 vc.view.frame     = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
                 for arr in GrossAnnIncomeDataArr {
                     vc.pickerArray.append(arr["Name"] as! String)
                 }
                
                 self.addChild(vc)
                 self.view.addSubview(vc.view)
                 vc.didMove(toParent: self)
                // self.dateField.resignFirstResponder()
             }

    @IBAction func DateFieldAction(_ sender: Any) {
        dateOfBirthBtn.isSelected = true
        let vc = DateVC()
        vc.delegate       =   self
        vc.view.center    = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        vc.view.frame     = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
      //  self.dateOfBirthBtn.resignFirstResponder()
    }
    
    @IBAction func dobBtnAction(_ sender: Any) {
         dobBtn.isSelected = true
        let vc = DateVC()
        vc.delegate       =   self
        vc.view.center    = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        vc.view.frame     = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
      //  self.dateOfBirthBtn.resignFirstResponder()
    }
// MARK: - Delegate Methods
func setDateVal(date: String) {
    if dateOfBirthBtn.isSelected{
    dateOfBirthBtn.setTitle(date, for: .normal)
         dateOfBirthBtn.isSelected = false
    }else  if dobBtn.isSelected{
       dobBtn.setTitle(date, for: .normal)
         dateOfBirthBtn.isSelected = false
       }
  }
  func setPickerVal(pickVal: String) {
    if cityBtn.isSelected {
        cityBtn.setTitle(pickVal, for: .normal)
        cityBtn.isSelected = false
     }
    if stateBtn.isSelected {
       stateBtn.setTitle(pickVal, for: .normal)
        stateBtn.isSelected = false
     }
    if countryBtn.isSelected {
           countryBtn.setTitle(pickVal, for: .normal)
        countryBtn.isSelected = false
        }
    if genderBtn.isSelected {
          genderBtn.setTitle(pickVal, for: .normal)
        genderBtn.isSelected = false
        }
    if addressTypeBtn.isSelected {
             addressTypeBtn.setTitle(pickVal, for: .normal)
        addressTypeBtn.isSelected = false
           }
    if marreidStatusBtn.isSelected {
                marreidStatusBtn.setTitle(pickVal, for: .normal)
        marreidStatusBtn.isSelected = false
              }
    if occupationBtn.isSelected {
      occupationBtn.setTitle(pickVal, for: .normal)
        occupationBtn.isSelected = false
    }
    if wealthSourceBtn.isSelected {
      wealthSourceBtn.setTitle(pickVal, for: .normal)
        wealthSourceBtn.isSelected = false
    }
    if grossAnnualBtn.isSelected {
      grossAnnualBtn.setTitle(pickVal, for: .normal)
        grossAnnualBtn.isSelected = false
    }
    if politicalExposedBtn.isSelected {
         politicalExposedBtn.setTitle(pickVal, for: .normal)
        politicalExposedBtn.isSelected = false
       }
    if birthCountryBtn.isSelected {
      birthCountryBtn.setTitle(pickVal, for: .normal)
        birthCountryBtn.isSelected = false
    }
    if nationalBtn.isSelected {
      nationalBtn.setTitle(pickVal, for: .normal)
        nationalBtn.isSelected = false
    }
    }
    
}
