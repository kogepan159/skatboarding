//
//  PostData.swift
//  Skateboarding
//
//  Created by 鈴木正義 on 2021/01/15.
//  Copyright © 2021 masayoshi.suzuki. All rights reserved.
//

import UIKit
import Firebase

class PostData: NSObject {

    var id: String
    var name: String?
    var caption: String?
    var roadsurface: String?
    var kickout: String?
    var rainy: String?
    var category: String?
    var detail: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false

    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID

        let postDic = document.data()

        self.name = postDic["name"] as? String

        self.caption = postDic["caption"] as? String

        self.category = postDic["category"] as? String

        self.roadsurface = postDic["roadsurface"] as? String

        self.kickout = postDic["kickout"] as? String

        self.rainy = postDic["rainy"] as? String

        self.detail = postDic["detail"] as? String
        
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()

        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        if let myid = Auth.auth().currentUser?.uid {
            // likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil {
                // myidがあれば、いいねを押していると認識する。
                self.isLiked = true
            }
        }
    }
}
