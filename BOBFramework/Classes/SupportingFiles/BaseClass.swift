//
//  LoaderSingleton.swift
//  iMenu
//
//  Created by Mayank on 23/08/18.
//  Copyright © 2018 AppyPie. All rights reserved.
//

import Foundation
import UIKit
import CoreData

import MMDrawerController


@available(iOS 13.0, *)
@available(iOS 13.0, *)
class BaseClass: UIViewController {
 // weak var customView : CustomView?
    var commonView              =   UIView()
    var lodingView              =   UIView()
    var spinner                 =   UIActivityIndicatorView()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createLoader()
        
        //self.svProgressView()
    }
    func svProgressView() {
       let hudContainer = UIView()
        hudContainer.frame = CGRect(x: 0, y: 0, width:100, height: 100)
        hudContainer.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        hudContainer.backgroundColor = .clear
        self.view.addSubview(hudContainer)
      //  SVProgressHUD.ser
//        SVProgressHUD.setForegroundColor(.orange)
//        SVProgressHUD.setBackgroundColor(.black)
//        SVProgressHUD.setContainerView(hudContainer)
       // [ [SVProgressHUD setContainerView:hudContainer];
    }
   


    func setNavigationtitle(titleText : String,view: UIViewController,rightImage : String){
        view.navigationController?.navigationBar.tintColor           = UIColor.black
        view.navigationController?.navigationBar.isTranslucent       =  false
        view.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        self.addRightButton(image : rightImage,titleText: titleText,cartCount : "",userName :"")
    }
    
    // <--- Navigation Button Setup with Menu Image --->
    func addRightButton(image : String,titleText : String,cartCount : String,userName : String){
       // let image3 = UIImage(named: image)
        var frameimg = CGRect(x: 0, y: 0, width: 30, height: 30)
        if image == "menu" {
        frameimg = CGRect(x: 0, y: 0, width: 30, height: 30)
        }else{
        frameimg = CGRect(x: 0, y: 0, width: 15, height: 20)
        }
        //......
        
        
        let image1 = UIImage(named: image, in: BOBAppdelegate.shared.resourceBundle, compatibleWith: nil)
             
        let menuButton = UIButton(frame: frameimg)
             menuButton.setBackgroundImage(image1, for: .normal)
        
      
       // menuButton.setBackgroundImage(image3, for: .normal)
        
        let leftView  = UIView(frame : CGRect(x: 0 , y: 0, width: 160, height: 30))
        let cartNumber = UILabel(frame: CGRect(x: leftView.frame.size.width - 12 , y: 2, width: 10, height: 10))
        
        let cartButton = UIButton(frame: CGRect(x: leftView.frame.size.width - 35 , y: 10, width: 18, height: 18))
        let imagecart = UIImage(named: "cart", in: BOBAppdelegate.shared.resourceBundle, compatibleWith: nil)
        
        cartButton.setBackgroundImage(imagecart, for: .normal)
        
        let notiButton = UIButton(frame: CGRect(x: leftView.frame.size.width - 75 , y: 10, width: 18, height: 18))
        
        let imagenoti = UIImage(named: "notification", in: BOBAppdelegate.shared.resourceBundle, compatibleWith: nil)
        
        notiButton.setBackgroundImage(imagenoti, for: .normal)
     
        
        let profileButton = UIButton(frame: CGRect(x: leftView.frame.size.width - 115 , y: 10, width: 18, height: 18))
        
        let imageprofile = UIImage(named: "usericon", in: BOBAppdelegate.shared.resourceBundle, compatibleWith: nil)
        profileButton.setBackgroundImage(imageprofile, for: .normal)
        
     
        
        let userNameVal = UILabel(frame: CGRect(x: leftView.frame.size.width - 245 , y: 10, width: 120, height: 20))
        
        cartNumber.backgroundColor      =  .red
        cartNumber.layer.cornerRadius   =  cartNumber.frame.size.height / 2
        cartNumber.text                 =  cartCount
        userNameVal.text                =  userName
        
        leftView.addSubview(cartButton)
        leftView.addSubview(cartNumber)
        leftView.addSubview(notiButton)
        leftView.addSubview(profileButton)
       // leftView.addSubview(userNameVal)
        
        
        if image == "menu" {
            let titleLabel = UILabel(frame: CGRect(x: menuButton.frame.size.width , y: 0, width: self.view.frame.width , height: self.view.frame.height))
                       titleLabel.text = titleText
                       titleLabel.textColor = UIColor.orange
                       titleLabel.font = .boldSystemFont(ofSize: 18)
                       self.navigationItem.titleView   = titleLabel
            menuButton.addTarget(self, action: #selector(click_MenuBar_Btn), for: .touchUpInside)
            cartButton.addTarget(self, action: #selector(click_Cart_Btn), for: .touchUpInside)
            notiButton.addTarget(self, action: #selector(click_NotiBar_Btn), for: .touchUpInside)
            profileButton.addTarget(self, action: #selector(click_profile_Btn), for: .touchUpInside)
        }else{
//            let titleLabel = UILabel(frame: CGRect(x: menuButton.frame.size.width , y: 0, width: self.view.frame.width - 32, height: self.view.frame.height))
//            titleLabel.text = titleText
//            titleLabel.textColor = UIColor.black
//            titleLabel.font = .boldSystemFont(ofSize: 18)
//            self.navigationItem.titleView   = titleLabel
//            menuButton.addTarget(self, action: #selector(click_Back_Btn), for: .touchUpInside)
            let titleLabel = UILabel(frame: CGRect(x: menuButton.frame.size.width , y: 0, width: self.view.frame.width , height: self.view.frame.height))
                       titleLabel.text = titleText
                       titleLabel.textColor = UIColor.orange
                       titleLabel.font = .boldSystemFont(ofSize: 18)
                       self.navigationItem.titleView   = titleLabel
            menuButton.addTarget(self, action: #selector(click_Back_Btn), for: .touchUpInside)
            cartButton.addTarget(self, action: #selector(click_Cart_Btn), for: .touchUpInside)
            notiButton.addTarget(self, action: #selector(click_NotiBar_Btn), for: .touchUpInside)
            profileButton.addTarget(self, action: #selector(click_profile_Btn), for: .touchUpInside)
            
        }
        menuButton.showsTouchWhenHighlighted = true
        let customBarIte = UIBarButtonItem(customView: menuButton)
        let customLeftBarIte = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem = customBarIte;
        self.navigationItem.rightBarButtonItem = customLeftBarIte;
    }
    
    @objc func click_MenuBar_Btn(){
        
        
        print("Abcd")
         let appDelegate = BOBAppdelegate.shared

        appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true){ (isCompleted) in
                  if appDelegate.centerContainer?.openSide == MMDrawerSide.none
                  {
                       print("drawer close")
                  }
                  else if appDelegate.centerContainer?.openSide == MMDrawerSide.right
                  {
                       print("drawer open")
                  }
           }
       
        appDelegate.centerContainer!.setMaximumLeftDrawerWidth(self.view.frame.size.width, animated: true, completion: nil)
        appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
        appDelegate.centerContainer!.open(MMDrawerSide.left, animated: true, completion: nil)
        
        
    }
    @objc func click_Cart_Btn(){
        print("Abcd")
        let vc = self.storyboard?.instantiateViewController(identifier: "InvertmentCartVC") as! InvertmentCartVC
            //   vc.index = indexPath.row
               self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func click_NotiBar_Btn(sender:UIButton){
//        let bundlePath = Bundle(identifier: "IanBellApps.myNewFramework")?.resourcePath
//        let resourceBundle = Bundle.init(path: bundlePath!)
        let VC = NotificationView(nibName: "NotificationView", bundle: BOBAppdelegate.shared.resourceBundle)
        
        VC.showPopover(sourceView: sender) {
                          print("CustomPopOverView.show.completion")
                      }
    
    }
    @objc func click_profile_Btn(sender:UIButton){
        print("Abcd")
        let VC = CustomView(nibName: "CustomView", bundle: BOBAppdelegate.shared.resourceBundle)
        VC.showPopover(sourceView: sender) {
        print("CustomPopOverView.show.completion")
        }
    }
    
    @objc func click_Back_Btn(){
        print("Abcd")
        self.navigationController?.popViewController(animated: true)
    }
    func createLoader(){
        spinner.style  =   UIActivityIndicatorView.Style.whiteLarge
        spinner.center      =   self.view.center
        spinner.color       =   .white
        spinner.hidesWhenStopped    =   true
        commonView.frame    =   CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        commonView.backgroundColor  =   UIColor.black
        self.view.addSubview(commonView)
        self.view.addSubview(spinner)
        commonView.isUserInteractionEnabled     =   false
        commonView.alpha                        =   0;
    }
    
    func start_Loader() {
        commonView.alpha    =   0.5
        UIApplication.shared.beginIgnoringInteractionEvents()
        spinner.startAnimating()
    }
    
    func stop_Loader(){
        DispatchQueue.main.async {
        UIApplication.shared.endIgnoringInteractionEvents()
            self.commonView.alpha    =   0
            self.spinner.stopAnimating()
        }
    }
    
//    func saveDatabaseIntialization(tableName : String)-> NSManagedObject{
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
//        let entity = NSEntityDescription.entity(forEntityName: tableName, in: context)
//        let newUser = NSManagedObject(entity: entity!, insertInto: context)
//        return newUser
//    }
//    func fetchDatabaseIntialization(tableName : String)-> [NSManagedObject]{
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: tableName)
//        //request.predicate = NSPredicate(format: "age = %@", "12")
//        request.returnsObjectsAsFaults = false
//        var result  =  [NSManagedObject]()
//        do {
//            result = try context.fetch(request) as! [NSManagedObject]
//        } catch {
//            print("Failed")
//        }
//        return result
//    }
    
//    func deleteAllData(){
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: "RecentSearch")
//        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
//        do { try context.execute(DelAllReqVar) }
//        catch { print(error) }
//    }
    func setFormattedDate(dateStr: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MMM-yyyy"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        let date: Date? = dateFormatterGet.date(from: dateStr)
        print(date)
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!)
    }
    
    func setFormattedTime(dateStr: String) -> String {
        let timeformatterGet = DateFormatter()
        //timeformatter.timeZone = TimeZone.current
        timeformatterGet.dateFormat = "HH:mm:ss"
        let timeformatterPrint = DateFormatter()
        timeformatterPrint.dateFormat = "hh:mm a"
        
        let time : Date? = timeformatterGet.date(from: dateStr)
        print("Time",timeformatterPrint.string(from: time!)) // Feb 01,2018
        return timeformatterPrint.string(from: time!)
    }
    
    func timeToHours(dateString : String) -> String{
        var dateTimeString: String?
        let getdateFormatter = DateFormatter()
        getdateFormatter.dateFormat =  "HH:mm:ss"
        let date = getdateFormatter.date(from:dateString)
        let setdateFormatter = DateFormatter()
        setdateFormatter.dateFormat =  "hh:mm"
        dateTimeString = setdateFormatter.string(from:date!)
        return dateTimeString!
    }
    
}

