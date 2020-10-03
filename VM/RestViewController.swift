//
//  Rest.swift
//  TimeAdventure
//
//  Created by 高橋　龍 on 2020/09/24.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
//import SwiftGifOrigin




class RestViewController: UIViewController{


    @IBOutlet weak var timerCountLabel2: UILabel!
    var counterSeconds = 00
    var counterMinuts = 30
    var counterHours = 00
    var div = ":"
    var div0 = ":0"
    var timer: Timer = Timer()
    var countStOrRe = 0
    
    @IBOutlet var gifImageTop: UIImageView!
    @IBOutlet var gifImageBottom: UIImageView!
    @IBOutlet var gifImageCharactor: UIImageView!
    
    @IBOutlet var stopButtonLabel : UILabel!
    @IBOutlet var restartButtonLabel: UILabel!

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
        exp += giveExp
        notificationExp()
        
        if runk == 3 {
            gifImageCharactor.loadGif(name: "god")
        }else if runk == 2 {
            gifImageCharactor.loadGif(name: "hero")
        }else if runk == 1 {
            gifImageCharactor.loadGif(name: "mob")
        }else {
            gifImageCharactor.loadGif(name: "young")
        }
        gifImageTop.loadGif(name: "sky")
        gifImageBottom.loadGif(name: "dot")
        
//        let img01 = UIImageView(image: UIImage.gif(url: "young"))
//        img01.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        self.view.addSubview(img01)
        giveExp = 0
    }
    
    @IBAction func toFight() {
        let fightViewController = storyboard?.instantiateViewController(identifier: "FightViewController")
        self.present(fightViewController!, animated: false, completion: nil)
        timerStartOrStop += 1
        giveExp = 300
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
        if counterMinuts < 0 {
            counterHours -= 1
            counterMinuts = 0
        }
        if counterMinuts == 0 && counterHours == 0 && counterSeconds == 0 {
            timer.invalidate()
        }
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
    }
    
    @objc func timerStartButton() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:  #selector(self.updateTimer), userInfo: nil, repeats: true)
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
    @IBAction func timerResetButton(_ sender: Any) {
        timer.invalidate()
        counterSeconds = 0
        counterMinuts = 0
        counterHours = 0
        timerCountLabel2.text = String(counterSeconds)
    }
    //移譲される側の関数

}
