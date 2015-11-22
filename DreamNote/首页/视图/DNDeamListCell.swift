//
//  DNDeamListCell.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/11.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit
import AVFoundation

protocol DNDeamListCellDelegate {
    func didDeleteCell(index:Int)
}

class DNDeamListCell: UITableViewCell {

  
    @IBOutlet weak var qgleft: NSLayoutConstraint!
    @IBOutlet weak var gqheight: NSLayoutConstraint!
    @IBOutlet weak var gqwidth: NSLayoutConstraint!
    var delegate:DNDeamListCellDelegate?
    var index:Int!
    var vc:UIViewController!
    @IBOutlet weak var conView: DNView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var voiceHeight: NSLayoutConstraint!
    @IBOutlet weak var contentLabel: UILabel!
    var recorder:AVAudioRecorder? //录音器
    var player:AVAudioPlayer? //播放器
    var voice:DNVoice!
    @IBOutlet weak var voiceView: DNView!
    @IBOutlet weak var picView: UIView!

    @IBOutlet weak var contentTop: NSLayoutConstraint!
    @IBOutlet weak var contentBoom: NSLayoutConstraint!

    func setUI(createTime:Int,content:String?,voice:DNVoice?,picArry:NSArray?){
        
        if content != nil {
            contentLabel.text = content
        }else{
            
        }
        
        
        timeLable.text = Utility.formatCreatTime(createTime)
        println(contentLabel.text)
        if voice != nil {
            contentTop.constant = 4
            voiceHeight.constant = 44
            durationLabel.text = "\(voice!.duration)\""
            self.voice = voice
        }else{
            contentTop.constant = 0
            voiceHeight.constant = 0
        }

        for view in picView.subviews {
            
            view.removeFromSuperview()
        }
        
        if picArry != nil {
            
            var picViewHeight:CGFloat = 0
        
            //let picMaxWidth = screenWidth - 75
            for var index = 0; index < picArry!.count; ++index {
                let pic = picArry?.objectAtIndex(index) as! DNPicture
                let modifySize = Utility.formatImageSize(screenWidth - 55, maxHeight: 600, currentSize: CGSizeMake(CGFloat(pic.width.doubleValue) , CGFloat(pic.height.doubleValue)))
                
                
                
                
                println("原来的图片大小:\(pic.width) \(pic.height) 修正后的图片大小:\(modifySize)")
                var fullPath = NSHomeDirectory().stringByAppendingPathComponent(
                    "Documents").stringByAppendingPathComponent(pic.pictureName+".jpg")
                let image = UIImage(contentsOfFile: fullPath)
                

                let imageView = UIImageView(frame: CGRectMake(0, picViewHeight + 4, modifySize.width, modifySize.height))
                picViewHeight += modifySize.height + 4
                imageView.image = image
                picView.addSubview(imageView)
                println(imageView.frame)
                
               
            }
            contentBoom.constant = 4
        }else{
            picView.frame = CGRectMake(picView.frame.origin.x, picView.frame.origin.y, picView.frame.width, 0)
            contentBoom.constant = 0
        }
        
        
    }
    
    
    
    
    required init(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
  
        switch EquipmentType {
        case iPhone6Plus:
            gqwidth.constant = 34
            gqheight.constant = 34
            qgleft.constant = 1
            break
        default:
            break
        }
        
        
        let longPress1 = UILongPressGestureRecognizer(target: self, action: Selector("longPressToDo:"))
        longPress1.minimumPressDuration = 0.8

        self.contentView.addGestureRecognizer(longPress1)
        
        
        /*let longPress2 = UILongPressGestureRecognizer(target: self, action: Selector("longPressColor:"))
        longPress2.minimumPressDuration = 0.5
        
        self.contentView.addGestureRecognizer(longPress2)*/
        
        
        voiceView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("touchVoiceView")))
    }
    
    func longPressColor(gesture:UILongPressGestureRecognizer){
        if(gesture.state == UIGestureRecognizerState.Began)
        {
           conView.backgroundColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 0.3)
        }else if(gesture.state == UIGestureRecognizerState.Ended){
            conView.backgroundColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 0.2)
        }else{
            
        }
    }
    func longPressToDo(gesture:UILongPressGestureRecognizer){
        if(gesture.state == UIGestureRecognizerState.Began)
        {
            
           
            let alerl = SCLAlertView()
            alerl.showCustom(vc,image: UIImage(named: "git"), color: UIColor.grayColor(), title: "提示", subTitle: "您要删除这条梦境记录吗?", closeButtonTitle: nil, duration: 100000)
            
            
            let scButton = alerl.addButton("确定", actionBlock: { () -> Void in
                self.delegate?.didDeleteCell(index)
            })
            scButton.defaultBackgroundColor = UIColor.blackColor()
            
            let scButton2 = alerl.addButton("取消", actionBlock: { () -> Void in
                
            })
            scButton2.defaultBackgroundColor = UIColor.grayColor()
            
            
            alerl.alertIsDismissed { () -> Void in
                println("diss")
            }

        
        }else if(gesture.state == UIGestureRecognizerState.Ended){
            
        }else{
            
        }
    }
    
    func touchVoiceView(){
        println("按下了一次")
        
        let audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayback, error: nil)
        //删除录音缓存
        var error:NSError?
        //播放
        let fullPath = NSHomeDirectory().stringByAppendingPathComponent(
            "Documents").stringByAppendingPathComponent(voice.voiceName)
        player = AVAudioPlayer(contentsOfURL: NSURL(string: "\(fullPath).raw"), error: &error)
        if player == nil {
            print("播放失败：\(error?.description)")
        }else{
            player?.play()
        }

        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    class func heightForRow(content:String?,voice:DNVoice?,picArry:NSArray?) -> CGFloat {
        var cellHeight:CGFloat = 68
        
        if voice != nil {
            cellHeight += 48
        }
        
        if content != nil {
            let contentRect = Utility.stringHeightWith(content!, fontSize: 15, width: screenWidth - 75)
            cellHeight += contentRect.height
        }


        if picArry != nil {
            var picViewHeight:CGFloat = 8 + ((CGFloat(picArry!.count)) * 4)
            
            let picMaxWidth = screenWidth - 55
            for var index = 0; index < picArry!.count; ++index {
                //let pic = picArry![index]
                let pic = picArry?.objectAtIndex(index) as! DNPicture
                let modifySize = Utility.formatImageSize(picMaxWidth, maxHeight: 600, currentSize: CGSizeMake(CGFloat(pic.width.doubleValue) , CGFloat(pic.height.doubleValue)))
                
                
               // println("原来的图片大小:\(pic.width) \(pic.height) 修正后的图片大小:\(modifySize)")
                picViewHeight += modifySize.height
            }
            cellHeight += picViewHeight
        }
        
        
        return cellHeight
    }
}
