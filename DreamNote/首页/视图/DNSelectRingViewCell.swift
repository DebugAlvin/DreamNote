//
//  DNSelectRingViewCell.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/10.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit

class DNSelectRingViewCell: UITableViewCell {

    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var ringName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        if selected == true {
            ringName.textColor = UIColor(red: 51/255, green: 217/255, blue: 217/255, alpha: 1)
            selectButton.hidden = false
        }else{
            ringName.textColor = UIColor.whiteColor()
            selectButton.hidden = true
        }
        
    }

}
