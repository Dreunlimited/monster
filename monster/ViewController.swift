//
//  ViewController.swift
//  monster
//
//  Created by Dandre Ealy on 12/13/15.
//  Copyright © 2015 Dandre Ealy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monsterImage: MonsterImg!
    @IBOutlet weak var foodImage: DragImg!
    @IBOutlet weak var heartImage: DragImg!
    
    @IBOutlet weak var deathSkull1: UIImageView!
    @IBOutlet weak var deathSkull2: UIImageView!
    @IBOutlet weak var deathSkull3: UIImageView!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_LIFE = 3
    var timer: NSTimer!
    var isMonsterHappy = false
    var currentItem: UInt32 = 0
    
    var currentLifeCount = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deathSkull1.alpha = DIM_ALPHA
        deathSkull2.alpha = DIM_ALPHA
        deathSkull3.alpha = DIM_ALPHA
        
        foodImage.dropTarget = monsterImage
        heartImage.dropTarget = monsterImage
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        startTimer()
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
            timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
        
    }
    
    
    func changeGameState() {
        
        if !isMonsterHappy {
            
            currentLifeCount++
            
            if currentLifeCount == 1 {
                deathSkull1.alpha = OPAQUE
                deathSkull2.alpha = DIM_ALPHA
                
            }else if currentLifeCount == 2 {
                deathSkull2.alpha = OPAQUE
                deathSkull3.alpha = DIM_ALPHA
            }
            else if currentLifeCount >= 3 {
                deathSkull3.alpha = OPAQUE
                
            } else {
                deathSkull1.alpha = DIM_ALPHA
                deathSkull2.alpha = DIM_ALPHA
                deathSkull3.alpha = DIM_ALPHA
            }
            
            if currentLifeCount >= MAX_LIFE {
                gameOver()
            }
        }
        
        let rand = arc4random_uniform(2)
        print(rand)
        
        if rand == 0 {
            foodImage.alpha = DIM_ALPHA
            foodImage.userInteractionEnabled = false
            print("ok")
            
            heartImage.alpha = OPAQUE
            heartImage.userInteractionEnabled = true
        } else {
            heartImage.alpha = DIM_ALPHA
            heartImage.userInteractionEnabled = false
            
            foodImage.alpha = OPAQUE
            foodImage.userInteractionEnabled = true
        }
        currentItem = rand
        isMonsterHappy = false
    }

    func gameOver() {
        timer.invalidate()
        monsterImage.playDeathAnimation()
        print("game over")
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
       isMonsterHappy = true
        startTimer()
        
        
        foodImage.alpha = DIM_ALPHA
        foodImage.userInteractionEnabled = false
        heartImage.alpha = DIM_ALPHA
        foodImage.userInteractionEnabled = false
        
    }
}

