//
//  MinePageCellModel.swift
//  TodayNew
//
//  Created by MOMO on 2020/10/27.
//  Copyright © 2020 MOMO. All rights reserved.
//

import KakaJSON

struct MinePageCellModel: Convertible {

    var text:String = ""
    var tip_text:String = ""
    var url:String = ""
    
}

struct Sections: Convertible {
    
}

//struct MinePageModel :Convertible {
//    var sections :[[MinePageCellModel]]?
//
////    var sections :[MinePageCellModel]?
//}


//struct TestModel : Convertible {
//    var data : TestData?
//    var message = ""
//}
//
//struct TestSections : Convertible, Hashable {
//    
//    var text = ""
//    var url = ""
//    
//    
//}
//
//struct TestData : Convertible {
//    var sections: [[TestSections]]?
//    
////    var sections : Set<TestSections>?
//    
//}

