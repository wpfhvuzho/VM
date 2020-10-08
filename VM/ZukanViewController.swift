//
//  ZukanViewController.swift
//  VM
//
//  Created by 高橋　龍 on 2020/09/29.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit


var beforeExp: Int!

class ZukanViewController: UIViewController {
    
    @IBOutlet var gifImageYoung: UIImageView!
    @IBOutlet var gifImageMob: UIImageView!
    @IBOutlet var gifImageHero: UIImageView!
    @IBOutlet var gifImageGod: UIImageView!
    @IBOutlet var gifImageGenius: UIImageView!
    
    @IBOutlet var needExpLabel: UILabel!
    @IBOutlet var beforeExpLabel: UILabel!
    
    @IBOutlet var youngLabel: UILabel!
    @IBOutlet var mobLabel: UILabel!
    @IBOutlet var heroLabel: UILabel!
    @IBOutlet var godLabel: UILabel!
    @IBOutlet var geniusLabel: UILabel!
    @IBOutlet var Label: UILabel!

    var needExp: Int!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        youngLabel.isHidden = true
        mobLabel.isHidden = true
        heroLabel.isHidden = true
        godLabel.isHidden = true
        geniusLabel.isHidden = true

        if runk >= 0{
            gifImageYoung.loadGif(name: "young")
            needExp = 300 - exp
            youngLabel.isHidden = false
        }
        if runk >= 1 {
            gifImageMob.loadGif(name: "mob")
            needExp = 800 - exp
            mobLabel.isHidden = false
            
        }
        if runk >= 2 {
            gifImageGenius.loadGif(name: "genius")
            needExp = 1500 - exp
            
            geniusLabel.isHidden = false
        }
        if runk >= 3 {
            gifImageHero.loadGif(name: "hero")
            needExp = 3000 - exp
            heroLabel.isHidden = false
        }
        if runk >= 4 {
            gifImageGod.loadGif(name: "god")
            needExp =  exp
            godLabel.isHidden = false
            
        }
        
        
        needExpLabel.text = String(needExp)
        // Do any additional setup after loading the view.
        if timerStartOrStop == 0 {
            beforeExpLabel.text = "0"
        }else {
            beforeExpLabel.text = String(beforeExp)
        }
        
    }
    @IBAction func toFight() {
        let fightViewController = storyboard?.instantiateViewController(identifier: "FightViewController")
        self.present(fightViewController!, animated: false, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
