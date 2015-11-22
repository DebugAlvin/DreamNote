//
//  AppDelegate.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/1.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UIAlertViewDelegate {
    
    var window: UIWindow?
 
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        UIMaker.shareInstance()
        
        
    
    
        if UIApplication.instancesRespondToSelector(Selector("(registerUserNotificationSettings:")) == false {
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Badge | UIUserNotificationType.Sound, categories: nil))
            
            

        }
        
        
        
        //DNLocalNotification.addAlarm(alarm)
        DNLocalNotification.cancelAlarmAll()
        
        let alarmArry = DNDataBaseManager.findAlarmAll()
        if alarmArry != nil {
            DNLocalNotification.addAlarmArry(alarmArry!)
        }
        
        return true
    }
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {

        println("收到通知:\(notification.userInfo)")
        let userInfo: AnyObject? = notification.userInfo as? AnyObject
        if userInfo != nil {

            //let josnString = userInfo?.objectForKey("key") as! String
            //let alarm = DNAlarm.mj_objectWithKeyValues(josnString)
            //palayMusic("\(alarm.ringName)", type: "wav")
            NSNotificationCenter.defaultCenter().postNotificationName("audioClass", object: nil, userInfo: notification.userInfo)
            
        }

        
        
        

    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
   /* func alertViewCancel(alertView: UIAlertView){
        player.stop()
    }
    
*/
    
    
    
}

