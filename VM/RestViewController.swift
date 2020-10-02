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
    var counterMinuts = 31
    var counterHours = 01
    var div = ":"
    var div0 = ":0"
    var timer: Timer = Timer()
    @IBOutlet var stopButtonLabel: UILabel!
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
        
//        let img01 = UIImageView(image: UIImage.gif(url: "young"))
//        img01.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        self.view.addSubview(img01)
    }
    
    @IBAction func toFight() {
        let fightViewController = storyboard?.instantiateViewController(identifier: "FightViewController")
        self.present(fightViewController!, animated: false, completion: nil)
        timerStartOrStop += 1
        giveExp += 300
    }
    
    @objc func updateTimer() {
        counterSeconds -= 10
        if counterSeconds < 0 {
            counterMinuts -= 30
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
    
    @IBAction func restartTimerButton() {
        timerStartButton()
        stopButtonLabel.isHidden = false
        
    }
    
    //       timerLabel.text = String(counterHours) + div + String(counterMinuts) + div +String(counterSeconds)
    //       timerLabel.text = String(counterSeconds)
    @IBAction func timerStopButton(_ sendr: Any) {
        timer.invalidate()
        restartButtonLabel.isHidden = false
        stopButtonLabel.isHidden = true
        
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
