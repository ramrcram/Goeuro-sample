//
//  BusesViewController.swift
//  Goeuro-Sample
//
//  Created by Ramesh on 14/02/17.
//  Copyright © 2017 Ramesh. All rights reserved.
//

import UIKit
import ObjectMapper

class BusesVC: UIViewController {

    var dataController:DataVC?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.getBusList()
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if segue.identifier == "buseslist"
        {
            dataController = segue.destination as? DataVC
        }
    }
    
    //Private Methods
    func getBusList(){
        let apiManager = ApiManager ()
        apiManager.getResults(urlString:AppConstants.GET_BUSES as NSString,completionBlock:{ (responseString, responseStatus) in
            if responseStatus{
                let resultArray = Mapper<TravellResultModel>().mapArray(JSONString: responseString as String)
                self.dataController?.loadData(dataArray: resultArray!)
                Appdatabase.syncSearchResult(objArray:resultArray!, type: AppHelper.TRAVELL_TYPE.BUS)
            }else{
                let resultArray = Appdatabase.getResultFromDB(type: AppHelper.TRAVELL_TYPE.BUS)
                self.dataController?.loadData(dataArray: resultArray)
            }
        })
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
