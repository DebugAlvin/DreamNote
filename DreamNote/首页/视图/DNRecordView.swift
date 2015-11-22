//
//  DNRecordView.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/11.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit
import AVFoundation
class DNRecordView: UIView,AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    var recorder:AVAudioRecorder? //录音器
    var player:AVAudioPlayer? //播放器
    var recorderSeetingsDic:[NSObject:AnyObject]? //录音器设置参数数组
    var volumeTimer:NSTimer! //定时器线程，循环监测录音的音量大小
    var aacPath:String? //录音存储路径
    
    var duration:Int!
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        recordButton.addTarget(self, action: Selector("startRecordAction:"), forControlEvents: UIControlEvents.TouchDown)
        
        recordButton.addTarget(self, action: Selector("stopRecordAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
      /*  switch EquipmentType {
            
        case iPhone6Plus:
            durationY.constant = -32
            durationLabel.font = UIFont.systemFontOfSize(14)
            
            break
        default:
            break
            
            
        }*/
        
        //初始化录音器
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        //用于获取失败原因
        var error:NSError?
        //设置录音类型
        
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
        //设置支持后台
        session.setActive(true, error: &error)
        //获取Document目录
        let docDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)[0] as! String
        //组合录音文件路径
        aacPath = docDir + "/play.raw"
        //初始化字典并添加设置参数
        recorderSeetingsDic = Dictionary()
        recorderSeetingsDic!.updateValue(NSNumber(long: kAudioFormatLinearPCM), forKey: AVFormatIDKey)
        //录音器每秒采集的录音样本数
        recorderSeetingsDic!.updateValue(NSNumber(long: 44100), forKey: AVSampleRateKey)
        //录音的声道数，立体声为双声道
        recorderSeetingsDic!.updateValue(NSNumber(long: 2), forKey: AVNumberOfChannelsKey)
        //采样位数
        recorderSeetingsDic!.updateValue(NSNumber(long: 16), forKey: AVLinearPCMBitDepthKey)
        //大端还是小段，是内存的组织方式
        recorderSeetingsDic!.updateValue(NSNumber(bool: false), forKey: AVLinearPCMIsBigEndianKey)
        //采样信号是整数还是浮点
        recorderSeetingsDic!.updateValue(NSNumber(bool: false), forKey: AVLinearPCMIsFloatKey)
    }
    
    
    
    
    
    
    func startRecordAction(sender: AnyObject) {
        
        var error:NSError?
        //初始化录音器
        //初始化录音器
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        //用于获取失败原因
        //设置录音类型
        
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
        recorder = AVAudioRecorder(URL: NSURL(string: aacPath!),
            settings: recorderSeetingsDic, error: &error)
        
        if recorder != nil {
            recorder?.delegate = self
            //开启仪表计数功能
            recorder!.meteringEnabled = true
            //准备录音
            recorder!.prepareToRecord()
            //开始录音
            recorder!.record()
            //启动定时器，定时更新录音音量
            volumeTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self,
                selector: "levelTimer", userInfo: nil, repeats: true)
        }
    }
    
    func stopRecordAction(sender: AnyObject) {
        
        //停止录音
        recorder?.stop()
        //录音器释放
        recorder = nil
        //暂停定时器
        volumeTimer.invalidate()
        volumeTimer = nil

        //durationLabel.hidden = false
        player = AVAudioPlayer(contentsOfURL: NSURL(string: aacPath!), error: nil)
        if player != nil {
            self.duration = Int(player!.duration)
            
            if duration >= 2{
                playButton.hidden = false
                recordButton.hidden = true
            }else{
               let alertView = UIAlertView(title: "提示", message: "录音时长少于2秒", delegate: self, cancelButtonTitle: "确定")
                alertView.show()
            }
        }
        
        
        
        //AVURLAsset(URL: fileUrl, options: nil)
        //let wavAsset = [AVURLAsset URLAssetWithURL:fileUrl options:nil];
        
        //println(recorder?.currentTime)
        //println(recorder?.deviceCurrentTime)
    }
    
    
    //定时检测录音音量
    func levelTimer(){
        recorder!.updateMeters() // 刷新音量数据
        let averageV:Float = recorder!.averagePowerForChannel(0) //获取音量的平均值
        let maxV:Float = recorder!.peakPowerForChannel(0) //获取音量最大值
        let lowPassResult:Double = pow(Double(10), Double(0.05*maxV))
    }
    
    
    @IBAction func playAction(sender: AnyObject) {
        let audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayback, error: nil)
        //删除录音缓存
        recorder?.deleteRecording()
        var error:NSError?
        //播放
        player = AVAudioPlayer(contentsOfURL: NSURL(string: aacPath!), error: &error)
        if player == nil {
            print("播放失败：\(error?.description)")
        }else{
            player?.play()
        }
    }
    
    
    func saveVoice(sPath:String,fileName:String) -> String{
        let fm = NSFileManager.defaultManager()

        var fullPath = NSHomeDirectory().stringByAppendingPathComponent(
            "Documents").stringByAppendingPathComponent(fileName)
        fm.copyItemAtPath(sPath, toPath: fullPath, error: nil)
        
        return fullPath
    }
    
    
    func getVioce()->DNVoice?{
        
        var result:DNVoice?
        if duration != nil {
            result = DNVoice()
            result!.duration = duration
            let date = NSDate(timeIntervalSinceNow: 0)
            let time = date.timeIntervalSince1970
            result!.voiceName = "\(Int(time))"
            result!.voiceType = "raw"
            
            let savaPath = saveVoice(aacPath!, fileName: "\(Int(time)).raw")
            result!.voicePath = savaPath
        }
        
        return result
    }
    
    @IBAction func clearAction(sender: AnyObject) {
        playButton.hidden = true
        recordButton.hidden = false
        //durationLabel.hidden = true
    }
}
