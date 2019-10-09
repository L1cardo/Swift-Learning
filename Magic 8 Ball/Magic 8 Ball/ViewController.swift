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
    
    func updateBallImage(){
        index = Int.random(in: 0...4)
        ball.image = UIImage(named: ballImage[index])
    }
    
    @IBOutlet weak var ball: UIImageView!

    @IBAction func askButton(_ sender: Any) {
        updateBallImage()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateBallImage()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateBallImage()
    }


}

