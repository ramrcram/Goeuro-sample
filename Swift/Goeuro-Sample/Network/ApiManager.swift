//
//  ApiManager.swift
//  AutoLayout
//
//  Created by Ramesh on 17/02/17.
//  Copyright © 2017 Ramesh. All rights reserved.
//

import UIKit

class ApiManager {

    func getResults(urlString:NSString,completionBlock:((NSString,Bool)->())?) {
        if (completionBlock != nil) {
            handleApi(urlString: urlString, completionBlock: { (objResponse, responseStatus) in
                completionBlock!(objResponse,responseStatus)
            })
        }
    }
    
    
    func handleApi(urlString:NSString,completionBlock:((NSString,Bool)->())?) {
        if !AppHelper.isInternetAvailable() {
            completionBlock!("" as NSString,false)
            return
        }
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: urlString as String)
        
        let task = session.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                completionBlock!(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!,false)
            } else {
                if let JSONString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    completionBlock!(JSONString as NSString,true)
                }
            }
            
        })
        task.resume()
    }
}
