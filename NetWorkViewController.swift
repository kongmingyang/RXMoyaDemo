

//
//  NetWorkViewController.swift
//  SwiftDemo
//
//  Created by 55it on 2018/11/1.
//  Copyright © 2018年 55it. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import HandyJSON
import SnapKit
import SwiftyJSON
import Alamofire
import Moya
class NetWorkViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
 
    var tableView : UITableView!
    var channels = Array<DouBanModel>()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.navigationItem.title = "RXMoya+HanyJson练习"
        self.edgesForExtendedLayout = UIRectEdge.bottom
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let lable = UILabel()
        lable.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lable.textColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        lable.text = "测试一下位置"
        self.view.addSubview(lable)
      
        lable.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(10)
            make.width.greaterThanOrEqualTo(60)
            make.height.equalTo(40)
            make.left.equalTo(100)
        }
        
        self.tableView = UITableView()
        self.tableView .register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) -> Void in
            make.bottom.right.left.equalTo(self.view)
            make.top.equalTo(lable.snp.bottom).offset(10)
        }
        
        let DouBanProvider = MoyaProvider<DouBanAPI>(requestClosure: requestTimeoutClosure)
        
        
        //Moya的普通操作
        //获取频道数据
        DouBanProvider.request(DouBanAPI.channels) { result  in
            switch result{
                
            case let .success(response):
                let  str =  String(data: response.data, encoding: String.Encoding.utf8)
                let channels = Channels.deserialize(from: str)
                let arr = channels?.channels
                self.channels = arr!
                DispatchQueue.main.async {
                self.tableView .reloadData()
                                    }
                break
            case let .failure(error):
                print(error)
                
                break
            }
        }
        
        
        //网络下载的请求
        let assetName = "logo/png"
        
        DouBanProvider.rx.request(.downloadAsset(assetName: assetName)).subscribe{ (result) in
            
            switch result{
                
            case .success(_):
                
                let localLocation: URL = DefaultDownloadDir.appendingPathComponent(assetName)
                let image = UIImage(contentsOfFile: localLocation.path)
                
                let icon = UIImageView.init(frame: CGRect(x: 20, y: 40, width: 200, height: 200))
                icon.image = image
                self.tableView .addSubview(icon)
                UIView.animate(withDuration: 2, animations: {
                    icon .removeFromSuperview()
                })
                break
            case let.error(error):
                print(error)
                break
                
            }
        }.disposed(by: disposeBag)
        
        //Moya和RXSwift配合使用
//        DouBanProvider.rx.request(.channels).subscribe { (event) in
//            switch event {
//            case let .success(response):
//                let str = String(data: response.data, encoding: String.Encoding.utf8)
//                let channel = Channels.deserialize(from: str)
//                let arr = channel?.channels
//                self.channels = arr!
//
//                DispatchQueue.main.async {
//                self.tableView .reloadData()
//                }
//                break
//            case let .error(error):
//                print("数据请求失败!错误原因：", error)
//
//            }
//        }.disposed(by: disposeBag)
//
//
        
        
        //RXswift 和moya封装 将网络请求封装
        
//        let service = DouBanNetworkService()
//        service.channelsubject.subscribe(onNext: { (event) in
//
//            self.channels = event
//            DispatchQueue.main.async {
//              self.tableView .reloadData()
//            }
//        }, onError: { (error) in
//
//        }, onCompleted: {
//
//        }).disposed(by: disposeBag)
//        service .loadChannels()
        
        
    
        


        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channels.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = self.channels[indexPath.row]
        cell.textLabel?.text = model.name
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        let model = self.channels[indexPath.row]
        let service = DouBanNetworkService()
        service.loadPlayList(channelId: model.channel_id!)
        service.playListSubject.subscribe(onNext: { (event) in
            for item in event{
                print("歌曲名",item.title)
            }
            
        }, onError: { (error) in
            
        }, onCompleted: {
            
        }).disposed(by: disposeBag)
        
        
    }
    

}
