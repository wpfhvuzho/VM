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

class FightViewController: UIViewController{

    
    @IBOutlet weak var timerCountLabel: UILabel!
    var counterSeconds = 00
    var counterMinuts = 00
    var counterHours = 00
    var div = ":"
    var div0 = ":0"
    var timer: Timer = Timer()

    var floatGiveExp = 0.00
    var startCount = 0
    
    @IBOutlet var gifImageTop: UIImageView!
    @IBOutlet var gifImageBottom: UIImageView!
    @IBOutlet var gifImageCharactor: UIImageView!
    
    @IBOutlet var needExpLabel: UILabel!
    

    
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
        
        timerStartButton()
        if timerStartOrStop == 0 {
            startLabel1.isHidden = false
            startLabel2.isHidden = true
        }else {
            startLabel1.isHidden = true
            startLabel2.isHidden = false
        }
        giveExp += Int(floatGiveExp)
        exp += giveExp
        if exp < 300 {
            runk = 0
        }else if exp < 800{
            runk = 1
        }else if exp < 1500 {
            runk = 2
        }else {
            runk = 3
        }
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
        
        giveExp = 0
        
        needExpLabel.text = String(exp)
        
//        let img01 = UIImageView(image: UIImage.gif(url: "young"))
//        img01.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        self.view.addSubview(img01)
    }
    


    func notificationRunkUp() {
        
        let alert: UIAlertController = UIAlertController(title: "おめでとう！", message: "ランクが上がりました！", preferredStyle: .alert)
        
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

    
    @IBAction func toRest() {
        let restViewController = storyboard?.instantiateViewController(identifier: "RestViewController")
        self.present(restViewController!, animated: false, completion: nil)
        timerStartOrStop += 1
    }
    
    @IBAction func toZukan() {
        let zestViewController = storyboard?.instantiateViewController(identifier: "ZukanViewController")
        self.present(zestViewController!, animated: false, completion: nil)
    }
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
        if counterSeconds < 10 && counterMinuts < 10 {
            timerCountLabel.text = String(counterHours) + div0 + String(counterMinuts) + div0 + String(counterSeconds)
        }else if counterSeconds < 10 {
            timerCountLabel.text = String(counterHours) + div + String(counterMinuts) + div0 + String(counterSeconds)

        }else if counterMinuts < 10 {
            timerCountLabel.text = String(counterHours) + div0 + String(counterMinuts) + div + String(counterSeconds)

        }else{
            timerCountLabel.text = String(counterHours) + div + String(counterMinuts) + div + String(counterSeconds)
        }
        if counterHours > 10 {
            floatGiveExp -= 0.1
        }else {
            floatGiveExp += 0.01
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
    @IBAction func timerStopButton() {
        timer.invalidate()
    }
    //リセットボタン
    @IBAction func timerResetButton() {
        timer.invalidate()
        counterSeconds = 0
        counterMinuts = 0
        counterHours = 0
        timerCountLabel.text = String(counterSeconds)
    }
    

}

