//
//  BsWebBodyController.swift
//  chinese
//
//  Created by zhujohnle on 15/12/2.
//  Copyright © 2015年 zhujohnle. All rights reserved.
//

import UIKit

class BsWebBodyController: UIViewController{
    
    var mUrl:String = ""
    
  
    func setUrl(mUrlFunc :String){
        mUrl =  mUrlFunc;
    }
    
    override func viewDidLoad() {
        let webview = UIWebView(frame:self.view.bounds)
        webview.bounds=self.view.bounds
        //远程网页
        webview.loadRequest(NSURLRequest(URL: NSURL(string:mUrl)!))
        
        
        self.view.addSubview(webview)
        
    }
   
    
    
}



