 //
//  Common.swift
//  TodayNew
//
//  Created by MOMO on 2020/10/16.
//  Copyright © 2020 MOMO. All rights reserved.
// 宏定义文件

import UIKit

 
 let kScreenW = UIScreen.main.bounds.width
 let kScreenH = UIScreen.main.bounds.height
 
 // Keywindow
 
 let KeyWindow = UIApplication.shared.keyWindow
 
 // is iPhone
 let kIsiPhone = Bool(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)
 
 // is iPhoneX
 let kIsiPhoneX = Bool(kScreenW >= 375.0 && kScreenH >= 812.0 && kIsiPhone)
 
 let kNavigationBarH = CGFloat(kIsiPhoneX ? 88 : 64)
 let kStatusBarH = CGFloat(kIsiPhoneX ? 44 : 20)
 let kTabBarH = CGFloat(kIsiPhoneX ? (49 + 34) : 49)
 
 func RGBColor(r:CGFloat, g:CGFloat, b:CGFloat ) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
 }
 
 
 /// 服务器地址
 let BASE_URL = "http://lf.snssdk.com"
 //let BASE_URL = "http://ib.snssdk.com"
// let BASE_URL = "https://is.snssdk.com"

 
 let Mine_URL = "http://lf.snssdk.com/user/tab/tabs/?device_id=6096495334&iid=5034850950"
 
 let device_id: Int = 6096495334
 let iid: Int = 5034850950

 
 let Test_URL = "http://mobile.ximalaya.com/mobile/discovery/v1/anchor/recommend?device=android&version=5.4.45"
