//
//  HomeViewController.swift
//  TodayNew
//
//  Created by MOMO on 2020/10/16.
//  Copyright © 2020 MOMO. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = RGBColor(r: 100, g: 100, b: 100)
           
           let dic = ["token": "111"]
           
//           HTTPDatas.sharedInstance.requetDatas(type: .get, URLString: "http://c.m.163.com/nc/auto/list/5bmz6aG25bGx/0-20.html", parameters: dic) { (response) in
////               let jsonData = JSON(response)
////               print("jsonData = \(response)")
//           }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
