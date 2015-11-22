//
//  DNAlarmTaskCell.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/13.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit

class DNAlarmTaskCell: UITableViewCell {


    @IBOutlet weak var tipsPosision: NSLayoutConstraint!
    @IBOutlet weak var timePosision: NSLayoutConstraint!
    @IBOutlet weak var stateButton: UIButton!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        switch EquipmentType {
            
        case iPhone6Plus:
            tipsPosision.constant = -15
            timePosision.constant = 15
            break
        default:
            break
        }
        
    }
    func setState(falge:Bool){
        
        if falge == false {
            stateButton.setImage(UIImage(named: "震动黄"), forState: UIControlState.Normal)
        }else{
            stateButton.setImage(UIImage(named: "闹铃"), forState: UIControlState.Normal)
        }
        
    }
    
    class func heightForRow() -> CGFloat {
        
        var height:CGFloat = 75

        switch EquipmentType {
            
        case iPhone6Plus:
            height = height * autoSizeScaleY
            break
        default:
            break
        }
        
        
        return height
        
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
