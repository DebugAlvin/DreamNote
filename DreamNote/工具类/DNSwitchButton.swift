//
//  DNSwitchButton.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/4.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit

@IBDesignable
class DNSwitchButton: UIView {
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    
    @IBInspectable var selected:Bool = false
    
    @IBInspectable var themeColor:UIColor = UIColor(red: 0.111, green: 0.564, blue: 0.713, alpha: 1.000)
    @IBInspectable var themeSColor:UIColor = UIColor.grayColor()
    
    @IBInspectable var ringColor:UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    @IBInspectable var ringSColor:UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    
    
    var isdraw = false
    var rectanglelayer = CAShapeLayer()
    var ovallayer = CAShapeLayer()
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        
        var sPosition = self.ovallayer.pop_animationForKey("sPosition") as? POPSpringAnimation
        if self.selected == true {
            self.selected = false
            
            sPosition = POPSpringAnimation(propertyNamed: kPOPLayerPositionX)
            sPosition?.toValue = 0
            sPosition?.springBounciness = 11
            sPosition?.springSpeed = 18
            ovallayer.pop_addAnimation(sPosition, forKey: "sPosition")
            rectanglelayer.fillColor = themeColor.CGColor
        }else {
            self.selected = true
            sPosition = POPSpringAnimation(propertyNamed: kPOPLayerPositionX)
            sPosition?.toValue = -26
            sPosition?.springBounciness = 11
            sPosition?.springSpeed = 18
            ovallayer.pop_addAnimation(sPosition, forKey: "sPosition")
            rectanglelayer.fillColor = themeSColor.CGColor
        }
        
    }
    
    
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        //// Welcome
        
        self.tintColor = UIColor.clearColor()
        self.backgroundColor = UIColor.clearColor()
        //// Welcome 2
        //// Artboard-16
        //// Rectangle-45-+-Oval-118
        //// Rectangle-45 Drawing
        let rectangle45Path = UIBezierPath(roundedRect: CGRectMake(8, 8.92, 40, 12.5), cornerRadius: 6.25)
        
        
        
        
        
        
        
        
        //// Oval-118 Drawing
        var ovalPath = UIBezierPath(ovalInRect: CGRectMake(33, 7.92, 15, 15))
        
        
        
        
        rectanglelayer.frame = CGRectMake(0, 0, rectanglelayer.frame.width, rectanglelayer.frame.height)
        rectanglelayer.path = rectangle45Path.CGPath
        rectanglelayer.fillColor = themeColor.CGColor
        rectanglelayer.strokeColor = UIColor.clearColor().CGColor
        rectanglelayer.lineWidth = 0
        
        self.layer.addSublayer(rectanglelayer)
        
        ovallayer.frame = CGRectMake(0, 0, ovallayer.frame.width, ovallayer.frame.height)
        ovallayer.path = ovalPath.CGPath
        ovallayer.fillColor = UIColor.clearColor().CGColor
        ovallayer.strokeColor = ringColor.CGColor
        ovallayer.lineWidth = 5
        self.layer.addSublayer(ovallayer)
        
        
        
    }
    
}
