//
//  AppDelegate.swift
//  Goeuro-Sample
//
//  Created by Ramesh on 14/02/17.
//  Copyright © 2017 Ramesh. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var managedObjectContext: NSManagedObjectContext!
    var managedObjectModel: NSManagedObjectModel!
    var persistentStoreCoordinator: NSPersistentStoreCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    func sharedInstance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    // MARK: - Core Data stack
    func persistentStoreCoordinatorMethod() -> NSPersistentStoreCoordinator {
        if self.persistentStoreCoordinator != nil {
            return self.persistentStoreCoordinator
        }
        let storeURL: URL? = self.applicationDocumentsDirectory().appendingPathComponent("Goeuro_db.sqlite")
//        let error: Error? = nil
        self.persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModelMethod())
        if !(((try? self.persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)) != nil)) {
            abort()
        }
        return self.persistentStoreCoordinator
    }
    
    func managedObjectContextMethod() -> NSManagedObjectContext {
        if self.managedObjectContext != nil {
            return self.managedObjectContext
        }
        let coordinator: NSPersistentStoreCoordinator? = self.persistentStoreCoordinatorMethod()
        if coordinator != nil {
            self.managedObjectContext = NSManagedObjectContext()
            self.managedObjectContext.persistentStoreCoordinator = coordinator
        }
        return self.managedObjectContext
    }
    
    func managedObjectModelMethod() -> NSManagedObjectModel {
        if self.managedObjectModel != nil {
            return self.managedObjectModel
        }
        let modelURL: URL? = Bundle.main.url(forResource: "Goeuro_db", withExtension: "momd")
        self.managedObjectModel = NSManagedObjectModel(contentsOf: modelURL!)
        return self.managedObjectModel
    }
    
    // MARK: - Core Data Saving support
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    func applicationDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    }
    
}

