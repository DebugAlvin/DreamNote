//
//  DNWeather.swift
//  DreamNote
//
//  Created by 紫气东来 on 15/11/6.
//  Copyright (c) 2015年 紫气东来. All rights reserved.
//

import UIKit

class DNWeather: NSObject {
    var city : String!
    var updatetime : String!
    var wendu : String!
    var fengli : String!
    var shidu : String!
    var fengxiang : String!
    var forecast: [Forecast]!
    
    
}
class Forecast: NSObject {
    var date : String!
    var fengli : String!
    var fengxiang : String!
    var high : String!
    var low : String!
    var type : String!
}