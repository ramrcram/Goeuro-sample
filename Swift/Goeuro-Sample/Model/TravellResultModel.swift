//
//  FlightModel.swift
//  Goeuro-Sample
//
//  Created by Ramesh on 18/02/17.
//  Copyright © 2017 Ramesh. All rights reserved.
//

import ObjectMapper
import CoreData

class TravellResultModel :NSManagedObject, Mappable {
    @NSManaged var id:Int32
    @NSManaged var provider_logo:String?
    @NSManaged var price_in_euros:AnyObject?
    @NSManaged var departure_time:String?
    @NSManaged var arrival_time:String?
    @NSManaged var number_of_stops:Int32
    @NSManaged var duration:String?
    @NSManaged var travelltype:Int32
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: AppHelper.context)
    }
    
    required init?(map: Map) {
        let ctx = AppHelper.getEntity()
        let entity = NSEntityDescription.entity(forEntityName: "TravellResultModel", in: ctx)
        super.init(entity: entity!, insertInto: ctx)
        mapping(map: map)
    }
    
    func getDuration(departure:String,arrival:String) -> String {
        
        let dep_str = departure.replacingOccurrences(of: ":", with: ".")
        let arr_str = arrival.replacingOccurrences(of: ":", with: ".")
        
        let diffrence = String(format: "%.2f", abs(((NSDecimalNumber(string: dep_str) as Double) - (NSDecimalNumber(string: arr_str) as Double))))
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm"
//        
//        let date_departure :Date = dateFormatter.date(from: departure) as Date!
//        let date_Arri:Date = dateFormatter.date(from: arrival)  as Date!
//        
//        let interval = date_departure.timeIntervalSince(date_Arri)
//        
//        let date = NSDate(timeIntervalSinceReferenceDate: interval)
//        let calendar = NSCalendar.current
//        let hour = calendar.component(.hour, from: date as Date)
//        let minutes = calendar.component(.minute, from: date as Date)
        var diff_str = "\(diffrence)"
        diff_str = diff_str.replacingOccurrences(of: ".", with: ":")
        return "\(diff_str)"
    }
    
    // Mappable
    func mapping(map: Map) {
        id    <- map["id"]
        provider_logo    <- map["provider_logo"]
        price_in_euros    <- map["price_in_euros"]
        departure_time    <- map["departure_time"]
        arrival_time    <- map["arrival_time"]
        number_of_stops    <- map["number_of_stops"]
        travelltype <- map["travelltype"]
        duration = self.getDuration(departure: departure_time!, arrival: arrival_time!)
    }
}
