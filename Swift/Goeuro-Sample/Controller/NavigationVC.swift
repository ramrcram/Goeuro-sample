//
//  NavigationVC.swift
//  Goeuro-Sample
//
//  Created by Ramesh on 20/02/17.
//  Copyright © 2017 Ramesh. All rights reserved.
//

import UIKit
import SwiftMessages

class NavigationVC: UINavigationController,UINavigationBarDelegate {

    override func viewDidLoad() {
        if !AppHelper.isInternetAvailable() {
         SwiftMessages.show(view:AppHelper.showConnectionMessage())
        }
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func addTapped() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
