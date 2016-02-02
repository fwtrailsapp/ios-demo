//
//  LoginViewController.swift
//  ios-demo
//
//  Created by Scott Weidenkopf on 2/1/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func didPressLogin() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let leftViewController = mainStoryboard.instantiateViewControllerWithIdentifier("DrawerMenuViewController") as! DrawerMenuViewController
        let centerViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ActivityViewController") as! ActivityViewController
        let navController = mainStoryboard.instantiateViewControllerWithIdentifier("UINavigationController")
        
        appDelegate.centerContainer!.centerViewController = centerViewController
        appDelegate.centerContainer!.leftDrawerViewController = leftViewController
        navController.addChildViewController(appDelegate.centerContainer!)
        
        appDelegate.window!.rootViewController = navController
        appDelegate.window!.makeKeyAndVisible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
