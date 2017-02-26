//
//  AppHelper.swift
//  Goeuro-Sample
//
//  Created by Ramesh on 23/02/17.
//  Copyright © 2017 Ramesh. All rights reserved.
//

import UIKit
import CoreData
import SystemConfiguration
import SwiftMessages

class AppHelper: NSObject {

    static func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    static var context:NSManagedObjectContext? = nil
    
    static func getEntity() -> NSManagedObjectContext {
        if (context != nil) {
            return context!
        }
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        context = appdelegate.sharedInstance().managedObjectContextMethod()
        return context!
    }
    
    static func showConnectionMessage()-> UIView
    {
    // Instantiate a message view from the provided card view layout. SwiftMessages searches for nib
    // files in the main bundle first, so you can easily copy them into your project and make changes.
    let view = MessageView.viewFromNib(layout: .StatusLine)
    
    // Theme message elements with the warning style.
    view.configureTheme(.error)
    
    // Add a drop shadow.
//    view.configureDropShadow()
    
    // Set message title, body, and icon. Here, we're overriding the default warning
    // image with an emoji character.
    let iconText = ""
    view.configureContent(title: "Are you Offline?", body: "Connect to mobile data or wifi and try to get latest result!.", iconText: iconText)
    return view
    }

    enum TRAVELL_TYPE:String {
        case BUS = "BUS"
        case TRAIN = "TRAIN"
        case FLIGHT = "FLIGHT"
    }

    
}
