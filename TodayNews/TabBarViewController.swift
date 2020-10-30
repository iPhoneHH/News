//
//  TabBarViewController.swift
//  TodayNew
//
//  Created by MOMO on 2020/10/16.
//  Copyright © 2020 MOMO. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var indexFlag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addControllers()
    }
    
    private func addControllers() {
        addChildControllers(HomeViewController(), title: "Home", image: "btnGnbHomeOff", selectImg: "btnGnbHomeOn")
        addChildControllers(VideoViewController(), title: "Video", image: "btnGnbHomeMyOff", selectImg: "btnGnbHomeMyOn")
        addChildControllers(DiscoverViewController(), title: "Discover", image: "btnGnbMoreOff", selectImg: "btnGnbMoreOn")
        addChildControllers(MineViewController(), title: "Me", image: "btnGnbHomeMyOff", selectImg: "btnGnbHomeMyOn")
    }
    

    private func addChildControllers(_ childVC:UIViewController, title:String, image:String, selectImg:String)  {
        
        childVC.tabBarItem.title = title
        childVC.tabBarItem.image = UIImage(named: image)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage(named: selectImg)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        let attrDict = [
            NSAttributedString.Key.foregroundColor:RGBColor(r: 245, g: 90, b: 93)
        ]
        UITabBarItem.appearance().setTitleTextAttributes(attrDict, for: .selected)
        
        // 头部导航
        let nav = UINavigationController()
        nav.addChild(childVC)
        addChild(nav)
    }
    
    // Click Tabbar
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.firstIndex(of: item) {
            if indexFlag != index {
                animationWithIndex(index: index)
            }
        }
    }
    
    // 实现动画
    private func animationWithIndex(index:Int)
    {
        // 定义一个数组
        var arrViews = [UIView]()
        
        for tabbarButton in tabBar.subviews {
            if tabbarButton .isKind(of: NSClassFromString("UITabBarButton")!) {
                arrViews.append(tabbarButton)
            }
        }
        
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        
        pulse.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        pulse.duration = 0.1
        pulse.repeatCount = 1
        pulse.autoreverses = true
        pulse.fromValue = NSNumber(value: 0.7)
        pulse.toValue = NSNumber(value: 1.5)
        
        // 添加动画的item
        arrViews[index].layer.add(pulse, forKey: nil)
        
        indexFlag = index
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
