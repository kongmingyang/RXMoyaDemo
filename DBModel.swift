//
//  DBModel.swift
//  SwiftDemo
//
//  Created by 55it on 2018/11/13.
//  Copyright © 2018年 55it. All rights reserved.
//

import UIKit


struct  Language: Codable {
    var channel_id : String?
    var name : String?
    var abbr_en : String?
    var seq_id : Int?
    var name_en : String?
    
}

struct ListCode: Codable {
    
    var channels :[Language]?
    
}
