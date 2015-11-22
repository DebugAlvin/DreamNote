//
//  DNSelectRingViewController.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/4.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit
import AVFoundation

protocol DNSelectRingDelegate{
    //代理方法
    func didReplayceRingName(name:String)
}

class DNSelectRingViewController:UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    
    @IBOutlet weak var _tableView: UITableView!
    
    var delegate:DNSelectRingDelegate?
    
    var selectRingName:String!
    
    var player:AVAudioPlayer!
    
    let songArry = ["big big world","Drifting","Loneliness-oshiro Masuda","My Soul","New Monring","Stepping on the Rainy Street","The-Sounds-Of-Silenc","未名花闻","群星-孤独的手风琴","天空之城","小提曲 - 古典","雪之华尔滋"]
    var _record:Bool!
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    @IBAction func complateAction(sender: AnyObject) {
        delegate?.didReplayceRingName(selectRingName)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
        _tableView.tableFooterView = UIView()
        
        
        var index = 0
        for song in songArry {
            if song == selectRingName {
               var indexPath = NSIndexPath(forRow: index, inSection: 0)
                _tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.None)
            }
            
            index++
        }
   
        
      
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! DNSelectRingViewCell
        
        let ringName = songArry[indexPath.row] as String
        
        cell.ringName.text = ringName

        cell.selectionStyle = UITableViewCellSelectionStyle.None

        
        
        //cell.selectionStyle = UITableViewCellSelectionStyle.Blue
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songArry.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let ringName = songArry[indexPath.row] as String
        selectRingName = ringName
        
        palayMusic(ringName, type: "wav")
    }
    
    
    func palayMusic(musicName:String,type:String){
 
        
        
        let audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayback, error: nil)
        let musicFilePath = NSBundle.mainBundle().pathForResource(musicName, ofType: type)
        
        
        if NSFileManager.defaultManager().fileExistsAtPath(musicFilePath!) {
            let urlPath = NSURL.fileURLWithPath(musicFilePath!)
            player =  AVAudioPlayer(contentsOfURL: urlPath, error: nil)
            player.numberOfLoops = -1
            player.play()
            
        }
        
    
    }
    
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
