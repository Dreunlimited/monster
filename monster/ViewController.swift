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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImage.dropTarget = monsterImage
        heartImage.dropTarget = monsterImage
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter", name: "onTargetDropped:", object: nil)
        
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        
        print("item on monster")
    }
}

