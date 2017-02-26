//
//  TabViewController.swift
//  Goeuro-Sample
//
//  Created by Ramesh on 23/02/17.
//  Copyright © 2017 Ramesh. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        self.addNavigationItems()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    func addNavigationItems() {
        //Set Close Button
        let offerButton = UIButton()
        offerButton.setImage(UIImage(named: "offericon"), for: UIControlState())
        offerButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        offerButton.addTarget(self, action:#selector(offerTapped) , for: .touchUpInside)
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: offerButton), animated: true);
        
        UIView.animate(withDuration: 0.5, delay: 0.3,
                       options: [.curveEaseOut, .autoreverse], animations: {
                        offerButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }, completion: nil)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationItem.title = "Goeuro"
    }
    
    func offerTapped() {
        let offerController = self.storyboard?.instantiateViewController(withIdentifier: "goeuroOfferVC") as! OfferDetailsVC
        self.present(offerController, animated: true, completion: nil)
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
