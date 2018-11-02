//
//  DouBanModel.swift
//  SwiftDemo
//
//  Created by 55it on 2018/11/1.
//  Copyright © 2018年 55it. All rights reserved.
//

import UIKit
import HandyJSON

//频道模型
struct Channels:HandyJSON {
    var  channels:[DouBanModel]?
   
}
//频道列表模型
struct DouBanModel:HandyJSON {
    var channel_id : String?
    var name : String?
    var abbr_en : String?
    var seq_id : Int?
    var name_en : String?
    
    
    
}

// 歌曲列表模型
struct Playlist:HandyJSON {
    var r: Int!
    var isShowQuickStart: Int!
    var song:[Song]!
    
}

//歌曲模型
struct Song: HandyJSON {
    var url : String!
    var title : String!
    var sid : String!
    var sha256 : String!
    var picture : String!
    var public_time :String!
    var all_play_sources : [Source]!
    
}
struct Source:HandyJSON {
  var source_full_name: String!
    var confidence: String!
    var file_url :String!
    var source : String!
    var source_id : String!
    var playable : String!
    var page_url : String!
    var albumtitle : String!
}
