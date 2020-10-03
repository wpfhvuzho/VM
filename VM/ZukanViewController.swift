//
//  ZukanViewController.swift
//  VM
//
//  Created by 高橋　龍 on 2020/09/29.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class ZukanViewController: UIViewController {
    
    @IBOutlet var gifImageYoung: UIImageView!
    @IBOutlet var gifImageMob: UIImageView!
    @IBOutlet var gifImageHero: UIImageView!
    @IBOutlet var gifImageGod: UIImageView!
    
    @IBOutlet var needExpLabel: UILabel!
    @IBOutlet var beforeExpLabel: UILabel!
    
    var needExp: Int!
    var beforeExp: Int!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if runk >= 0{
            gifImageYoung.loadGif(name: "young")
            needExp = 300 - exp
            
        }
        if runk >= 1 {
            gifImageMob.loadGif(name: "mob")
            needExp = 800 - exp
        }
        if runk >= 2 {
            gifImageHero.loadGif(name: "hero")
            needExp = 1500 - exp
        }
        if runk >= 3 {
            gifImageGod.loadGif(name: "god")
            needExp =  exp
            
        }
        
        
        
        beforeExp = giveExp
        needExpLabel.text = String(needExp)
        // Do any additional setup after loading the view.
        beforeExpLabel.text = String(beforeExp)
    }
    @IBAction func toFight() {
        let fightViewController = storyboard?.instantiateViewController(identifier: "FightViewController")
        self.present(fightViewController!, animated: false, completion: nil)
        timerStartOrStop += 1
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
