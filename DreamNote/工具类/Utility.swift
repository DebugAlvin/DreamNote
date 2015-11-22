//
//  Utility.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/5.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    
    
    //偷个懒，以后补上所有图片＝ ＝
    class func getWeatherImageName(weatherType:String) ->String {
        
        
        if weatherType == "晴" {
            return "晴"
        }
        
        if weatherType == "多云" {
            return "多云"
        }
        
        if weatherType == "雷阵雨" {
            return "雷阵雨"
        }
        
        if weatherType == "小雨" {
            return "小雨"
        }
        
        
        if weatherType == "雨夹雪" {
            return "雨夹雪"
        }
        
        if weatherType == "大雪" {
            return "雨夹雪"
        }
        if weatherType == "大雨" {
            return "雨"
        }
        
        if weatherType == "阵雨" {
            return "雷阵雨"
        }
        
        //什么转什么鬼，以后再补上＝ ＝
        if (weatherType as NSString).rangeOfString("风").location != NSNotFound {
            return "风"
        }
        
        if (weatherType as NSString).rangeOfString("云").location != NSNotFound {
            return "多云"
        }
        if (weatherType as NSString).rangeOfString("晴").location != NSNotFound {
            return "晴"
        }
        if (weatherType as NSString).rangeOfString("雨").location != NSNotFound {
            return "小雨"
        }
        if (weatherType as NSString).rangeOfString("雪").location != NSNotFound {
            return "雪"
        }
        
        
        return "多云"
    }
    
    class func  formatTime(hour:Int,minute:Int)->String{
        
        var minuteStr:String = ""
        
        
        if minute <= 9 {
            minuteStr = "0\(minute)"
        }else{
            minuteStr = "\(minute)"
        }
        
        
        return "\(hour):\(minuteStr)"
        
    }
    
    
    //"16日 12:20 下午"
    class func formatCreatTime(timestamp:Int)->String {
    
        

        var  formatter = NSDateFormatter ()
        formatter.dateFormat = "yyyy年MM月dd日 HH:MM"
        var date = NSDate(timeIntervalSince1970 : Double(timestamp))
        
        return  formatter.stringFromDate(date)
        
        
    }
    
    
    class func formatImageSize(maxWidth:CGFloat,maxHeight:CGFloat = 600,currentSize:CGSize) -> CGSize {
    
        var size:CGSize! = currentSize

        if currentSize.width > maxWidth {
            let wsalce =   currentSize.width / maxWidth
            size = CGSizeMake(maxWidth, currentSize.height / wsalce)
            if size.height > maxHeight {
                let hsalce = currentSize.height / maxHeight
                size = CGSizeMake(size.width / hsalce, size.height)
            }
        }
        
        
        return size
    }
    
    /// 计算内容的矩形
    class func stringHeightWith(string:String,fontSize:CGFloat, width:CGFloat) -> CGRect {
        var font = UIFont.systemFontOfSize(fontSize)
        var size = CGSizeMake(width,CGFloat.max)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .ByWordWrapping;
        
        
       // var  attributes = [NSFontAttributeName:font,
        //    NSParagraphStyleAttributeName:paragraphStyle.copy()]
        var attributes = [NSFontAttributeName: font]
        var option = NSStringDrawingOptions.UsesLineFragmentOrigin | NSStringDrawingOptions.UsesFontLeading
        
        var text = string as NSString
        
        
        var rect = text.boundingRectWithSize(size, options:option, attributes: attributes, context:nil)
        
        return rect
    }
    
    

    
    class func formatWeekDay(weekNum:Int)->String {
        var wekDay:String!
        switch weekNum {
            
        case 1:
            wekDay = "星期日"
            break
        case 2:
            wekDay = "星期一"
            break
        case 3:
            wekDay = "星期二"
            break
        case 4:
            wekDay = "星期三"
            break
        case 5:
            wekDay = "星期四"
            break
        case 6:
            wekDay = "星期五"
        case 7:
            wekDay = "星期六"
        default:
            wekDay = "星期日"
            
        }
        return wekDay
        
    }
    
}
