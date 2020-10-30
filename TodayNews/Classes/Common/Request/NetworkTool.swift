//
//  NetworkTool.swift
//  TodayNew
//
//  Created by MOMO on 2020/10/27.
//  Copyright © 2020 MOMO. All rights reserved.
//

import Foundation
import KakaJSON

/// 面向协议
protocol NetworkToolProtocl {
    
    // Mine Page For Cell
    static func loadMyCellData(completionHandler: @escaping (_ sections:[[MinePageCellModel]])->())
    // Mine Page Concern
    static func loadMyconcern()
}


extension NetworkToolProtocl {
    
    
    static func loadMyCellData(completionHandler: @escaping (_ sections: [[MinePageCellModel]])->()) {

        let params = ["111": device_id,
                      "222": iid]
        
        HTTPDatas.sharedInstance.requetDatas(type: .get, URLString: Mine_URL, parameters: params) { (json) -> (Void) in

            guard let dataDict = json["data"].dictionary else {
                return
            }
            guard let sections = dataDict["sections"]?.arrayObject else {
                return
            }
            
//            // compactMap 可以把一个集合的空值去除，并且返回一个去处nil值的数组
            // 等价下面的写法
//            let setionArray = sections.compactMap { (item) in
//                (item as! [Any]).compactMap { (model) -> MinePageCellModel? in
//                    let cellModel = (model as! [String:Any]).kj.model(MinePageCellModel.self)
//                    return cellModel
//                }
//            }

            let sectionModels =
            sections.compactMap { (item) in
                (item as! [Any]).kj.modelArray(MinePageCellModel.self)
            }
            completionHandler(sectionModels)
        }
    }
    
    static func loadMyconcern() {
        
    }
    
}

// 遵循 NetworkToolProtocl 协议
struct NetworkTool: NetworkToolProtocl {
    
  
}
