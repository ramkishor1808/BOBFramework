//
//  LeftSideViewController.swift
//  BOB
//
//  Created by Anushree on 2/18/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import UIKit
import MMDrawerController
import FontAwesome
@available(iOS 13.0, *)
class LeftSideViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var menuItems:[String] = ["Dashboard","Portfolio Analysis","Reports","Transact","Order Status","Demat Holding","Stop SIP","Set Up"];
      @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelMenu: UIButton!
   // var cancelMenu = UIBarButtonItem?()
   
    @IBAction func cancelBtn(_ sender: Any) {
        if #available(iOS 13.0, *) {
//                       let appdelegate = UIApplication.shared.delegate as! AppDelegate
//
            BOBAppdelegate.shared.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
            BOBAppdelegate.shared.centerContainer!.closeDrawer(animated: true, completion: nil)
                   } else {
            }
    }
    
    @objc func click_MenuBar_Btn(){
        print("Abcd")
        if #available(iOS 13.0, *) {
//                              let appdelegate = UIApplication.shared.delegate as! AppDelegate
//
                              BOBAppdelegate.shared.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
            BOBAppdelegate.shared.centerContainer!.closeDrawer(animated: true, completion: nil)
                          } else {
                   }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)

        print("\(#function) --- section = \(indexPath.section), row = \(indexPath.row)")
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25.0)
        cell.textLabel?.text = menuItems[indexPath.row]

        return cell
    }

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var mycell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as MyCustomTableViewCell
//        mycell.menuItemLabel.text = menuItems[indexPath.row]
//        return mycell;
//        }
//    }
//
//var menuItems:[String] = ["Dashboard","Report"];
//    override func viewWillAppear(_ animated: Bool) {
//
//        self.navigationController?.view.layoutSubviews()
//    }
    
override func viewDidLoad() {
    self.navigationController?.navigationBar.isHidden  =  true
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
    tableView.delegate = self
    tableView.dataSource = self
    tableView.allowsSelection = true
   

    // Do any additional setup after loading the view.
}
override func didReceiveMemoryWarning() {

// Dispose of any resources that can be recreated.
}
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//{
//return menuItems.count;
//}

//@available(iOS 13.0, *)
//@available(iOS 13.0, *)
//@available(iOS 13.0, *)
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("anu")
    switch (indexPath.row) {
        case 0:
    
        //let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let centerViewController = BOBAppdelegate.shared.mainStoryboard!.instantiateViewController(withIdentifier: "DashboardNav") as! UINavigationController
       if #available(iOS 13.0, *) {
           let appDelegate = BOBAppdelegate.shared
        appDelegate.centerContainer!.centerViewController = centerViewController
        appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
        appDelegate.centerContainer!.open(MMDrawerSide.left, animated: true, completion: nil)
       } else {
           // Fallback on earlier versions
       }
        
        
        break;
        case 1:
     
               let centerViewController = BOBAppdelegate.shared.mainStoryboard!.instantiateViewController(withIdentifier: "GraphsNav") as! UINavigationController
       if #available(iOS 13.0, *) {
        let appDelegate = BOBAppdelegate.shared
                  appDelegate.centerContainer!.centerViewController = centerViewController
                  appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                  appDelegate.centerContainer!.open(MMDrawerSide.left, animated: true, completion: nil)
                 } else {
                     // Fallback on earlier versions
                 }
                  
        break;
        
        case 2:
       
                 let centerViewController = BOBAppdelegate.shared.mainStoryboard!.instantiateViewController(withIdentifier: "SearchNav") as! UINavigationController
         if #available(iOS 13.0, *) {
            let appDelegate = BOBAppdelegate.shared
           appDelegate.centerContainer!.centerViewController = centerViewController
           appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
           appDelegate.centerContainer!.open(MMDrawerSide.left, animated: true, completion: nil)
          } else {
              // Fallback on earlier versions
          }
           
          break;
         
        case 3:
         
                 let centerViewController = BOBAppdelegate.shared.mainStoryboard!.instantiateViewController(withIdentifier: "TranNav") as! UINavigationController
       
           if #available(iOS 13.0, *) {
                let appDelegate = BOBAppdelegate.shared
             appDelegate.centerContainer!.centerViewController = centerViewController
             appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
             appDelegate.centerContainer!.open(MMDrawerSide.left, animated: true, completion: nil)
            } else {
                // Fallback on earlier versions
            }
             
          break;
         
    case 4:
    
             let centerViewController = BOBAppdelegate.shared.mainStoryboard!.instantiateViewController(withIdentifier: "orderNav") as! UINavigationController

       if #available(iOS 13.0, *) {
           let appDelegate = BOBAppdelegate.shared
         appDelegate.centerContainer!.centerViewController = centerViewController
         appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
         appDelegate.centerContainer!.open(MMDrawerSide.left, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
         
      break;
      
    case 5:

   //  let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

             let centerViewController = BOBAppdelegate.shared.mainStoryboard!.instantiateViewController(withIdentifier: "DemandNav") as! UINavigationController
     if #available(iOS 13.0, *) {
        // let appDelegate = UIApplication.shared.delegate as! AppDelegate
     } else {
         // Fallback on earlier versions
     }

      if #available(iOS 13.0, *) {
        let appDelegate = BOBAppdelegate.shared
         appDelegate.centerContainer!.centerViewController = centerViewController
         appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
         appDelegate.centerContainer!.open(MMDrawerSide.left, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
         
      break;
        case 6:
       
                let centerViewController = BOBAppdelegate.shared.mainStoryboard!.instantiateViewController(withIdentifier: "SIPNav") as! UINavigationController

          if #available(iOS 13.0, *) {
            let appDelegate = BOBAppdelegate.shared
            appDelegate.centerContainer!.centerViewController = centerViewController
            appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
            appDelegate.centerContainer!.open(MMDrawerSide.left, animated: true, completion: nil)
           } else {
               // Fallback on earlier versions
           }
            
         break;
        
        case 7:
      //  let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let centerViewController = BOBAppdelegate.shared.mainStoryboard!.instantiateViewController(withIdentifier: "setUpNav") as! UINavigationController

          if #available(iOS 13.0, *) {
            let appDelegate = BOBAppdelegate.shared
            appDelegate.centerContainer!.centerViewController = centerViewController
            appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
            appDelegate.centerContainer!.open(MMDrawerSide.left, animated: true, completion: nil)
           } else {
               // Fallback on earlier versions
           }
            
         break;
      default:
          print(menuItems[indexPath.row])
        //println("\(menuItems[indexPath.row]) is selected")
      }
    }
    
//   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//    do {
//    switch (indexPath.row) {
//    case 0:
////    var centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as ViewController
////    var centerNavController = UINavigationController(rootViewController: centerViewController)
//    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//           let centerViewController = mainStoryboard.instantiateViewController(withIdentifier: "DashboardNav") as! UINavigationController
//   if #available(iOS 13.0, *) {
//       let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    appDelegate.centerContainer!.centerViewController = centerViewController
//    appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
//    appDelegate.centerContainer!.open(MMDrawerSide.left, animated: true, completion: nil)
//   } else {
//       // Fallback on earlier versions
//   }
//    
//    
//    break;
//    case 1:
//   let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//           let centerViewController = mainStoryboard.instantiateViewController(withIdentifier: "GraphsNav") as! UINavigationController
//   if #available(iOS 13.0, *) {
//                 let appDelegate = UIApplication.shared.delegate as! AppDelegate
//              appDelegate.centerContainer!.centerViewController = centerViewController
//              appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
//              appDelegate.centerContainer!.open(MMDrawerSide.left, animated: true, completion: nil)
//             } else {
//                 // Fallback on earlier versions
//             }
//              
//    break;
//    
//    case 2:
//     let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//             let centerViewController = mainStoryboard.instantiateViewController(withIdentifier: "GraphsNav") as! UINavigationController
//     if #available(iOS 13.0, *) {
//          let appDelegate = UIApplication.shared.delegate as! AppDelegate
//       appDelegate.centerContainer!.centerViewController = centerViewController
//       appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
//       appDelegate.centerContainer!.open(MMDrawerSide.left, animated: true, completion: nil)
//      } else {
//          // Fallback on earlier versions
//      }
//       
//      break;
//     
//    case 3:
//     let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//             let centerViewController = mainStoryboard.instantiateViewController(withIdentifier: "DemandNav") as! UINavigationController
//   
//       if #available(iOS 13.0, *) {
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//         appDelegate.centerContainer!.centerViewController = centerViewController
//         appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
//         appDelegate.centerContainer!.open(MMDrawerSide.left, animated: true, completion: nil)
//        } else {
//            // Fallback on earlier versions
//        }
//         
//      break;
//     
//case 4:
// let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//         let centerViewController = mainStoryboard.instantiateViewController(withIdentifier: "DashboardNav") as! UINavigationController
//
//   if #available(iOS 13.0, *) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//     appDelegate.centerContainer!.centerViewController = centerViewController
//     appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
//     appDelegate.centerContainer!.open(MMDrawerSide.left, animated: true, completion: nil)
//    } else {
//        // Fallback on earlier versions
//    }
//     
//  break;
//  
//case 5:
// let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//         let centerViewController = mainStoryboard.instantiateViewController(withIdentifier: "DashboardNav") as! UINavigationController
// if #available(iOS 13.0, *) {
//     let appDelegate = UIApplication.shared.delegate as! AppDelegate
// } else {
//     // Fallback on earlier versions
// }
//  
//  if #available(iOS 13.0, *) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//     appDelegate.centerContainer!.centerViewController = centerViewController
//     appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
//     appDelegate.centerContainer!.open(MMDrawerSide.left, animated: true, completion: nil)
//    } else {
//        // Fallback on earlier versions
//    }
//     
//  break;
//  default:
//      print(menuItems[indexPath.row])
////  println("\(menuItems[indexPath.row]) is selected");
//
//  }
//    }
//
//    }
}
