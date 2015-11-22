//
//  BCLocation.swift
//  ITravel2.0
//
//  Created by 紫气东来 on 15/8/26.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit
import CoreLocation

protocol BCLocationDelegate {
    func didLocationSccess(location:BCLocation)
    func didLocationFailure(latitude:String,longitude:String)
    func didLocationError()
}

class BCLocation: NSObject,CLLocationManagerDelegate {
    
    var delegate: BCLocationDelegate?
    //var cityid : NSNumber!
    var cityName : String!
    var provinceName : String!
    var streeName:String!
    var latitude :String!
    var longitude :String!
    var locationManager:CLLocationManager!
    
    class func newInstance()->BCLocation {
        BCLocation.qzSingle.predicate = 0 //重新实例化一次
        return BCLocation.shareInstance()
    }
    
    struct qzSingle{
        static var predicate:dispatch_once_t = 0
        static var instance:BCLocation? = nil
    }
    
    class func shareInstance()->BCLocation{
        
        //实例化一次
        dispatch_once(&qzSingle.predicate,{
            
            qzSingle.instance = BCLocation()

            //println(qzSingle.instance)
            let locationObject = BCLocation.searchWithWhere(nil, orderBy: nil, offset: 0, count: 1)
            

            
            var GPSEnabled = false
            qzSingle.instance!.locationManager = CLLocationManager()
            var authStatus = CLLocationManager.authorizationStatus()
            qzSingle.instance!.locationManager!.delegate = qzSingle.instance!
            
            if locationObject.count > 0 {
                let location = locationObject.objectAtIndex(0) as! BCLocation
                qzSingle.instance!.delegate?.didLocationSccess(location)
            }
            
            switch authStatus {
            case CLAuthorizationStatus.NotDetermined:
                
                if((UIDevice.currentDevice().systemVersion as NSString).floatValue > 8.0){
                    qzSingle.instance!.locationManager!.requestWhenInUseAuthorization()
                }else{
                    //qzSingle.instance!.delegate?.didLocationError()
                }
                
            case CLAuthorizationStatus.Restricted:
                println("无法使用定位服务，该状态用户无法改变")
                qzSingle.instance!.delegate?.didLocationError()
            case CLAuthorizationStatus.Denied:
                println("用户拒绝该应用使用定位服务，或是定位服务总开关处于关闭状态")
                let alertView = UIAlertView(title: "提示", message: "定位失败！请到手机系统的[设置]->[隐私]->[定位系统]中打开\(appName)位服务", delegate: nil, cancelButtonTitle: "确定")
                alertView.show()
                qzSingle.instance!.delegate?.didLocationError()
            case CLAuthorizationStatus.AuthorizedAlways:
                println("当前在后台也可以进行定位")
                GPSEnabled = true
            case CLAuthorizationStatus.AuthorizedWhenInUse:
                println("只能在使用程序的时候进行定位")
                GPSEnabled = true
            }
            
            if GPSEnabled {
                qzSingle.instance!.locationManager!.delegate = qzSingle.instance
                qzSingle.instance!.locationManager!.desiredAccuracy = kCLLocationAccuracyThreeKilometers
                qzSingle.instance!.locationManager.distanceFilter = CLLocationDistance(10000)
                qzSingle.instance!.locationManager!.startUpdatingLocation()
            }else{
                
            }
            
        })
        
        return qzSingle.instance!
    }
    
    // ==== CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedAlways || status == CLAuthorizationStatus.AuthorizedWhenInUse {
            ///这里
            qzSingle.instance!.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            qzSingle.instance!.locationManager.distanceFilter = CLLocationDistance(1000)
            qzSingle.instance!.locationManager!.startUpdatingLocation()
            //用户拒绝定位
        }else if status == CLAuthorizationStatus.Denied{
            qzSingle.instance!.delegate?.didLocationError()
            
            //ios7不需要询问用户定位，所以直接回调错误
        }else if status == CLAuthorizationStatus.NotDetermined{
            if((UIDevice.currentDevice().systemVersion as NSString).floatValue < 8.0){
                qzSingle.instance!.delegate?.didLocationError()
            }
        }else{
            println("不在定位状态")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        println("get location")
        
        var location:CLLocation = locations[locations.count-1] as! CLLocation
        
        if (location.horizontalAccuracy > 0) {
            self.locationManager.stopUpdatingLocation()
            println("latitude \(location.coordinate.latitude) longitude \(location.coordinate.longitude)")
            
            //反编码成功之后加载数据
            reverseCity(location)
        }else{
            delegate?.didLocationError()
        }
    }
    
    //反地理编码
    func reverseCity(currLocation:CLLocation) {
        var geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currLocation, completionHandler: { (placemarks, error) -> Void in
            if(error == nil && placemarks.count>0) {
                let marks = placemarks[0] as? CLPlacemark
                
                if(marks!.locality != nil){
                    //let cityObject = CityModel.findByCityName(marks!.locality) as CityModel
                    
                   // BCLocation.deleteToDB()
                    var location = BCLocation()
                    location.rowid = 1
                    location.deleteToDB()
                    location.cityName = marks!.locality
          
                    location.latitude = "\(currLocation.coordinate.latitude)"
                    location.longitude = "\(currLocation.coordinate.longitude)"
                    location.provinceName = marks!.administrativeArea
                    location.streeName = marks!.thoroughfare
                    //更新数据库
                    
                    location.cityName = location.cityName.stringByReplacingOccurrencesOfString("市", withString: "").stringByReplacingOccurrencesOfString("自治州", withString: "")
                    println(location.cityName)
                    //location.pk = BCLocation.shareInstance().pk
                   // location.saveOrUpdate()
                    location.saveToDB()
                    BCLocation.qzSingle.instance = location
                    //println("\(BCLocation.findAll().count)")
                    self.delegate?.didLocationSccess(location)
                }else{
                    self.delegate?.didLocationFailure("\(currLocation.coordinate.latitude)", longitude: "\(currLocation.coordinate.longitude)")
                }
            }
        })
    }
    
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
        
        // delegate?.didLocationError()
        println("get location error")
    }
    
}
