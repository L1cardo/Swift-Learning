//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Licardo on 2019/10/9.
//  Copyright © 2019 Licardo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let ballImage = ["ball1", "ball2", "ball3", "ball4", "ball5"]
    var index = 0
    
    // 换8号球函数
    func updateBallImage(){
        index = Int.random(in: 0...4)
        ball.image = UIImage(named: ballImage[index])
    }
    
    @IBOutlet weak var ball: UIImageView!

    // 按键
    @IBAction func askButton(_ sender: Any) {
        updateBallImage()
    }
    
    // 摇手机
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateBallImage()
    }
    
    // 界面加载
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateBallImage()
    }


}

