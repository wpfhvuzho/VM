//
//  Rest.swift
//  TimeAdventure
//
//  Created by 高橋　龍 on 2020/09/24.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
//import SwiftGifOrigin

var mustMove = 0


class RestViewController: UIViewController{


    @IBOutlet weak var timerCountLabel2: UILabel!
    var counterSeconds = 00
    var counterMinuts = 3
    var counterHours = 00
    var div = ":"
    var div0 = "0"
    var timer: Timer = Timer()
    var countStOrRe = 0
    
    var counter = 0
    
    var count = 0
    var fightExp = 0
    
    var judge: Int!
    var startCount: Int!
    
    @IBOutlet var gifImageTop: UIImageView!
    @IBOutlet var gifImageBottom: UIImageView!
    @IBOutlet var gifImageCharactor: UIImageView!
    
    @IBOutlet var stopButtonLabel : UILabel!
    @IBOutlet var restartButtonLabel: UILabel!
    
    @IBOutlet var needExpLabel: UILabel!
    @IBOutlet var nowGiveExpLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        timerStartButton()
        if counterSeconds < 10 && counterMinuts < 10 {
            timerCountLabel2.text = String(counterHours) + div0 + String(counterMinuts) + div0 + String(counterSeconds)
        }else if counterSeconds < 10 {
            timerCountLabel2.text = String(counterHours) + div + String(counterMinuts) + div0 + String(counterSeconds)

        }else if counterMinuts < 10 {
            timerCountLabel2.text = String(counterHours) + div0 + String(counterMinuts) + div + String(counterSeconds)

        }else if counterMinuts == 0 && counterHours == 0 && counterSeconds == 0 {
            timerCountLabel2.text = String(counterHours) + div0 + String(counterMinuts) + div + String(counterSeconds)

        }else{
            timerCountLabel2.text = String(counterHours) + div + String(counterMinuts) + div + String(counterSeconds)
        }
        restartButtonLabel.isHidden = true
        stopButtonLabel.isHidden = false
        stopButtonLabel.text = "▷とめる"
        restartButtonLabel.text = "▷さいかい"
        
        //giveExpに値を渡す
        giveExp += Int(floatGiveExp)
        
        //前回の報酬を表示させる
        beforeExp = Int(floatGiveExp)
        
        //        ランクアップするのかどうかを判定する
        judge = 0
        judge = exp + giveExp
        if judge >= 300 && exp < 300 {
            startCount = 1
        }else if judge >= 800 && exp < 800 {
            startCount = 2
        }else if judge >= 1500 && exp < 1500 {
            startCount = 3
        }else if judge >= 3000 && exp < 3000 {
            startCount = 4
        }else {
            startCount = 0
        }
        
        
        exp += giveExp
        nowGiveExpLabel.text = String(giveExp)
        
        //        経験値によって、ランクを決定
        if exp < 30 {
            runk = 0
        }else if exp < 800{
            runk = 1
        }else if exp < 1500 {
            runk = 2
        }else if exp < 3000 {
            runk = 3
        }else {
            runk = 4
        }
        
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
        gifImageTop.loadGif(name: "sky")
        
        counter = 0
        floatGiveExp = 0
        

        
//        let img01 = UIImageView(image: UIImage.gif(url: "young"))
//        img01.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        self.view.addSubview(img01)
        
//        needExpLabel.text = String(exp)
    }

    
    
    override func viewDidAppear(_ animated: Bool) {
        if timerStartOrStop == 0 {
            notificationLogin()
        }
        if startCount != 0 {
            notificationRunkUp()
        }else {
            notificationExp()
        }
        giveExp = 0
    }
    
    //ランクアップ時にアラートを生成
    func notificationRunkUp() {
        
        let alert: UIAlertController = UIAlertController(title: "おめでとう！", message: String(giveExp) + "の経験値を獲得したので、ランクが上がりました！", preferredStyle: .alert)
        
        alert.addAction(
                UIAlertAction(
                    title: "よっしゃあ！！",
                    style: .default,
                    handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    }
                )
            )
        present(alert, animated: true, completion: nil)
    }
    
    
    func notificationLogin() {
        
        let alert: UIAlertController = UIAlertController(title: "よくきたね！", message: "今日も張り切って頑張りましょう！", preferredStyle: .alert)
        
        alert.addAction(
                UIAlertAction(
                    title: "最善を尽くす",
                    style: .default,
                    handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    }
                )
            )
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func toFight() {
        
        let fightViewController = storyboard?.instantiateViewController(identifier: "FightViewController")
        self.present(fightViewController!, animated: false, completion: nil)
        timerStartOrStop += 1
        timer.invalidate()
    }
    
    
    func notificationExp() {
        
        let alert: UIAlertController = UIAlertController(title: "おめでとう！", message: String(giveExp) + "の経験値を獲得！", preferredStyle: .alert)
        
        alert.addAction(
                UIAlertAction(
                    title: "次も頑張る",
                    style: .default,
                    handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    }
                )
            )
        present(alert, animated: true, completion: nil)
    }
    
    @objc func updateTimer() {
        counterSeconds -= 1
        if counterSeconds < 0 {
            counterMinuts -= 1
            counterSeconds = 59
        }
        if counterMinuts == 0 && counterSeconds == 0 {
            timer.invalidate()
        }
        if counterSeconds < 10 && counterMinuts < 10 {
            timerCountLabel2.text = div0 + String(counterMinuts) + div + div0 + String(counterSeconds)
        }else if counterSeconds < 10 {
            timerCountLabel2.text =  String(counterMinuts) + div + div0 + String(counterSeconds)

        }else if counterMinuts < 10 {
            timerCountLabel2.text = div0 + String(counterMinuts) + div + String(counterSeconds)

        }else{
            timerCountLabel2.text =  String(counterMinuts) + div + String(counterSeconds)
        }
        
        if count < 5 {
            count += 1
        }else {
            count = 0
            floatGiveExp += 10
        }
        nowGiveExpLabel.text = String(floatGiveExp)
        if counterHours <= 0 && counterMinuts <= 0 && counterSeconds <= 0 {
            mustMove += 1
            toFight()
        }
        
    }
    
    @objc func timerStartButton() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:  #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    func restartTimerButton() {
        timerStartButton()
        restartButtonLabel.isHidden = true
        stopButtonLabel.isHidden = false
        
        
    }
    
    //       timerLabel.text = String(counterHours) + div + String(counterMinuts) + div +String(counterSeconds)
    //       timerLabel.text = String(counterSeconds)
    @IBAction func timerStopOrRestartButton(_ sendr: Any) {
        if countStOrRe == 0 {
            timer.invalidate()
            restartButtonLabel.isHidden = false
            stopButtonLabel.isHidden = true
            countStOrRe += 1
        }else {
            restartTimerButton()
            countStOrRe -= 1
        }
        
        
    }
    //リセットボタン
    func timerResetButton() {
        timer.invalidate()
        counterSeconds = 0
        counterMinuts = 0
        counterHours = 0
        timerCountLabel2.text = String(counterSeconds)
        
        
    }
    //移譲される側の関数

}
