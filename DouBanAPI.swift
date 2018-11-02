//
//  DouBanAPI.swift
//  SwiftDemo
//
//  Created by 55it on 2018/11/1.
//  Copyright © 2018年 55it. All rights reserved.
//

import UIKit
import Moya


let DouBanProvider = MoyaProvider<DouBanAPI>(plugins:[RequestAlertPlugin(viewController: (UIApplication.shared.keyWindow?.rootViewController)!)])


public enum DouBanAPI{
    
    case channels //获取频道列表
    case playlist(String) //获取歌曲
    case downloadAsset(assetName:String)
    
}
extension DouBanAPI:TargetType{
     //服务器地址
    public var baseURL:URL{
        switch self {
            //频道列表
        case .channels:
            return URL(string: "https://www.douban.com")!
            //歌曲列表
        case .playlist(_):
            return URL(string: "https://douban.fm")!
        //下载
        case .downloadAsset( _):
            return URL(string: "http://www.hangge.com")!
        }
        
        
    }

    //各个请求的具体路径
    public var path: String {
        switch self {
        case .channels:
            return "/j/app/radio/channels"
        case .playlist(_):
            return "/j/mine/playlist"
            
        case .downloadAsset( let assetName):
            return "/assets/\(assetName)"
    }
    }
    //请求类型
    public var method: Moya.Method {
        switch self {
        case .channels:
            return .get
        default:
            return .get
            
        }
     
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        switch self {
        case .playlist(let channel):
            
            var params:[String:Any] = [:]
            params["channel"] = channel
            params["type"] = "n"
            params["from"] = "mainsite"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        
        case .downloadAsset(_):
            return .downloadDestination(DefaultDownloadDestination)
        default:
            return .requestPlain
        }
    }
    
    
    //请求头
    public var headers: [String : String]? {
        return nil
    }
    
   
    
    
}




//定义下载的DownloadDestination（不改变文件名，同名文件不会覆盖）
private let DefaultDownloadDestination: DownloadDestination = { temporaryURL, response in
    return (DefaultDownloadDir.appendingPathComponent(response.suggestedFilename!), [])
    //定义下载的DownloadDestination（不改变文件名，遇到同名文件会覆盖）
//       return (DefaultDownloadDir.appendingPathComponent(response.suggestedFilename!), [.removePreviousFile])
}

//默认下载保存地址（用户文档目录）
let DefaultDownloadDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()

//超时控件
public let requestTimeoutClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<DouBanAPI>.RequestResultClosure) in
    
    guard var request:URLRequest = try? endpoint.urlRequest()  else {
        return
    }
    
    request.timeoutInterval = 15   //设置请求超时时间
    done(.success(request))
}

