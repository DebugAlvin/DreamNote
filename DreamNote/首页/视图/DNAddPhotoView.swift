//
//  DNAddPhotoView.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/8.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit

class DNAddPhotoView: UIView,QBImagePickerControllerDelegate {
    
    
    var callVC:UIViewController!
    @IBOutlet weak var addButton: UIButton!
    var imageArry:NSMutableArray! = []
    var imageNameArr:NSMutableArray! = []
    @IBOutlet var imageViewArry: [UIImageView]!
    
    @IBAction func addphotoAction(sender: AnyObject) {
        
        var imagePickerController = QBImagePickerController()
        imagePickerController.filterType = QBImagePickerControllerFilterType.Photos
        imagePickerController.allowsMultipleSelection = true
        imagePickerController.maximumNumberOfSelection = UInt(5)
        imagePickerController.delegate = self
        imagePickerController.title = "选择图片"
        
        let navController = UINavigationController(rootViewController: imagePickerController)
        
        
        imageArry = []
        callVC.presentViewController(navController, animated: true, completion: nil)
        
    }
    
    // MARK: - QBImagePickerControllerDelegate
    func imagePickerController(imagePickerController: QBImagePickerController!, didSelectAssets assets: [AnyObject]!) {
        
        
        var picArr: NSMutableArray = []
        var nameArr: NSMutableArray = []
        for i in 0..<assets.count {
            var picUrl:ALAsset = assets[i] as! ALAsset
            var image = imageWithALAssert(picUrl, imageName: "customImageName\(i).jpg")
            picArr.addObject(image)
            nameArr.addObject("customImageName\(i).jpg")
        }
        imageArry.addObjectsFromArray(picArr as [AnyObject])
        imageNameArr.addObjectsFromArray(nameArr as [AnyObject])
        
        for i in 0..<imageViewArry.count {
            
            imageViewArry[i].hidden = true
            
        }
        for i in 0..<imageArry.count {
            var image = imageArry.objectAtIndex(i) as! UIImage
            imageViewArry[i].hidden = false
            imageViewArry[i].image = image
            
        }
        addButton.frame.origin = imageViewArry[imageArry.count].frame.origin
        
        dismissImagePickerController()
    }
    func imagePickerControllerDidCancel(imagePickerController: QBImagePickerController!) {
        dismissImagePickerController()
    }
    /// ALAssert转Image
    func imageWithALAssert(result: ALAsset, imageName: String) -> UIImage {
        var assetRep: ALAssetRepresentation = result.defaultRepresentation()
        
        var iref = assetRep.fullResolutionImage().takeUnretainedValue()
        var image =  UIImage(CGImage: iref)!
        
        let newImage = imageWithImage(image, scaledToSize: image.size)
        let imageData = UIImageJPEGRepresentation(newImage, 1)
        
        let fullPath = NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent(imageName)
        
        imageData.writeToFile(fullPath, atomically: false)
        
        return newImage
    }
    /// 对图片尺寸进行压缩
    func imageWithImage(image: UIImage, scaledToSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(scaledToSize)
        image.drawInRect(CGRectMake(0, 0, scaledToSize.width, scaledToSize.height))
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    func dismissImagePickerController() {
        if (callVC.presentedViewController != nil) {
            callVC.dismissViewControllerAnimated(true, completion: nil)
        } else {
            
        }
    }
    
    
    func saveImage(currentImage:UIImage,imageName:String){
        let imageData = UIImageJPEGRepresentation(currentImage, 0.5)
        var fullPath = NSHomeDirectory().stringByAppendingPathComponent(
            "Documents").stringByAppendingPathComponent(imageName)

        
        imageData.writeToFile(fullPath, atomically: false)
    }
    
    func getPictureArry() ->NSMutableArray?{
        
        
        var images:NSMutableArray?
        
        if self.imageArry.count > 0{
            images = []
            for index in 1...self.imageArry.count {
                
                let picture = DNPicture()
                
                
                var image = self.imageArry.objectAtIndex(index-1) as! UIImage
                
                picture.width = image.size.width
                picture.height = image.size.height
                let date = NSDate(timeIntervalSinceNow: 0)
                let time = date.timeIntervalSince1970
                picture.pictureName = "\(Int(time))\(index)"
                picture.pictureType = "jpg"
                saveImage(image, imageName: picture.pictureName)
                var fullPath = NSHomeDirectory().stringByAppendingPathComponent(
                    "Documents").stringByAppendingPathComponent(picture.pictureName+".jpg")
                picture.picturePath = fullPath
                images!.addObject(picture)
                
                
            }
            
            
        }
        
        return images
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    
    
}
