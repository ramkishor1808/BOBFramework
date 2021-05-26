//
//  MainTabBarVC.swift
//  BookingTheShelter
//
//  Created by Mayank on 28/03/18.
//  Copyright © 2018 Sahidul. All rights reserved.
//

import UIKit
//import SCLAlertView

class MainTabBarVC: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tabBar.barTintColor = UIColor(red: 200.0/255.0, green: 84.0/255.0, blue: 42.0/255.0, alpha: 1.0)
        tabBar.unselectedItemTintColor = UIColor.black
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Selected view controller-> \(viewController) && \(tabBarController)" )
        guard  viewController.tabBarItem.tag == 5 else {
            return true
        }
        return false
    }
    private func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UINavigationController) {
        print("Selected view controller-> \(viewController) && \(tabBarController)" )
    }
    
}
