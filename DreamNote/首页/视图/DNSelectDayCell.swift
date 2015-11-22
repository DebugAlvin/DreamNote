//
//  DNSelectDayCell.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/13.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit

class DNSelectDayCell: UITableViewCell {

    @IBOutlet weak var gzrLabel: UIButton!

    @IBOutlet weak var zhoumoLabel: UIButton!
    @IBOutlet weak var meitianLabel: UIButton!
    
    @IBOutlet var dayArry: [UIButton]!
    
    
    
    @IBAction func dayAction(sender: UIButton) {
        meitianLabel.selected = false
        gzrLabel.selected = false
        zhoumoLabel.selected = false
        if sender.selected == true {
            sender.selected = false
        }else{
            sender.selected = true
        }
        
    }
    
    func selSelect(sArry:NSArray){
     
    
        for index in sArry{
            for button in dayArry {
                if button.tag == (index as! Int){
                    button.selected = true
                }
            }
        }
    
    }
    
    func getSelect() -> NSMutableArray {
        var arry:NSMutableArray = []
        var index = 1
        for button in dayArry {
        
            if button.selected == true {
                arry.addObject(index)
            }
            index++
        
        }
        return arry
    }
    
    @IBAction func meitinAction(sender: UIButton) {
        
        if sender.selected == true {
            sender.selected = false
            for button in dayArry {
                button.selected = false
            }
        }else{
            sender.selected = true
            gzrLabel.selected = false
            zhoumoLabel.selected = false
            for button in dayArry {
                button.selected = true
            }
        }
        
        
    }
    
    @IBAction func zhoumoAction(sender: UIButton) {
        if sender.selected == true {
            sender.selected = false
            for button in dayArry {
                button.selected = false
            }
        }else{
            sender.selected = true
            gzrLabel.selected = false
            meitianLabel.selected = false
            for button in dayArry {
                //button.selected = true
                
                if button.titleLabel?.text == "周日" || button.titleLabel?.text == "周六"{
                
                    button.selected = true
                
                }else{
                    button.selected = false
                }
                    
                    
            }
        }
        
    }
    @IBAction func gzrAction(sender: UIButton) {
        
        if sender.selected == true {
            sender.selected = false
            for button in dayArry {
                button.selected = false
            }
        }else{
            sender.selected = true
            zhoumoLabel.selected = false
            meitianLabel.selected = false
            for button in dayArry {
                //button.selected = true
                
                if button.titleLabel?.text == "周日" || button.titleLabel?.text == "周六"{
                    
                    button.selected = false
                    
                }else{
                    button.selected = true
                }
                
                
            }
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
