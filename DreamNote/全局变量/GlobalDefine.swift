//
//  File.swift
//  ISchool
//
//  Created by Alvin on 15/1/4.
//  Copyright (c) 2015年 Alvin. All rights reserved.
//

import Foundation
import UIKit


///
/// 与设备相关的常量
///
/// 获取屏幕的宽和高
let screenWidth = UIScreen.mainScreen().bounds.width
let screenHeight = UIScreen.mainScreen().bounds.height

/// 获取状态栏的高度
let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height

/// 获取导航条的高度
let navigationBarHeight:CGFloat = 44.0

// 中间可以显示的区域的高度
let middleScreenHeight = screenHeight - screenHeight - navigationBarHeight - 49

/// 导航颜色
let navColor = UIColor(red: 192.0 / 255.0, green: 37.0 / 255.0, blue: 62.0 / 255.0, alpha: 1.0)

//商品详情导航栏颜色
let GDnavColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 0.2)

//app名称
var appName = "app"
var appVersion = ""

///
/// 与请求数据相关的定义
///
let networkErrorMsg = "网络不给力，请检查网络设置"
let loadingMsg = "加载中..."