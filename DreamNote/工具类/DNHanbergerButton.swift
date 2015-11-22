//
//  DNHanbergerButton.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/2.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit


enum BCButtonStyle:CGFloat {
    case Close = 1
    case Menu
    case Add
}

@IBDesignable
class DNHanbergerButton: UIButton {
    
    @IBInspectable var tb:CGFloat = 0
    @IBInspectable var style:CGFloat = BCButtonStyle.Menu.rawValue
    @IBInspectable var scale:CGFloat = 2
    
    var linePath1:UIBezierPath!
    var linePath2:UIBezierPath!
    var linePath3:UIBezierPath!
    
    var rotelayer = CAShapeLayer()
    
    var oval:CAShapeLayer! = CAShapeLayer()
    var top: CAShapeLayer! = CAShapeLayer()
    var bottom: CAShapeLayer! = CAShapeLayer()
    var middle: CAShapeLayer! = CAShapeLayer()
    @IBInspectable var themeColor:UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    var isdraw = false
    
    override func drawRect(rect: CGRect) {
        
        
        if isdraw == false {
            isdraw = true
            if style == BCButtonStyle.Menu.rawValue {
                //// Welcome
                //// Instructions-—-You-can-remove-this-3
                //// Oval-31-+-Line-+-Line-2
                //// Oval-31 Drawing
                var oval31Path = UIBezierPath(ovalInRect: CGRectMake(4, 4, 36, 36))
                oval31Path.closePath()
                
                //// Line Drawing
                linePath1 = UIBezierPath()
                linePath1.moveToPoint(CGPointMake(12.35, 13.77))
                linePath1.addLineToPoint(CGPointMake(32.35, 13.77))
                linePath1.closePath()
                
                
                //// Line-2 Drawing
                linePath2 = UIBezierPath()
                linePath2.moveToPoint(CGPointMake(12.35, 21))
                linePath2.addLineToPoint(CGPointMake(32.35, 22))
                linePath2.closePath()
                
                
                //// Line- 3 Drawing
                linePath3 = UIBezierPath()
                linePath3.moveToPoint(CGPointMake(12.35, 27.92))
                linePath3.addLineToPoint(CGPointMake(32.35, 27.92))
                linePath3.closePath()
                
                
                
                self.top.path = linePath1.CGPath
                self.middle.path = linePath2.CGPath
                self.bottom.path = linePath3.CGPath
                self.oval.path = oval31Path.CGPath
                
                
                
                
                self.top.backgroundColor = themeColor.CGColor
                self.bottom.backgroundColor = themeColor.CGColor
                
                self.middle.backgroundColor = themeColor.CGColor
                
                self.oval.fillColor = UIColor.clearColor().CGColor
                self.oval.strokeColor = themeColor.CGColor
                
                
                self.top.frame = CGRectMake(12, 13.77,linePath1.bounds.width,1.5)
                self.bottom.frame = CGRectMake(12, 27.92,linePath3.bounds.width,1.5)
                self.middle.frame = CGRectMake(12, 21,linePath2.bounds.width,1.5)
                self.oval.frame = CGRectMake(0,0, oval31Path.bounds.width, oval31Path.bounds.height)
                self.oval.lineWidth = 1.5
                
                self.layer.addSublayer(self.oval)
                self.layer.addSublayer(self.middle)
                self.layer.addSublayer(self.bottom)
                self.layer.addSublayer(self.top)
            }
            
            if style == BCButtonStyle.Close.rawValue {
                
                /*roteView = UIView(frame: CGRectMake(4, 4, 36, 36))
                roteView.backgroundColor = UIColor.clearColor()
                roteView.center = CGPointMake(18, 18)*/
                //self.addSubview(roteView)
                //// Welcome
                //// Artboard-16
                //// Oval-31-+-Line-+-Line-2
                //// Oval-31 Drawing
                var oval31Path = UIBezierPath(ovalInRect: CGRectMake(4, 4, 36, 36))

                
                
                //// Line-+-Line-2
                //// Line Drawing
                var linePath = UIBezierPath()
                linePath.moveToPoint(CGPointMake(15.19, 27.87))
                linePath.addLineToPoint(CGPointMake(27.73, 15.63))
                linePath.addLineToPoint(CGPointMake(28.27, 15.11))
                linePath.addLineToPoint(CGPointMake(29.31, 16.19))
                linePath.addLineToPoint(CGPointMake(28.78, 16.71))
                linePath.addLineToPoint(CGPointMake(16.23, 28.94))
                linePath.addLineToPoint(CGPointMake(15.7, 29.46))
                linePath.addLineToPoint(CGPointMake(14.65, 28.39))
                linePath.addLineToPoint(CGPointMake(15.19, 27.87))
                linePath.closePath()
                
                
                
                //// Line-2 Drawing
                var line2Path = UIBezierPath()
                line2Path.moveToPoint(CGPointMake(27.72, 29.58))
                line2Path.addLineToPoint(CGPointMake(15, 16.85))
                line2Path.addLineToPoint(CGPointMake(14.46, 16.32))
                line2Path.addLineToPoint(CGPointMake(15.53, 15.26))
                line2Path.addLineToPoint(CGPointMake(16.06, 15.79))
                line2Path.addLineToPoint(CGPointMake(28.78, 28.52))
                line2Path.addLineToPoint(CGPointMake(29.31, 29.05))
                line2Path.addLineToPoint(CGPointMake(28.25, 30.11))
                line2Path.addLineToPoint(CGPointMake(27.72, 29.58))
                line2Path.closePath()
                
                
                
                
                
                
                let lin1layer = CAShapeLayer()
                let lin2layer = CAShapeLayer()
                let ovallayer = CAShapeLayer()

                
                
                lin1layer.path = linePath.CGPath
                lin2layer.path = line2Path.CGPath
                ovallayer.path = oval31Path.CGPath
                
                
                lin1layer.fillColor = themeColor.CGColor
                ovallayer.strokeColor = themeColor.CGColor
                ovallayer.fillColor = UIColor.clearColor().CGColor
                ovallayer.lineWidth = 1.5
                lin2layer.fillColor = themeColor.CGColor
        
                
                
                
                
                
                rotelayer.anchorPoint = CGPointMake(1, 1)
                rotelayer.addSublayer(lin1layer)
                rotelayer.addSublayer(lin2layer)
                rotelayer.addSublayer(ovallayer)
                
                //设置旋转中心点
                rotelayer.frame = CGRectMake(0, 0, 22, 22)
                
                self.layer.addSublayer(rotelayer)
            }
            
            if style == BCButtonStyle.Add.rawValue {
                
                //// Artboard-16
                //// Oval-31-+-Line-+-Line-
                //// Oval-31 Drawing
                var oval31Path = UIBezierPath(ovalInRect: CGRectMake(4, 4, 36, 36))

                
                
                //// Line-+-Line- 3
                //// Line 5 Drawing
                var linePath = UIBezierPath()
                linePath.moveToPoint(CGPointMake(21.23, 30.49))
                linePath.addLineToPoint(CGPointMake(21.14, 12.97))
                linePath.addLineToPoint(CGPointMake(21.14, 12.22))
                linePath.addLineToPoint(CGPointMake(22.64, 12.21))
                linePath.addLineToPoint(CGPointMake(22.64, 12.96))
                linePath.addLineToPoint(CGPointMake(22.73, 30.48))
                linePath.addLineToPoint(CGPointMake(22.73, 31.23))
                linePath.addLineToPoint(CGPointMake(21.23, 31.24))
                linePath.addLineToPoint(CGPointMake(21.23, 30.49))
                linePath.closePath()
                
                
                
                //// Line- 6 Drawing
                var line2Path = UIBezierPath()
                line2Path.moveToPoint(CGPointMake(31.17, 22.66))
                line2Path.addLineToPoint(CGPointMake(13.17, 22.98))
                line2Path.addLineToPoint(CGPointMake(12.42, 22.99))
                line2Path.addLineToPoint(CGPointMake(12.39, 21.49))
                line2Path.addLineToPoint(CGPointMake(13.14, 21.48))
                line2Path.addLineToPoint(CGPointMake(31.14, 21.16))
                line2Path.addLineToPoint(CGPointMake(31.89, 21.15))
                line2Path.addLineToPoint(CGPointMake(31.92, 22.65))
                line2Path.addLineToPoint(CGPointMake(31.17, 22.66))
                line2Path.closePath()
                
                
                
                let lin1layer = CAShapeLayer()
                let lin2layer = CAShapeLayer()
                let ovallayer = CAShapeLayer()
                lin1layer.path = linePath.CGPath
                lin2layer.path = line2Path.CGPath
                ovallayer.path = oval31Path.CGPath
                
                lin1layer.fillColor = themeColor.CGColor
                //ovallayer.strokeColor = themeColor.CGColor
                ovallayer.strokeColor = themeColor.CGColor
                ovallayer.fillColor = UIColor.clearColor().CGColor
                ovallayer.lineWidth = 1.5
                lin2layer.fillColor = themeColor.CGColor
                
                
                rotelayer.anchorPoint = CGPointMake(1, 1)
                rotelayer.addSublayer(lin1layer)
                rotelayer.addSublayer(lin2layer)
                rotelayer.addSublayer(ovallayer)
                
                //设置旋转中心点
                rotelayer.frame = CGRectMake(0, 0, 22, 22)
                
                self.layer.addSublayer(rotelayer)
                
            }
            
        }
        
        
        
    }
    
    
    func showClose(){
        
        self.style = BCButtonStyle.Close.rawValue
        var topRoate = self.top.pop_animationForKey("topRoate") as? POPSpringAnimation
        var boomRoate = self.bottom.pop_animationForKey("boomRoate") as? POPSpringAnimation
        
        var topPosition = self.top.pop_animationForKey("topPosition") as? POPSpringAnimation
        var boomPosition = self.bottom.pop_animationForKey("boomPosition") as? POPSpringAnimation
        
        
        
        self.middle.backgroundColor = UIColor.clearColor().CGColor
        
        
        
        
        
        
        if topRoate != nil {
            topRoate!.toValue = -M_PI_4
        }else{
            topRoate = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
            topRoate!.toValue = M_PI_4
            topRoate!.springBounciness = 11
            topRoate!.springSpeed = 18
            self.top.pop_addAnimation(topRoate, forKey: "topRoate")
        }
        
        
        
        
        
        if boomRoate != nil {
            boomRoate!.toValue = M_PI_4
        }else{
            boomRoate = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
            boomRoate!.toValue = -M_PI_4
            boomRoate!.springBounciness = 2
            boomRoate!.springSpeed = 18
            self.bottom.pop_addAnimation(boomRoate, forKey: "boomRoate")
        }
        
        
        
        
        if topPosition != nil {
            topPosition?.toValue = 0
        }else{
            topPosition = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            
            topPosition?.toValue = 22
            topPosition?.springBounciness = 11
            topPosition?.springSpeed = 18
            top.pop_addAnimation(topPosition, forKey: "topPosition")
        }
        
        
        if boomPosition != nil {
            boomPosition?.toValue = 0
        }else{
            boomPosition = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            
            boomPosition?.toValue = 22
            boomPosition?.springBounciness = 11
            boomPosition?.springSpeed = 18
            bottom.pop_addAnimation(boomPosition, forKey: "boomPosition")
        }
        
    }
    
    func showCloseFromAdd(){
        self.style = BCButtonStyle.Close.rawValue
        var ovalRoate = self.rotelayer.pop_animationForKey("ovalRoate") as? POPSpringAnimation
        ovalRoate = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
        ovalRoate!.toValue = M_PI_4
        
        ovalRoate!.springBounciness = 11
        ovalRoate!.springSpeed = 18
        self.rotelayer.pop_addAnimation(ovalRoate, forKey: "ovalRoate")
        
    }
    
    func showAdd(){
        self.style = BCButtonStyle.Add.rawValue
        var ovalRoate = self.rotelayer.pop_animationForKey("ovalRoate") as? POPSpringAnimation
        ovalRoate = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
        ovalRoate!.toValue = M_PI_4*2
        
        ovalRoate!.springBounciness = 11
        ovalRoate!.springSpeed = 18
        self.rotelayer.pop_addAnimation(ovalRoate, forKey: "ovalRoate")
        
        
    }
    
    func showMenu(){
  
        self.style = BCButtonStyle.Menu.rawValue
        var topRoate = self.top.pop_animationForKey("topRoate") as? POPSpringAnimation
        var boomRoate = self.bottom.pop_animationForKey("boomRoate") as? POPSpringAnimation
        
        var topPosition = self.top.pop_animationForKey("topPosition") as? POPSpringAnimation
        var boomPosition = self.bottom.pop_animationForKey("boomPosition") as? POPSpringAnimation
        
        
        
        self.middle.backgroundColor = themeColor.CGColor
        
        
        
        
        
        
        if topRoate != nil {
            topRoate!.toValue = 0
        }else{
            topRoate = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
            topRoate!.toValue = 0
            topRoate!.springBounciness = 11
            topRoate!.springSpeed = 18
            self.top.pop_addAnimation(topRoate, forKey: "topRoate")
        }
        
        
        
        
        
        if boomRoate != nil {
            boomRoate!.toValue = 0
        }else{
            boomRoate = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
            boomRoate!.toValue = 0
            boomRoate!.springBounciness = 2
            boomRoate!.springSpeed = 18
            self.bottom.pop_addAnimation(boomRoate, forKey: "boomRoate")
        }
        
        
        
        
        if topPosition != nil {
            topPosition?.toValue = 0
        }else{
            topPosition = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            
            topPosition?.toValue = 16
            topPosition?.springBounciness = 11
            topPosition?.springSpeed = 18
            top.pop_addAnimation(topPosition, forKey: "topPosition")
        }
        
        
        if boomPosition != nil {
            boomPosition?.toValue = 0
        }else{
            boomPosition = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            
            boomPosition?.toValue = 28
            boomPosition?.springBounciness = 11
            boomPosition?.springSpeed = 18
            bottom.pop_addAnimation(boomPosition, forKey: "boomPosition")
        }
        
    }

    
}


