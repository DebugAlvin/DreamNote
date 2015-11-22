//
//  DNClockDateCell.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/3.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit

class DNClockDateCell: UITableViewCell,UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var datePicker: UIPickerView!
    lazy var hoursArr:[String] = {
        var arr = [String]()
        for i in 0..<24 {
            if i < 10 {
                arr.append("0\(i)")
            } else {
                arr.append("\(i)")
            }
        }
        return arr
        }()
    
    lazy var minutesArr:[String] = {
        var arr = [String]()
        for i in 0..<60 {
            if i < 10 {
                arr.append("0\(i)")
            } else {
                arr.append("\(i)")
            }
        }
        return arr
        }()
    
    var selectHour: String! = "07"
    var selectMinute: String! = "00"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //println("\((selectHour as NSString).integerValue)")
        
        //var hoursRow = ((10240 / 24)/2)*24  + (selectHour as NSString).integerValue
        //var minuteRow = ((10240 / 60)/2)*60  + (selectMinute as NSString).integerValue
        //datePicker.selectRow(hoursRow, inComponent: 0, animated: false)
        //datePicker.selectRow(minuteRow, inComponent: 1, animated: false)
        
        
    }
    
    func setUI(){
        var hoursRow = ((10240 / 24)/2)*24  + (selectHour as NSString).integerValue
        var minuteRow = ((10240 / 60)/2)*60  + (selectMinute as NSString).integerValue
        datePicker.selectRow(hoursRow, inComponent: 0, animated: false)
        datePicker.selectRow(minuteRow, inComponent: 1, animated: false)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10240//component == 0 ? hoursArr.count : minutesArr.count
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 64
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        
        var attributeDict = [NSForegroundColorAttributeName:UIColor.blueColor()]
        var attributedString = NSAttributedString(string: component == 0 ? hoursArr[row%24] : minutesArr[row%60], attributes: attributeDict)
        
        var labelView = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 21))
        labelView.textAlignment = .Center
        labelView.attributedText = attributedString
        labelView.textColor = UIColor(red: 51/255, green: 217/255, blue: 217/255, alpha: 1)
        labelView.font = UIFont.systemFontOfSize(20)
        
        return labelView
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            selectHour = "\(hoursArr[row%24])"
            println("\(hoursArr[row%24])小时")
        } else {
            selectMinute = "\(minutesArr[row%60])"
            println("\(minutesArr[row%60])分钟")
        }
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
