//
//  CommentViewController.swift
//  Instagram
//
//  Created by 松隈璃奈 on 2017/03/12.
//  Copyright © 2017年 shi0303ma. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    var postArray: [PostData] = []
    
    var postData: PostData? = nil

    @IBOutlet weak var userNameLabel: UILabel!

    @IBOutlet weak var commentField: UITextView!
    
    @IBAction func submitCommentButton(_ sender: Any) {
        let commentUserName = FIRAuth.auth()?.currentUser?.displayName
        
        if let postData = self.postData {
            
            let postRef = FIRDatabase.database().reference().child(Const.PostPath).child(postData.id!)
            let comments: NSDictionary = [commentUserName!: commentField.text!]
            postData.comments.append(comments)
            postRef.updateChildValues(["comments": postData.comments])
            
            SVProgressHUD.showSuccess(withStatus: "コメントを投稿しました")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        // 画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(self.postData)

        let name = FIRAuth.auth()?.currentUser?.displayName
        userNameLabel?.text = name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
