//
//  DNTimeRingCell.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/2.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit

class DNTimeRingCell: UITableViewCell {
    
    @IBOutlet weak var qiwenIco: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeLabelPosision: NSLayoutConstraint!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        switch EquipmentType {
        case iPhone6Plus:
            timeLabelPosision.constant = -200
            timeLabel.font = UIFont.systemFontOfSize(90)
            dateLabel.font = UIFont.systemFontOfSize(14)
            qiwenIco.titleLabel?.font = UIFont.systemFontOfSize(17)
            break
        default:
            break
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func heightForRow() -> CGFloat {
        return 410 * autoSizeScaleY
        
    }

}
