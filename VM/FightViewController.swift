//
//  ViewController.swift
//  TimeAdventure
//
//  Created by 高橋　龍 on 2020/09/22.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
import SwiftGifOrigin

var timerStartOrStop = 0
var exp = 0
var giveExp = 0
var runk = 0
var floatGiveExp = 0.00

class FightViewController: UIViewController, UNUserNotificationCenterDelegate{

    
    @IBOutlet weak var timerCountLabel: UILabel!
    var counterSeconds = 00
    var counterMinuts = 00
    var counterHours = 00
    var div = ":"
    var div0 = ":0"
    var timer: Timer = Timer()

    var judge = 0
    var startCount = 0
    
    var count = 0
    
    @IBOutlet var gifImageTop: UIImageView!
    @IBOutlet var gifImageBottom: UIImageView!
    @IBOutlet var gifImageCharactor: UIImageView!
    
    @IBOutlet var needExpLabel: UILabel!
    @IBOutlet var nowGiveExpLabel: UILabel!
    @IBOutlet var nowGiveFloatExpLabel: UILabel!
    

    
    @IBOutlet var startLabel1: UILabel!
    @IBOutlet var startLabel2: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
//    @IBOutlet var hoursFourcusPicker: UIPickerView!
//    @IBOutlet var minutsFourcusPicker: UIPickerView!
//
//    @IBOutlet var minutsRestPicker: UIPickerView!
//    @IBOutlet var secondsRestPicker: UIPickerView!
    
    
    
    
//    var count: Float = 0.0
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        通知許可をユーザーにお願い
        if #available(iOS 10.0, *) {
            // iOS 10
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
                if error != nil {
                    return
                }

                if granted {
                    print("通知許可")

                    let center = UNUserNotificationCenter.current()
                    center.delegate = self

                } else {
                    print("通知拒否")
                }
            })

        } else {
            // iOS 9以下
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
//        タイマースタート！
        timerStartButton()
        
        
        if timerStartOrStop == 0 {
            startLabel1.isHidden = false
            startLabel2.isHidden = true
        }else {
            startLabel1.isHidden = true
            startLabel2.isHidden = false
        }
        
//        経験値を変換
//        giveExp += Int(floatGiveExp)
        

        
//        経験値を付与
//        exp += giveExp
        

        
//        ランクによって、表示するgifを変更
        if runk == 4 {
            gifImageCharactor.loadGif(name: "god")
        }else if runk == 3 {
            gifImageCharactor.loadGif(name: "hero")
        }else if runk == 1 {
            gifImageCharactor.loadGif(name: "mob")
        }else if runk == 2 {
            gifImageCharactor.loadGif(name: "genius")
        }else {
            gifImageCharactor.loadGif(name: "young")
        }
        
//        背景画像の設定
        gifImageTop.loadGif(name: "sky")
        
//        経験値関係の数値を初期化
//        giveExp = 0
//        floatGiveExp = 0
        
//        タイマー関係の数値を初期化
        count = 0
        counterSeconds = 0
        counterMinuts = 0
        counterHours = 0
        
//        獲得済みの経験値を表示
        needExpLabel.text = String(exp)
        
        
//        let img01 = UIImageView(image: UIImage.gif(url: "young"))
//        img01.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        self.view.addSubview(img01)
    }
    
//    画面描写後に、処理開始
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        ランクアップしてたらランクアップのアラートを表示
        
    }
    
    //通知を可能にする関数
    func applicationDidEnterBackground(_ application: UIApplication) {

        //　通知設定に必要なクラスをインスタンス化
        let trigger: UNNotificationTrigger
        let content = UNMutableNotificationContent()
        var notificationTime = DateComponents()

        // トリガー設定
        notificationTime.hour = 12
        notificationTime.minute = 0
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // 通知内容の設定
        content.title = ""
        content.body = "食事の時間になりました！"
        content.sound = UNNotificationSound.default

        // 通知スタイルを指定
        let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
        // 通知をセット
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

    }
    



//    リセットView controllerに移動
    @IBAction func toRest() {
        let restViewController = storyboard?.instantiateViewController(identifier: "RestViewController")
        self.present(restViewController!, animated: false, completion: nil)
//        timerStartOrStop += 1
        timer.invalidate()
    }
    
//    図鑑View  controllerに移動
    @IBAction func toZukan() {
        let zestViewController = storyboard?.instantiateViewController(identifier: "ZukanViewController")
        self.present(zestViewController!, animated: false, completion: nil)
    }
    
//    タイマーを更新する時の内容（0.01秒ごと）
    @objc func updateTimer() {
        counterSeconds += 1
        if counterSeconds > 99 {
            counterMinuts += 1
            counterSeconds = 0
        }
        if counterMinuts > 59 {
            counterHours += 1
            counterMinuts = 0
        }
        
//        00:00:00が保たれるように文字列を調整
        if counterSeconds < 10 && counterMinuts < 10 {
            timerCountLabel.text = String(counterHours) + div0 + String(counterMinuts) + div0 + String(counterSeconds)
        }else if counterSeconds < 10 {
            timerCountLabel.text = String(counterHours) + div + String(counterMinuts) + div0 + String(counterSeconds)

        }else if counterMinuts < 10 {
            timerCountLabel.text = String(counterHours) + div0 + String(counterMinuts) + div + String(counterSeconds)

        }else{
            timerCountLabel.text = String(counterHours) + div + String(counterMinuts) + div + String(counterSeconds)
        }
        
//        休憩経験値を付与する
        if counterHours > 10 {
//            十分以降は1秒でマイナス10のExpを失う
            floatGiveExp -= 0.1
        }else {
//            6秒ごとに経験値を1プラスする
            if timerStartOrStop != 0 {
                if count < 600 {
                    count += 10
                }else {
                    floatGiveExp += 1
                    count = 0
                }
            }
            
            
        }
//        今なら獲得できる経験値を表示
        nowGiveExpLabel.text = String(floatGiveExp)
        nowGiveFloatExpLabel.text = String(giveExp)
    }

//    タイマーを再生する機能
    @objc func timerStartButton() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector:  #selector(self.updateTimer), userInfo: nil, repeats: true)
    }

//    再開の機能
//    @IBAction func restartTimerButton() {
//        timerStartButton()
//    }

   //       timerLabel.text = String(counterHours) + div + tring(counterMinuts) + div +String(counterSeconds)
    //       timerLabel.text = String(counterSeconds)
//    @IBAction func timerStopButton() {
//        timer.invalidate()
//    }
//    //リセットボタン
//    @IBAction func timerResetButton() {
//        timer.invalidate()
//        counterSeconds = 0
//        counterMinuts = 0
//        counterHours = 0
//        timerCountLabel.text = String(counterSeconds)
//    }
    

}

