//
//  ViewController.swift
//  Instagram
//
//  Created by 松隈璃奈 on 2017/03/08.
//  Copyright © 2017年 shi0303ma. All rights reserved.
//

import Firebase
import FirebaseAuth
import UIKit
import ESTabBarController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if FIRAuth.auth()?.currentUser == nil {
            // ログインしていなければログインの画面を表示する
            // viewDidAppear内でpresent()を呼び出しても表示されないためメソッドが終了してから呼ばれるようにする
            DispatchQueue.main.async {
                let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                self.present(loginViewController!, animated: true, completion: nil)
            }
        }
    }
    
    func setupTab() {
        
        // 画像のファイル名を指定してESTabBarControllerを作成する
        let tabBarController: ESTabBarController! = ESTabBarController(tabIconNames: ["home", "camera", "setting"])
        
        // 背景色、選択時の色を設定する
        tabBarController.selectedColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
        tabBarController.buttonsBackgroundColor = UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
        
        // 作成したESTabBarControllerを親のViewController（＝self）に追加する
        addChildViewController(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.view.frame = view.bounds
        tabBarController.didMove(toParentViewController: self)
        
        // タブをタップした時に表示するViewControllerを設定する
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "Home")
        let settingViewController = storyboard?.instantiateViewController(withIdentifier: "Setting")
        
        tabBarController.setView(homeViewController, at: 0)
        tabBarController.setView(settingViewController, at: 2)
        
        // 真ん中のタブはボタンとして扱う
        tabBarController.highlightButton(at: 1)
        tabBarController.setAction({
            // ボタンが押されたらImageViewControllerをモーダルで表示する
            let imageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImageSelect")
            self.present(imageViewController!, animated: true, completion: nil)
        }, at: 1)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
