//
//  DNAddDreamViewController.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/11.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit

class DNAddDreamViewController: UIViewController ,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    @IBOutlet var toolsButtonArry: [UIButton]!
    
    var addphotoView:DNAddPhotoView!
    @IBOutlet weak var boardView: UIView!
    var recordView:DNRecordView!
    var picker:UIImagePickerController!
    @IBOutlet weak var takephotoButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var recordViewButton: UIButton!
    @IBOutlet weak var keyboradButton: UIButton!
    @IBOutlet weak var boardY: NSLayoutConstraint!
    @IBOutlet weak var _textView: SZTextView!
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        _textView.resignFirstResponder()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if photoButton.selected == false {
            if recordViewButton.selected == false{
                if photoButton.selected == false{
                    _textView.becomeFirstResponder()
                    initKeyBoard()
                }
            }
        }
        
    }
    
    @IBAction func completeAction(sender: AnyObject) {
        
        
        
        if _textView.text.isEmpty != true {
            let dream = DNDream()
            
            let date = NSDate(timeIntervalSinceNow: 0)
            let time = date.timeIntervalSince1970
            dream.createTime = Int(time)
            dream.contenText = _textView.text
            
            
            let pictureArry = addphotoView.getPictureArry()
            
            if pictureArry != nil {
                dream.pictureArry = pictureArry!.copy() as! [DNPicture]
            }
            dream.voice = recordView.getVioce()
            
            DNDataBaseManager.addDream(dream/*,year: comps.year*/)
            //DNDataBaseManager.addYear(comps.year)
            self.navigationController?.popViewControllerAnimated(true)

        }else{
            let alerView = UIAlertView(title: "提示", message: "内容不能为空", delegate: self, cancelButtonTitle: "确定")
            alerView.show()
        }
        
    }
    
    @IBAction func keyboardAction(sender: AnyObject) {
        for button in toolsButtonArry{
            button.selected = false
        }
        self.keyboradButton.selected = true
        addphotoView.hidden = false
        recordView.hidden = false
        _textView.becomeFirstResponder()
    }
    @IBAction func recordViewAction(sender: AnyObject) {
        for button in toolsButtonArry{
            button.selected = false
        }
        addphotoView.hidden = true
        recordView.hidden = false
        self.recordViewButton.selected = true
        _textView.resignFirstResponder()
        
        
        
    }
    
    @IBAction func takephotoAction(sender: AnyObject) {
        for button in toolsButtonArry{
            button.selected = false
        }
        addphotoView.hidden = true
        recordView.hidden = true
        _textView.resignFirstResponder()
        takePhoto()
    }
    
    func takePhoto(){
        
        //资源类型为照相机
        let sourceType = UIImagePickerControllerSourceType.Camera
        
        //判断是否有相机
        if (UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear)){
            println("照相机")
            picker = UIImagePickerController()
            picker.delegate = self
            //设置拍照后的图片可被编辑
            picker.allowsEditing = true
            //资源类型为照相机
            picker.sourceType = sourceType
            self.presentViewController(picker, animated: true, completion: { () -> Void in
                
            })
            
            
        }else{
            println("没有照相机")
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        println("拍照结束")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func photoViewAction(sender: AnyObject) {
        for button in toolsButtonArry{
            button.selected = false
        }
        self.photoButton.selected = true
        _textView.resignFirstResponder()
        addphotoView.hidden = false
        recordView.hidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        recordView = (NSBundle.mainBundle().loadNibNamed("DNRecordView", owner: self, options: nil) as NSArray).objectAtIndex(0) as! DNRecordView
        recordView.frame = CGRectMake(0, 40, boardView.frame.width, boardView.frame.height - 40)
        boardView.addSubview(recordView)
        
        
        
        addphotoView = (NSBundle.mainBundle().loadNibNamed("DNAddPhotoView", owner: self, options: nil) as NSArray).objectAtIndex(0) as! DNAddPhotoView
        addphotoView.frame = CGRectMake(0, 40, boardView.frame.width, boardView.frame.height - 40)
        addphotoView.callVC = self
        boardView.addSubview(addphotoView)
        
    }
    
    
    //键盘相关
    func initKeyBoard() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardHide:", name: UIKeyboardWillHideNotification, object: nil)
        self.keyboradButton.selected = true
        //kbTooBar.putTextButton.becomeFirstResponder()
    }
    func keyboardShow(notification: NSNotification) {
        var userInfo:NSDictionary = notification.userInfo!
        var keyBoardRect: CGRect = userInfo.objectForKey(UIKeyboardFrameEndUserInfoKey)!.CGRectValue()
        var deltaY: CGFloat = keyBoardRect.size.height
        var duration = userInfo.objectForKey(UIKeyboardAnimationDurationUserInfoKey)!.floatValue
        
        
        println(keyBoardRect.size.height)
        boardY.constant = keyBoardRect.size.height + 40
        UIView.animateWithDuration(Double(duration), animations: { () -> Void in
            
        })
    }
    func keyboardHide(notification: NSNotification) {
        var userInfo:NSDictionary = notification.userInfo!
        var duration = userInfo.objectForKey(UIKeyboardAnimationDurationUserInfoKey)!.floatValue
        
        boardY.constant = 250 * autoSizeScaleY
        UIView.animateWithDuration(Double(duration), animations: { () -> Void in
            
            }) { (finished) -> Void in
                if(finished == true){
                    
                    
                }
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
