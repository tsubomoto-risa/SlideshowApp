//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 坪本 梨沙 on 2022/06/14.
//

import UIKit

class ViewController: UIViewController {

    //outletの接続
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    var timer: Timer!
    var nowIndex: Int = 0
    // スライドショーさせる画像の配列
    var imageUrlArray:[String] = [
        "https://images.unsplash.com/photo-1570018144929-a2e84642b98d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1383&q=80",
        "https://images.unsplash.com/photo-1590279928606-7a9256eb28ef?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxNTgwfDB8MXxzZWFyY2h8MTh8fG5la298ZW58MHx8fHwxNjU1MTgwODQ1&ixlib=rb-1.2.1&q=80&w=400",
        "https://images.unsplash.com/photo-1594178613616-b3b3ed2d1c43?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxNTgwfDB8MXxzZWFyY2h8Nnx8bmVrb3xlbnwwfHx8fDE2NTUxODA4NDU&ixlib=rb-1.2.1&q=80&w=400",
        "https://images.unsplash.com/photo-1570117267971-85d1ec8ffb45?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxNTgwfDB8MXxzZWFyY2h8MjR8fG5la298ZW58MHx8fHwxNjU1MTgwODQ1&ixlib=rb-1.2.1&q=80&w=400",
        "https://images.unsplash.com/photo-1629908579970-aaffeb2a3659?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxNTgwfDB8MXxzZWFyY2h8MTJ8fG5la298ZW58MHx8fHwxNjU1MTgwODQ1&ixlib=rb-1.2.1&q=80&w=400",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初期画像セット
        self.imageView.image = fetchImage(url: self.imageUrlArray[0])
        
        //画像タップ有効化
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(imageTapped)))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let imageDetailViewController: ImageDetailViewController = segue.destination as! ImageDetailViewController
        imageDetailViewController.image = fetchImage(url: self.imageUrlArray[self.nowIndex])
    }
    
    //進むボタン
    @IBAction func nextSlide(_ sender: Any) {
        self.changeSlide(true)
    }
    
    //戻るボタン
    @IBAction func prevSlide(_ sender: Any) {
        self.changeSlide(false)
    }
    
    //スライドショー再生/停止ボタン
    @IBAction func operateSlideshow(_ sender: Any) {
        if self.timer == nil {
            //再生ボタンタップ時
            
            //タイマーセット
            self.timer = Timer.scheduledTimer(
                timeInterval: 1.5,
                target: self,
                selector: #selector(passSlide(_:)),
                userInfo: nil,
                repeats: true
            )
            
            //ボタンテキスト変更
            self.startButton.setTitle("停止", for: .normal)
        } else {
            //停止ボタンタップ時
            
            //タイマー停止・削除
            self.timer.invalidate()
            self.timer = nil
            
            //ボタンテキスト変更
            self.startButton.setTitle("再生", for: .normal)
        }
    }
    
    //画像タップ
    @IBAction func imageTapped(_ sender: Any) {
        performSegue(withIdentifier: "imageDetail", sender: nil)
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
       // 他の画面から segue を使って戻ってきた時に呼ばれる
    }

    
    @objc func passSlide(_ timer: Timer) {
        changeSlide(true)
    }

    func changeSlide(_ isNext: Bool) {
        if isNext {
            self.nowIndex += 1
        } else {
            self.nowIndex += self.imageUrlArray.count - 1
        }
        
        self.nowIndex %= self.imageUrlArray.count
        
        //セット
        self.imageView.image = fetchImage(url: self.imageUrlArray[nowIndex])
    }

    //URLから画像を取得
    private func fetchImage(url: String) -> UIImage? {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            let image = UIImage(data: data)
            return image
        } catch let err {
            print("Error: \(err.localizedDescription)")
        }
        
        return nil
    }
}

