//
//  DNView.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/12.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit
@IBDesignable
class DNView: UIView {

    
        @IBInspectable var cornerRadius: CGFloat = 0 {
            didSet {
                layer.cornerRadius = cornerRadius
                layer.masksToBounds = cornerRadius > 0
            }
        }
        @IBInspectable var borderWidth: CGFloat = 0 {
            didSet {
                layer.borderWidth = borderWidth
            }
        }
        @IBInspectable var borderColor: UIColor? {
            didSet {
                layer.borderColor = borderColor?.CGColor
            }
        }


}
