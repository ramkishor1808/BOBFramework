//
//  BOBInit.swift
//  BOBWealth
//
//  Created by Venkat Naresh on 20/05/21.
//

import UIKit
import MMDrawerController


public class BOBInit: NSObject {
    
    public static func pushBOBWealthFramework() {
    
        let bundlePath = Bundle(identifier: "com.ebix.com.BOBWealthFramework")?.resourcePath
        BOBAppdelegate.shared.resourceBundle = Bundle.init(path: bundlePath!)
        BOBAppdelegate.shared.mainStoryboard = UIStoryboard(name: "Main", bundle: BOBAppdelegate.shared.resourceBundle)
        let centerViewController =  BOBAppdelegate.shared.mainStoryboard!.instantiateViewController(withIdentifier: "DashboardNav") as! UINavigationController


            let leftSideNav =  BOBAppdelegate.shared.mainStoryboard!.instantiateViewController(withIdentifier: "LeftSideNav") as! UINavigationController

        BOBAppdelegate.shared.centerContainer = MMDrawerController(center: centerViewController, leftDrawerViewController: leftSideNav,rightDrawerViewController:nil)
        BOBAppdelegate.shared.centerContainer!.setMaximumLeftDrawerWidth(UIScreen.main.bounds.width, animated: true, completion: nil)

        BOBAppdelegate.shared.centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningNavigationBar;

        BOBAppdelegate.shared.centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView;

        UIApplication.shared.windows.first?.rootViewController = BOBAppdelegate.shared.centerContainer
        UIApplication.shared.windows.first?.makeKeyAndVisible()

    }
        
}


class BOBAppdelegate{
    
    static let shared = BOBAppdelegate()
    var centerContainer : MMDrawerController?
    var mainStoryboard : UIStoryboard?
    var resourceBundle: Bundle?
    init(){}
    
    func requestForLocation(){
        //Code Process
        print("BOBAppdelegate granted")
    }
    
}
