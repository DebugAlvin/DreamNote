//
//  DNAlarmClockViewController.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/3.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit

class DNAlarmClockViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,DNSelectRingDelegate {
    
    @IBOutlet weak var letftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    var _alarm:DNAlarm!
    @IBOutlet weak var _tableView: UITableView!

    var clockDate:DNClockDateCell!
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    var selectRing:String = "big big world"
    var tipsFiled:UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if _alarm != nil {
            rightButton.setTitle("删除", forState: UIControlState.Normal)
            letftButton.setImage(UIImage(named: "修改"), forState: UIControlState.Normal)
            selectRing = _alarm.ringName
        }
    }

    
    @IBAction func backAction(sender: AnyObject) {
        if _alarm != nil {
            if tipsFiled != nil {
                _alarm.tips = tipsFiled.text
            }else{
                _alarm.tips = "周末打豆豆～！"
            }

            _alarm.hours = clockDate.selectHour
            _alarm.minute = clockDate.selectMinute
            
            let cell3 = _tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as! DNAlarmClockCell3
            _alarm.isShock = NSNumber(bool: cell3.switchButton.selected)
            
            _alarm.ringName = selectRing
            
            let cell2 = _tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! DNSelectDayCell
            
            _alarm.cycle = cell2.getSelect().copy() as! [NSNumber]
            
            DNLocalNotification.cancelAlarm(_alarm)
            DNDataBaseManager.deleteAlarm(_alarm)
            
            DNDataBaseManager.addAlarm(_alarm)
            DNLocalNotification.addAlarm(_alarm)
            
            
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func complateAtion(sender: AnyObject) {
        
        
        if _alarm == nil {
            
            let alarm = DNAlarm()
            alarm.ringName = selectRing
            
            if tipsFiled != nil {
                alarm.tips = tipsFiled.text
            }else{
                alarm.tips = "周末打豆豆～！"
            }
            
            
            //let cell = _tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as! DNClockDateCell
            
            
            let date = NSDate(timeIntervalSinceNow: 0)
            let time = date.timeIntervalSince1970
            
            alarm.identifier = "\(time)"
            
            alarm.hours = clockDate.selectHour
            alarm.minute = clockDate.selectMinute
            
            let cell3 = _tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as! DNAlarmClockCell3
            alarm.isShock = NSNumber(bool: cell3.switchButton.selected)
            
            
            
            let cell2 = _tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! DNSelectDayCell
            
            alarm.cycle = cell2.getSelect().copy() as! [NSNumber]
            DNDataBaseManager.addAlarm(alarm)
            DNLocalNotification.addAlarm(alarm)
            
        }else{
            
            DNLocalNotification.cancelAlarm(_alarm)
            DNDataBaseManager.deleteAlarm(_alarm)
            
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        
        if indexPath.row == 0 {
            cell =  tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! DNClockDateCell
            clockDate = cell as! DNClockDateCell
            if _alarm != nil {
                (cell as! DNClockDateCell).selectHour = _alarm.hours
                (cell as! DNClockDateCell).selectMinute = _alarm.minute
                
            }else{
                (cell as! DNClockDateCell).selectHour = "07"
                (cell as! DNClockDateCell).selectMinute = "30"
            }
            clockDate.setUI()
        }else if indexPath.row == 1 {
            cell = tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as! DNSelectDayCell
            if _alarm != nil {
            (cell as! DNSelectDayCell).selSelect(_alarm.cycle)
            
            }
        }else if indexPath.row == 2 {
            cell = tableView.dequeueReusableCellWithIdentifier("cell3", forIndexPath: indexPath) as! UITableViewCell
        }else if indexPath.row == 3 {
            cell = tableView.dequeueReusableCellWithIdentifier("cell4", forIndexPath: indexPath) as! DNSTpisCell
            if _alarm != nil {
             (cell as! DNSTpisCell).tipsLabel.setTitle("\(_alarm.tips)", forState: UIControlState.Normal)
            }
        }else{
            cell = tableView.dequeueReusableCellWithIdentifier("cell5", forIndexPath: indexPath) as! DNAlarmClockCell5
            (cell as! DNAlarmClockCell5).ringLabel.text = selectRing

        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 4 {
            self.performSegueWithIdentifier("selectRingSegue", sender: nil)
        }
        
        if indexPath.row == 3 {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as! DNSTpisCell
            let alertView = TYAlertView(title: "添加标签", message: "")
            
            alertView.addAction(TYAlertAction(title: "确定", style: TYAlertActionStyle.Destructive, handler: { (action:TYAlertAction!) -> Void in
                
                cell.tipsLabel.setTitle(self.tipsFiled.text, forState: UIControlState.Normal)
            }))
            alertView.addAction(TYAlertAction(title: "取消", style: TYAlertActionStyle.Cancle, handler: { (action:TYAlertAction!) -> Void in
                
            }))
            
            alertView.addTextFieldWithConfigurationHandler({ (textfield:UITextField!) -> Void in
                textfield.text = cell.tipsLabel.titleLabel?.text
                self.tipsFiled = textfield
                textfield.becomeFirstResponder()
            })
            let alertController = TYAlertController(alertView: alertView, preferredStyle: TYAlertControllerStyle.Alert)
            
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var cellHeight:CGFloat = 0
        if indexPath.row == 0 {
            cellHeight = 213
        }else if indexPath.row == 1{
            cellHeight = 110
        }else {
            cellHeight = 64
        }
        
        
        
        return cellHeight
    }
    
    
    func didReplayceRingName(name:String){
        selectRing = name
        
        
        //NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
        // [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        
        let  indexPath = NSIndexPath(forRow: 4, inSection: 0)
        _tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier != nil {
            
            if segue.identifier == "selectRingSegue" {
                
                
                let vc = segue.destinationViewController as! DNSelectRingViewController
                vc.selectRingName = selectRing
                vc.delegate = self
            }
            
        }
        
        
    }
    
    
}
