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
        
        let centerContainer = appDelegate.centerContainer!
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: ViewIdentifier.MAIN_STORYBOARD.rawValue, bundle: nil)

        let leftViewController = mainStoryboard.instantiateViewControllerWithIdentifier(ViewIdentifier.DRAWER_VIEW_ID.rawValue) as! DrawerMenuViewController
        
        let navController = mainStoryboard.instantiateViewControllerWithIdentifier(ViewIdentifier.NAV_CONTROLLER_ID.rawValue)
        
        centerContainer.centerViewController = navController
        centerContainer.leftDrawerViewController = leftViewController
        
        presentViewController(centerContainer, animated: true, completion: nil)
        
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
