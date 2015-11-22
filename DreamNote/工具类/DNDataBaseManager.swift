//
//  DNDataBaseManager.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/11.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit

class DNDataBaseManager: NSObject {
   
    
    class func addDream(dream:DNDream/*,year:NSNumber*/){
        
    
        
        dream.saveToDB()

    }
    
    class func deleteAlarm(model:DNAlarm){
   
        model.deleteToDB()
    }
    
    
    class func addAlarm(alarm:DNAlarm) {
        
        alarm.saveToDB()
        //alarm.save()
    }
    
    class func findAlarmAll()->[DNAlarm]?{
        
        
        return DNAlarm.searchWithWhere(nil, orderBy: nil, offset: 0, count: 1000).copy() as? [DNAlarm]

    }
    
    class func findDreamAll() -> NSMutableArray?{

        return DNDream.searchWithWhere(nil, orderBy: nil, offset: 0, count: 1000)

    }
    
    class func deleteDream(dream:DNDream){
        dream.deleteToDB()
    }
    
    
    
    /*class func findYearByID(year:NSNumber) -> DNYear?{
       return DNYear.findFirstByCriteria("where year = \(year)")
    }
    
    class func addYear(year:NSNumber) {
    
        let obj = DNYear()
        obj.year = year
        obj.pk = year.intValue
        obj.save()
    }
    class func findYearAll() -> [DNYear]?{
        
        return DNYear.findAll() as? [DNYear]
    }
    */

    
}
