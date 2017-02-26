//
//  FirstViewController.swift
//  Goeuro-Sample
//
//  Created by Ramesh on 14/02/17.
//  Copyright © 2017 Ramesh. All rights reserved.
//

import UIKit
import ObjectMapper

class FlightsVC: UIViewController {

    var dataController:DataVC?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getFlightList()
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if segue.identifier == "flightlist"
        {
            dataController = segue.destination as? DataVC
        }
    }
    
    //Private Methods
    func getFlightList(){
        let apiManager = ApiManager ()
        apiManager.getResults(urlString:AppConstants.GET_FLIGHTS as NSString,completionBlock:{ (responseString, responseStatus) in
            if responseStatus{
                let resultArray = Mapper<TravellResultModel>().mapArray(JSONString: responseString as String)
                self.dataController?.loadData(dataArray: resultArray!)
                Appdatabase.syncSearchResult(objArray:resultArray!, type: AppHelper.TRAVELL_TYPE.FLIGHT)
            }else{
                let resultArray = Appdatabase.getResultFromDB(type: AppHelper.TRAVELL_TYPE.FLIGHT)
                self.dataController?.loadData(dataArray: resultArray)
            }
        })
    }
}

