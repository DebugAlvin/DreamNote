//
//  DNDreamListViewController.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/11.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit

class DNDreamListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,DNDeamListCellDelegate {
    
    @IBOutlet weak var _tableView: UITableView!

    var foodView:DNDreamFoodView!
    var _dreamArry:NSMutableArray! = []
    @IBOutlet weak var adddreamView: UIView!
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func showAddDreamAction(sender: DNHanbergerButton) {
        
        
        if sender.style == BCButtonStyle.Add.rawValue{
            sender.showCloseFromAdd()
            //taskView.hidden = false
          //  _tableView.hidden = true
            //dreamButton.hidden = true
            //dreaListView.hidden = true
        }else{
            sender.showAdd()
            //taskView.hidden = true
           // _tableView.hidden = false
           // dreamButton.hidden = false
            //dreaListView.hidden = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let dreamArry = DNDataBaseManager.findDreamAll()
        
        if dreamArry != nil {
            if _tableView != nil {
                if dreamArry?.count > 0 {
                    self._dreamArry = dreamArry
                    _tableView.reloadData()
                     setFoodView()
                }else{
                  _tableView.tableFooterView = UIView()
                    setFoodView()
                }

            }
        }
  

        
    }
    
    
    func setFoodView(){
        if _tableView != nil {
            if _dreamArry?.count > 0 {
                
                
                var maxHeight:CGFloat = screenHeight - 83
                var currentHeight:CGFloat = 0
                let dreamArry:[DNDream] = _dreamArry.copy() as! [DNDream]
                for index in dreamArry {
                    currentHeight += DNDeamListCell.heightForRow(index.contenText, voice: index.voice, picArry: index.pictureArry)
                    if currentHeight > maxHeight {
                        break
                    }
                }
                if currentHeight < maxHeight {
                    foodView.frame = CGRectMake(0, 0, screenWidth, maxHeight - currentHeight)
                    _tableView.tableFooterView = foodView
                }else{
                    _tableView.tableFooterView = UIView()
                }
                
                
            }else{
                _tableView.tableFooterView = UIView()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      //  _tableView.registerClass(DNDeamListCell.self, forCellReuseIdentifier: "cell")
        foodView = (NSBundle.mainBundle().loadNibNamed("DNDreamFoodView", owner: self, options: nil) as NSArray).objectAtIndex(0) as! DNDreamFoodView
        foodView.frame = CGRectMake(0, 0, screenWidth, 1000)
      

        //_tableView.tableFooterView = foodView
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        /*if _dreamArry?.count > 0 {
         _tableView.tableFooterView = foodView
        }else{
        _tableView.tableFooterView = UIView()
        }*/
        
        return _dreamArry.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! DNDeamListCell
        
        let dream = _dreamArry.objectAtIndex(indexPath.row) as! DNDream
        
        cell.setUI(dream.createTime.integerValue, content: dream.contenText,voice: dream.voice,picArry: dream.pictureArry)
        cell.vc = self
        cell.delegate = self
        cell.index = indexPath.row
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    func didDeleteCell(index: Int) {
        let dream = _dreamArry.objectAtIndex(index) as! DNDream
        DNDataBaseManager.deleteDream(dream)
        _dreamArry.removeObjectAtIndex(index)
        _tableView.reloadData()
        setFoodView()
    }
    /*func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var fView:UIView!
        if _dreamArry?.count > 0 {
             fView = self.foodView
        }else{
             fView = UIView()
        }
        
        
        return fView
    }*/
    
    /*func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{
        
        return foodView
    }*/
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let dream = _dreamArry.objectAtIndex(indexPath.row) as! DNDream
        return DNDeamListCell.heightForRow(dream.contenText, voice: dream.voice,picArry: dream.pictureArry)
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
