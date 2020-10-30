//
//  ResponseModel.swift
//  TodayNew
//
//  Created by MOMO on 2020/10/29.
//  Copyright © 2020 MOMO. All rights reserved.
//

import Foundation
import KakaJSON

// 泛型对象
struct ResponseModel<Element>: Convertible {

    var message = ""
    var code = 0
    var data:Element? = nil
   
}
