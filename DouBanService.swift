

//
//  DouBanService.swift
//  SwiftDemo
//
//  Created by 55it on 2018/11/1.
//  Copyright © 2018年 55it. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import HandyJSON

class DouBanNetworkService {
    
  public  var channelsubject = PublishSubject<[DouBanModel]>()
    public var playListSubject = PublishSubject<[Song]>()
    let disposeBag = DisposeBag()

    //获取频道列表
 public   func loadChannels() {
        
        var datas:[DouBanModel] = []
    
    
        
   DouBanProvider.rx.request(.channels).subscribe { (event) in
            
            switch event{
                
                
            case let .success(resonse):
                let str = String(data: resonse.data, encoding: String.Encoding.utf8)
                let channel = Channels.deserialize(from: str)
                datas = (channel?.channels)!
                self.channelsubject.onNext(datas)
            
               break
                
            case let .error(error):
                datas = []
                
                print(error)
                break
                
            }
            
        }.disposed(by: disposeBag)
 
    }
    
    //获取歌曲列表数据
    func loadPlayList(channelId:String) {
        DouBanProvider.rx.request(.playlist(channelId)).subscribe { (event) in
            switch event{
                
                
                
            case let .success(response):
                let str = String(data: response.data, encoding: String.Encoding.utf8)
                let platlist = Playlist.deserialize(from: str)
                let datas = platlist?.song!
                self.playListSubject .onNext(datas!)
        
          
                break
                
            case let .error(error):
                print(error)
                
                break
                
            }
            }.disposed(by: disposeBag)
        
    }
}


