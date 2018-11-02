//
//  RequestAlertPlugin.swift
//  SwiftDemo
//
//  Created by 55it on 2018/11/2.
//  Copyright © 2018年 55it. All rights reserved.
//

import UIKit
import Moya
import Result
final  class RequestAlertPlugin: PluginType {

    private let viewController: UIViewController
    private var spinner: UIActivityIndicatorView!
    
    init(viewController: UIViewController) {
        self.viewController = viewController
         self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
         self.spinner.center = self.viewController.view.center
        
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        viewController.view.addSubview(spinner)
        spinner.startAnimating()
    }
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        spinner.removeFromSuperview()
        spinner.stopAnimating()
        guard case let Result.failure(error) = result else {
        return
        }
        let message = error.errorDescription ?? "未知错误"
        let alertViewController = UIAlertController(title: "请求失败", message: "\(message)", preferredStyle: .alert)
        
        alertViewController.addAction(UIAlertAction(title:"确定", style:.default , handler: nil))
        viewController.present(alertViewController, animated: true, completion: nil)
    }
    
}
