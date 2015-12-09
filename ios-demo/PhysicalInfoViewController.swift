//
//  PhysicalInfoViewController.swift
//  ios-demo
//
//  Created by Scott Weidenkopf on 12/8/15.
//  Copyright © 2015 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class PhysicalInfoViewController: UIViewController, UIPickerViewDataSource {

    // MARK: - Properties
    @IBOutlet weak var genderPicker: UIPickerView!
    let genders = ["Male", "Female"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int{
            return 2;
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return genders[row];
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
