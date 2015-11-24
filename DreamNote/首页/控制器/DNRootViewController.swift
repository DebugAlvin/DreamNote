//
//  ViewController.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/1.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit
import EventKit
import AVFoundation
class DNRootViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,BCLocationDelegate {
    
    var player:AVAudioPlayer!
    @IBOutlet weak var menuButton: DNHanbergerButton!
    @IBOutlet weak var addButton: DNHanbergerButton!
    @IBOutlet weak var _tableView: UITableView!
    var timer: NSTimer?
    var ringCell:DNTimeRingCell!
    var _alarmArry:[DNAlarm]!
    @IBOutlet weak var dreamView: UIView!
    @IBOutlet weak var addTakView: UIView!
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    @IBAction func addTaskAction(sender: DNHanbergerButton) {
        if sender.style == BCButtonStyle.Add.rawValue {
            sender.showCloseFromAdd()
            _tableView.hidden = true
            addTakView.hidden = false
            menuButton.hidden = true
            dreamView.hidden = true
        }else{
            sender.showAdd()
            _tableView.hidden = false
            addTakView.hidden = true
            menuButton.hidden = false
            dreamView.hidden = true
        }

    }
    
    @IBAction func dreaListAction(sender: DNHanbergerButton) {
        
        
        
        if sender.style == BCButtonStyle.Menu.rawValue {
            sender.showClose()
            _tableView.hidden = true
            dreamView.hidden = false
            addTakView.hidden = true
            addButton.hidden = true
        }else{
            sender.showMenu()
            _tableView.hidden = false
            dreamView.hidden = true
            addTakView.hidden = true
            addButton.hidden = false
        }
        
    }
    
    
    func didLocationSccess(location:BCLocation){
        DNHttpTool.getWeatherByCityName(location.cityName, completion: { (weather) -> Void in
            
            
            if weather != nil {
                if self.ringCell != nil {
                    
                    let weatherType = weather!.forecast[0].type
                    self.ringCell.qiwenIco.setTitle("  \(weather!.wendu)°C", forState: UIControlState.Normal)
                    self.ringCell.qiwenIco.setImage(UIImage(named: "\(Utility.getWeatherImageName(weatherType))"), forState: UIControlState.Normal)
                }
                
                
            }
        })
    }
    func didLocationFailure(latitude:String,longitude:String){
        
    }
    func didLocationError(){
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        BCLocation.newInstance().delegate = self
        
        let alarmArry = DNDataBaseManager.findAlarmAll()
        
        if alarmArry != nil {
            _alarmArry = alarmArry
            _tableView.reloadData()
        }
        
        
        
    }
    
    
    
    func createTimeTread(){
        
        if timer == nil{
            updateTime()
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        }
        
    }
    
    
    func updateTime(){
        let calendar = NSCalendar.currentCalendar()
        let flags: NSCalendarUnit = NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitWeekday
        //设置格式
        let now = NSDate()
        let comps = calendar.components(flags, fromDate: now)
        
        
        if ringCell != nil {
            ringCell.timeLabel.text = Utility.formatTime(comps.hour, minute: comps.minute)
            ringCell.dateLabel.text = "\(comps.year)-\(comps.month)-\(comps.day) \(Utility.formatWeekDay(comps.weekday))"
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        //需要接收通知的类都要先注册一下
        NSThread.sleepForTimeInterval(3.0)//延长3秒，这么漂亮的启动图片应该多看一些吧＝ ＝
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("playAlarm:"), name: "audioClass", object: nil)

    }
    
    func playAlarm(notifiy:NSNotification){
        //字典不为空可以强制解包
        
        if notifiy.userInfo != nil {
            
            println(notifiy.userInfo!)
            let alerl = SCLAlertView()
            alerl.showCustom(self,image: UIImage(named: "git"), color: UIColor.grayColor(), title: "提示", subTitle: "趁大梦初醒赶快纪录梦境吧~!", closeButtonTitle: "确定", duration: 100)
            
            
            let josnString = (notifiy.userInfo as! AnyObject).objectForKey("key") as! String
            let alarm = DNAlarm.mj_objectWithKeyValues(josnString)
            palayMusic("\(alarm.ringName)", type: "wav")
            
            alerl.alertIsDismissed { () -> Void in
                self.player.stop()
            }
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        
        if(indexPath.row != 0){
            cell = tableView.dequeueReusableCellWithIdentifier("cell2") as! DNAlarmTaskCell
            
            let alarm = _alarmArry[indexPath.row-1]
            
            (cell as! DNAlarmTaskCell).timeLabel.text = "\(alarm.hours):\(alarm.minute)"
            (cell as! DNAlarmTaskCell).tipsLabel.text = alarm.tips
            (cell as! DNAlarmTaskCell).setState(alarm.isShock.boolValue)
        }else{
            cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! DNTimeRingCell
            ringCell = cell as! DNTimeRingCell
            createTimeTread()
            
        }
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var cellHeight:CGFloat = 0
        if(indexPath.row == 0){
            cellHeight = 410 * autoSizeScaleY
        }else{
            cellHeight = DNAlarmTaskCell.heightForRow()
        }
        
        return cellHeight
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _alarmArry.count + 1
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //编辑已经添加的时间控件
        if(indexPath.row >= 1){
            let alarm = _alarmArry[indexPath.row - 1]
            self.performSegueWithIdentifier("editAlarmSegue", sender: alarm)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
        
    }
    
    
    func palayMusic(musicName:String,type:String){
        
        
        
        let audioSession = AVAudioSession.sharedInstance()
        var categoryError:NSError?
        var activeError:NSError?
        audioSession.setCategory(AVAudioSessionCategoryPlayback, error: &categoryError)
        audioSession.setActive(true, error: &activeError)
        //UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        let musicFilePath = NSBundle.mainBundle().pathForResource(musicName, ofType: type)
        
        
        
        if NSFileManager.defaultManager().fileExistsAtPath(musicFilePath!) {
            let urlPath = NSURL.fileURLWithPath(musicFilePath!)
            var error:NSError?
            player =  AVAudioPlayer(contentsOfURL: urlPath, error: &error)
            println(error)
            player.numberOfLoops = -1
            player.play()
            
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier != nil {
            
            if segue.identifier == "editAlarmSegue" {
                
                
                let vc = segue.destinationViewController as! DNAlarmClockViewController
            
                vc._alarm = sender as! DNAlarm
            }
            
        }
        
        
    }

    
    
}

