//
//  ViewController.swift
//  Renda
//
//  Created by 山尾かな on 2022/08/18.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet var countLabel: UILabel!
    @IBOutlet var tapButton: UIButton!
    var tapCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tapButton.layer.cornerRadius = 125
        firestore.collection("counts").document("share").addSnapshotListener{ snapshot, error in
            if error != nil {
                print("エラー発生")
                print(error)
                return
            }
            let data = snapshot?.data()
            if data == nil{
                print("データがありません")
                return
            }
            let count = data!["count"] as? Int
            if count == nil{
                print("countという対応する値がありません")
                return
            }
            self.tapCount = count!
            self.countLabel.text = String(count!)
        }
    }
    let firestore = Firestore.firestore()
    @IBAction func tapTapButton(){
        tapCount = tapCount + 1
        countLabel.text = String(tapCount)
        firestore.collection("counts").document("share").setData(["count": tapCount])
    }
}

