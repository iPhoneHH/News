//
//  MineViewController.swift
//  TodayNew
//
//  Created by MOMO on 2020/10/16.
//  Copyright © 2020 MOMO. All rights reserved.
//

/*
 
 Class 和 Struct的区别 ？？  性能差异， 多使用struct 和protocol 面向协议编程
 
 */
import UIKit

class MineViewController: UITableViewController {
    
    var sections = [[MinePageCellModel]]()
    
    var loginViewOriginY :CGFloat!
    
    var style: UIStatusBarStyle = .default
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    
        NetworkTool.loadMyCellData { (sectionModels) in
            self.sections = sectionModels
            self.tableView.reloadData()
        }
    }
    
    
   

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        loginViewOriginY = kStatusBarH
//
//        view.addSubview(button)
//        view.addSubview(grayView)
//        view.addSubview(loginV)
//    }
    
    /// lazy button
    private lazy var button: UIButton = {
        
        let btn = UIButton.init(type: .roundedRect)
        btn.frame = CGRect(x: 10, y: 100, width: kScreenW-20, height: 100)
        btn.backgroundColor = UIColor.green
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn

    }()
    
    private lazy var grayView: UIView = {
        let gray = UIView.init(frame: self.view.bounds)
        gray.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        gray.alpha = 0;
        return gray
    }()

    private lazy var loginV: LoginView = {
        let loginView = LoginView.loadFromNib()//LoginView.init(frame:CGRect(x: 0, y: kScreenH, width: kScreenW, height: kScreenH))
        loginView.frame = CGRect(x: 0, y: kScreenH, width: kScreenW, height: kScreenH)
//        loginView.backgroundColor = UIColor.white
//        let loginView = LoginView.loadFromNib()
        loginView.layer.cornerRadius = 10
        loginView.layer.masksToBounds = true
        
        // 添加拖拽手势
        let panView = UIPanGestureRecognizer.init(target: self, action: #selector(pan(panGesture:)))
        loginView.addGestureRecognizer(panView)
        return loginView
    }()
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}

// tableView DataSources && Delegate
extension MineViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sections[section].count
    }
    
    // setcion Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 10))
        view.backgroundColor = UIColor.globalBackgroundColor()
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let cellModel = sections[indexPath.section][indexPath.row]
        cell.textLabel?.text = cellModel.text
        return cell
    }
}

// 扩展 - 拖拽登陆view
extension MineViewController {
       
    @objc func pan(panGesture:UIPanGestureRecognizer) {
        
        if panGesture.state == .began {
            print("=======Start")
            
        } else if panGesture.state == .changed {
            
            let y = panGesture.translation(in: self.view).y
            if y <= kStatusBarH {
                self.loginV.frame = CGRect(x: 0, y: kStatusBarH, width: kScreenW, height: kScreenH)
            } else {
                self.loginV.frame = CGRect(x: 0, y: loginViewOriginY + y, width: kScreenW, height: kScreenH)
            }
            
            var scrollAlpha = self.loginV.frame.origin.y / kScreenW / 2
            
            if scrollAlpha > 0.5 {
                scrollAlpha = 0.5
            }
            self.grayView.alpha = scrollAlpha
            
        }  else if panGesture.state == .ended {
            
            if self.loginV.frame.origin.y <= kScreenH * 0.5 {
                UIView.animate(withDuration: 0.2) {
                    self.loginV.frame = CGRect(x: 0, y: self.loginViewOriginY, width: kScreenW, height: kScreenH)
                    self.grayView.alpha = 1.0
                }
            } else {
                
                UIView.animate(withDuration: 0.25) {
                    self.loginV.frame = CGRect(x: 0, y: kScreenH, width: kScreenW, height: kScreenH)
                    self.grayView.alpha = 0;
                }
            }
            
            // 灰色背景透明小于0.5时，说明弹出层的此时小于屏幕的一半
            if self.grayView.alpha >= 0.5 {
                self.style = .lightContent
                setNeedsStatusBarAppearanceUpdate()
            } else {
                self.style = .default
                setNeedsStatusBarAppearanceUpdate()
            }
            
        }
            
    }
      
    @objc func downMove() {
        // 回弹
        UIView.animate(withDuration: 0.2) {
            self.loginV.frame = CGRect(x: 0, y: kStatusBarH, width: kScreenW, height: kScreenH)
            self.grayView.alpha = 1.0
        }
    }
    
}

// 弹出登陆view。和状态栏改变

extension MineViewController {
    
    @objc private func btnClick() {
       
        creatHidden(value: 1)
        // 刷新状态栏
        self.style = .lightContent
        setNeedsStatusBarAppearanceUpdate()
        
        UIView.animate(withDuration: 0.5) {
            self.loginV.frame = CGRect(x: 0, y: kStatusBarH/2, width: kScreenW, height: kScreenH)
            self.grayView.alpha = 1.0
        }
        self.perform(#selector(downMove), with: nil, afterDelay: 0.5)
    }
    
    @objc func hidTabbar() {
         self.tabBarController?.tabBar.isHidden = false
    }
    
    private func creatHidden(value: NSInteger) {
        if value == 1 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.tabBarController?.tabBar.isHidden = true
        } else {
           self.navigationController?.setNavigationBarHidden(false, animated: true)
            // 延时执行
            self.perform(#selector(hidTabbar), with: nil, afterDelay: 0.25)
        }
    }
    
    
}
