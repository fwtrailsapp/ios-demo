//
//  DraweredViewController.swift
//  ios-demo
//
//  Created by Scott Weidenkopf on 2/2/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class DraweredViewController: UIViewController, DrawerNavigable {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    func drawerBarButtonPressed() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
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
