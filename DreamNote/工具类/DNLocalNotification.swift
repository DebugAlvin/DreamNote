//
//  DNLocalNotification.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/16.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit

class DNLocalNotification: NSObject {
    
    
    class func addAlarm(alarm:DNAlarm) {
        
        
        
        let notification = UILocalNotification()
        
        var inputFormatter = NSDateFormatter()
        inputFormatter.locale = NSLocale.currentLocale()
        println(NSLocale.currentLocale().localeIdentifier)
        
        
        let calendar = NSCalendar.currentCalendar()
        let flags: NSCalendarUnit = NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitWeekday
        //设置格式
        let now = NSDate()
        let comps = calendar.components(flags, fromDate: now)
        let currentWeek = NSNumber(unsignedInteger: comps.weekday)
        
        if alarm.cycle.count > 0 {
            var dfDay:Int = 0
            for weekday in alarm.cycle {
                if weekday.integerValue <= currentWeek.integerValue {
                    if weekday.integerValue == currentWeek.integerValue {
                        if comps.hour > (alarm.hours as NSString).integerValue {
                            dfDay = 7
                        }else{
                            dfDay = 0
                        }
                    }else{
                        dfDay = 7 - currentWeek.integerValue + weekday.integerValue
                    }
                }else{
                    dfDay = weekday.integerValue - currentWeek.integerValue
                }
                

                
                //var alarmDay = comps.day + dfDay
                
                inputFormatter.dateFormat = "yyyyMMddHHmm"
                var inputDate = inputFormatter.dateFromString("\(comps.year)\(comps.month)\(comps.day)\(alarm.hours)\(alarm.minute)")
                
                println(inputDate)

                inputDate = inputDate! + dfDay.days
                
                for var index = 0; index < 3; ++index {
                
                    
                
                }
                
                notification.fireDate = inputDate
                notification.timeZone = NSTimeZone.defaultTimeZone()
                notification.repeatInterval = NSCalendarUnit.CalendarUnitWeekday
                notification.soundName = "\(alarm.ringName).wav"
                notification.alertBody = alarm.tips
                // NSDictionary *infoDic = [NSDictionary dictionaryWithObject:@"name" forKey:@"key"];
                
                let infoDic = NSDictionary(object: alarm.mj_JSONString(), forKey: "key")
                
                notification.userInfo = infoDic as [NSObject : AnyObject]
                
                //添加推送到uiapplication
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
            }
            
        }else{
            
            
            let notification = UILocalNotification()
            let calendar = NSCalendar.currentCalendar()
            let flags: NSCalendarUnit = NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitWeekday
            //设置格式
            let now = NSDate()
            let comps = calendar.components(flags, fromDate: now)
            let currentWeek = NSNumber(unsignedInteger: comps.weekday)
            var dfDay = 0
            
            if comps.hour > (alarm.hours as NSString).integerValue {
                dfDay = 1
            }else{
                dfDay = 0
            }

            
            var alarmDay = comps.day + dfDay
            inputFormatter.dateFormat = "yyyyMMddHHmm"
            var inputDate = inputFormatter.dateFromString("\(comps.year)\(comps.month)\(alarmDay)\(alarm.hours)\(alarm.minute)")
            
            inputDate = inputDate! + dfDay.days
            
            println(inputDate)
            notification.fireDate = inputDate
            notification.timeZone = NSTimeZone.defaultTimeZone()

            notification.soundName = "\(alarm.ringName).wav"
            notification.alertBody = alarm.tips
            // NSDictionary *infoDic = [NSDictionary dictionaryWithObject:@"name" forKey:@"key"];
            
            let infoDic = NSDictionary(object: alarm.mj_JSONString(), forKey: "key")
            
            notification.userInfo = infoDic as [NSObject : AnyObject]
            
            //添加推送到uiapplication
            UIApplication.sharedApplication().scheduleLocalNotification(notification)

        }
        
        
        
    }
    
    
    class func addAlarmArry(alarmArry:[DNAlarm]){
        println(alarmArry.count)
        for alarm in alarmArry{
            DNLocalNotification.addAlarm(alarm)
        }
        
    }
    
    
    
    class func cancelAlarm(alarm:DNAlarm){
        let localNotifications:[AnyObject] = UIApplication.sharedApplication().scheduledLocalNotifications
        for notification in localNotifications {
            
            
            
            let userInfo: AnyObject? = (notification as! UILocalNotification).userInfo as? AnyObject
            if userInfo != nil {
                
                let josnString = userInfo?.objectForKey("key") as! String
                let _alarm = DNAlarm.mj_objectWithKeyValues(josnString)
                
                if _alarm.identifier == alarm.identifier {
                    UIApplication.sharedApplication().cancelLocalNotification(notification as! UILocalNotification)
                }
    
            }
            
        }
        
    }
    class func cancelAlarmAll(){
        let localNotifications:[AnyObject] = UIApplication.sharedApplication().scheduledLocalNotifications
        for notification in localNotifications {
            
            let userInfo = (notification as! UILocalNotification).userInfo
            if userInfo != nil {
                UIApplication.sharedApplication().cancelLocalNotification(notification as! UILocalNotification)
            }
        }
        
    }
    
    
}
