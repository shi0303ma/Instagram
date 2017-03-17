//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 松隈璃奈 on 2017/03/09.
//  Copyright © 2017年 shi0303ma. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentsLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func commentButton(_ sender: Any) {
        // 画面遷移
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "Comment")
        UIApplication.shared.keyWindow?.rootViewController?.present(nextVC, animated: true, completion: nil)
    
    }


    func setPostData(postData: PostData) {
        self.postImageView.image = postData.image!
        
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.string(from: postData.date! as Date)
        self.dateLabel.text = dateString
    
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: UIControlState.normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: UIControlState.normal)
        }

        print(postData.comments)
        
        var commentsText = ""
        for obj in postData.comments {
            let dic = obj as! NSDictionary
            let userName = dic.allKeys[0] as! String
            let comment = dic.allValues[0] as! String
            commentsText += userName + " : " + comment + "\n"
        }
        commentsLabel.text = commentsText
        let commentNumber = postData.comments.count
        commentLabel.text = "\(commentNumber)"
        
    }
    
}
