//
//  ViewController.swift
//  Dicee
//
//  Created by Licardo on 2019/10/8.
//  Copyright © 2019 Licardo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let diceArray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    var index1: Int = 0
    var index2: Int = 0
    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    // 按键摇骰子
    @IBAction func rollButton(_ sender: Any) {
        updateDiceImages()
    }
    
    // 摇晃手机
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }
    
    // 界面加载
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateDiceImages()
    }

    // 摇骰子函数
    func updateDiceImages(){
        index1 = Int.random(in: 0...5)
        index2 = Int.random(in: 0...5)
        
        diceImageView1.image = UIImage(named: diceArray[index1])
        diceImageView2.image = UIImage(named: diceArray[index2])
    }

}

