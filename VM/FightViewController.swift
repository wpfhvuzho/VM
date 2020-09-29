//
//  ViewController.swift
//  TimeAdventure
//
//  Created by 高橋　龍 on 2020/09/22.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
//import SwiftGifOrigin

var timerStartOrStop = 0

class FightViewController: UIViewController{

    
    @IBOutlet weak var timerCountLabel: UILabel!
    var counterSeconds = 00
    var counterMinuts = 00
    var counterHours = 00
    var div = ":"
    var div0 = ":0"
    var timer: Timer = Timer()

    var startCount = 0
    
    
    

    
    @IBOutlet var startLabel1: UILabel!
    @IBOutlet var startLabel2: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var hoursFourcusPicker: UIPickerView!
    @IBOutlet var minutsFourcusPicker: UIPickerView!
    
    @IBOutlet var minutsRestPicker: UIPickerView!
    @IBOutlet var secondsRestPicker: UIPickerView!
    
    
//    var count: Float = 0.0
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        timerStartButton()
        if startCount == 0 {
            startLabel1.isHidden = false
            startLabel2.isHidden = true
        }else {
            startLabel1.isHidden = true
            startLabel2.isHidden = false
        }
        
        
        
        
//        let img01 = UIImageView(image: UIImage.gif(url: "young"))
//        img01.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        self.view.addSubview(img01)
    }
    


    

    
    @IBAction func toRest() {
        let restViewController = storyboard?.instantiateViewController(identifier: "RestViewController")
        self.present(restViewController!, animated: false, completion: nil)
        startCount += 1
    }
    
    @IBAction func toZukan() {
        let zestViewController = storyboard?.instantiateViewController(identifier: "ZukanViewController")
        self.present(zestViewController!, animated: false, completion: nil)
    }
    @objc func updateTimer() {
        counterSeconds += 1
        if counterSeconds > 99 {
            counterMinuts += 30
            counterSeconds = 0
        }
        if counterMinuts > 59 {
            counterHours += 1
            counterMinuts = 0
        }
        if counterSeconds < 10 && counterMinuts < 10 {
            timerCountLabel.text = String(counterHours) + div0 + String(counterMinuts) + div0 + String(counterSeconds)
        }else if counterSeconds < 10 {
            timerCountLabel.text = String(counterHours) + div + String(counterMinuts) + div0 + String(counterSeconds)

        }else if counterMinuts < 10 {
            timerCountLabel.text = String(counterHours) + div0 + String(counterMinuts) + div + String(counterSeconds)

        }else{
            timerCountLabel.text = String(counterHours) + div + String(counterMinuts) + div + String(counterSeconds)
        }
    }

    @objc func timerStartButton() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector:  #selector(self.updateTimer), userInfo: nil, repeats: true)
    }

    @IBAction func restartTimerButton() {
        timerStartButton()
    }

   //       timerLabel.text = String(counterHours) + div + tring(counterMinuts) + div +String(counterSeconds)
    //       timerLabel.text = String(counterSeconds)
    @IBAction func timerStopButton(_ sendr: Any) {
        timer.invalidate()
    }
    //リセットボタン
    @IBAction func timerResetButton(_ sender: Any) {
        timer.invalidate()
        counterSeconds = 0
        counterMinuts = 0
        counterHours = 0
        timerCountLabel.text = String(counterSeconds)
    }
    

}

