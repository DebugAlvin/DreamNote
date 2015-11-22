//
//  DNHttpTool.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/6.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit

class DNHttpTool: NSObject {
    
    
    class func getWeatherByCityName(cityName:String,completion:(weather:DNWeather?)->Void){
        
        //let plistPath = NSBundle.mainBundle().pathForResource("cityList", ofType: "plist")
        
        //let data = NSMutableDictionary(contentsOfFile: plistPath!)
        
        
        
        //var cityCode:String? = data!.objectForKey(cityName) as? String
        
        let parameters = ["city":cityName]
        // if cityCode != nil {
        RequestClient.sharedInstance.GET("http://wthrcdn.etouch.cn/weather_mini", parameters: parameters, success: { (task:NSURLSessionDataTask!, responseObject:AnyObject!) -> Void in
            
            
            
            var errorRead:NSError?
            
            var json : AnyObject! = NSJSONSerialization.JSONObjectWithData(responseObject as! NSData, options: NSJSONReadingOptions.AllowFragments, error: &errorRead)
            
            
            println(errorRead)
            println(json)
            
            
            if json.objectForKey("status") as! Int != 1002 {
                let weatherinfo: AnyObject? = json.objectForKey("data")
                
                
                
                
                
                let datas = NSJSONSerialization.dataWithJSONObject(weatherinfo!, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
                
                
                let jsonString = NSString(data: datas!, encoding: NSUTF8StringEncoding)
                
                
              
             
            
            
                let weathers = DNWeather.mj_objectWithKeyValues(jsonString)
                
                
                
          
       
                weathers.forecast = Forecast.mj_objectArrayWithKeyValuesArray(weathers.forecast).copy() as! [Forecast]
                
                completion(weather: weathers)
            }
            
            
            

            
            
            
            }) { (task:NSURLSessionDataTask!, error:NSError!) -> Void in
                
                completion(weather: nil)
                println(error)
        }
        
        
        
    }
}
