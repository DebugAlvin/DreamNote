//
//  UIMaker.swift
//  ISchool
//
//  Created by Alvin on 15/1/4.
//  Copyright (c) 2015年 Alvin. All rights reserved.
//

import Foundation
import UIKit


let EquipmentType = UIScreen.mainScreen().bounds.width * UIScreen.mainScreen().bounds.height
let iPhone4:CGFloat = 320*480
let iPhone5:CGFloat = 320*568
let iPhone6:CGFloat = 375*667
let iPhone6Plus:CGFloat = 414*736

//自动适配缩放比例
var autoSizeScaleX:CGFloat! = 1.0
var autoSizeScaleY:CGFloat! = 1.0

func CGRectAutoMake(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> CGRect{
    
    var rect = CGRect()
    rect.origin.x = x * autoSizeScaleX
    
    rect.origin.y = y * autoSizeScaleY
    rect.size.width = width * autoSizeScaleX
    rect.size.height = height * autoSizeScaleY
    return rect
}

func storyBoradAutoLay(allView:UIView){
    
     for view:UIView in allView.subviews as! [UIView] {
    
       view.frame = CGRectAutoMake(view.frame.origin.x,
         view.frame.origin.y, view.frame.size.width, view.frame.size.height)
  
        
        for temp1:UIView in view.subviews as! [UIView] {
            temp1.frame = CGRectAutoMake(temp1.frame.origin.x, temp1.frame.origin.y, temp1.frame.size.width, temp1.frame.size.height)
        }
    }
}

class UIMaker: NSObject {
    class func shareInstance()->UIMaker{
        
        struct qzSingle{
            static var predicate:dispatch_once_t = 0
            static var instance:UIMaker? = nil
        }
        
        //实例化一次
        dispatch_once(&qzSingle.predicate,{
            
            qzSingle.instance = UIMaker()
        
            if(screenHeight > 480){
                autoSizeScaleX = screenWidth/320;
                autoSizeScaleY = screenHeight/568;
            }else{
                autoSizeScaleX = 1.0
                autoSizeScaleY = 1.0
            }
        })
        
        return qzSingle.instance!
    }
}

func getWindow() ->UIWindow {
    if let delegate: UIApplicationDelegate = UIApplication.sharedApplication().delegate {
        if let window = delegate.window {
            return window!
        }
    }
    
    return UIApplication.sharedApplication().keyWindow!
}


func storyBoradAutoLay2(allView:UIButton){
    
    allView.frame = CGRectAutoMake(allView.frame.origin.x,
    allView.frame.origin.y, allView.frame.size.width, allView.frame.size.height)
    
}
