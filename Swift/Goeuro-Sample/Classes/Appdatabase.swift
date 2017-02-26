//
//  Appdatabase.swift
//  Goeuro-Sample
//
//  Created by Ramesh on 23/02/17.
//  Copyright © 2017 Ramesh. All rights reserved.
//

import UIKit
import CoreData

class Appdatabase: NSObject {

    
    static func syncSearchResult(objArray:[TravellResultModel],type:AppHelper.TRAVELL_TYPE) {
        
        let context:NSManagedObjectContext = AppHelper.getEntity()
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TravellResultModel")
        fetchRequest.predicate = NSPredicate(format: "travelltype == %d", Int32(type.hashValue) )
        // Create Batch Delete Request
        if #available(iOS 9.0, *) {
            do {
                try context.execute(NSBatchDeleteRequest(fetchRequest: fetchRequest))
                
            } catch {
                // Error Handling
            }
        } else {
            do {
                let fetchedSearchResult = try AppHelper.getEntity().fetch(fetchRequest) as! [TravellResultModel]
                for bas: AnyObject in fetchedSearchResult
                {
                    context.delete(bas as! NSManagedObject)
                }
            } catch {
                fatalError("Failed to fetch employees: \(error)")
            }
        }
        
        let trainSearchResult = NSEntityDescription.insertNewObject(forEntityName: "TravellResultModel", into: context)
        DispatchQueue.global(qos: .background).async {
            for object in objArray {
                object.travelltype = Int32(type.hashValue)
                trainSearchResult.setValue(object.id, forKey: "id")
                trainSearchResult.setValue(object.provider_logo, forKey: "provider_logo")
                trainSearchResult.setValue(object.price_in_euros, forKey: "price_in_euros")
                trainSearchResult.setValue(object.departure_time, forKey: "departure_time")
                trainSearchResult.setValue(object.arrival_time, forKey: "arrival_time")
                trainSearchResult.setValue(object.number_of_stops, forKey: "number_of_stops")
                trainSearchResult.setValue(object.duration, forKey: "duration")
                trainSearchResult.setValue(object.travelltype, forKey: "travelltype")
            }
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    static func getResultFromDB(type:AppHelper.TRAVELL_TYPE)->[TravellResultModel]{
        
        let searchResultFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "TravellResultModel")
        searchResultFetch.predicate = NSPredicate(format: "travelltype == %d", Int32(type.hashValue) )
        var fetchedSearchResult:[TravellResultModel]
        do {
            fetchedSearchResult = try AppHelper.getEntity().fetch(searchResultFetch) as! [TravellResultModel]
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        
        return fetchedSearchResult
    }
}
