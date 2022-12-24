//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes: [String: Int] = ["Soft": 5, "Medium": 7, "Hard": 12]
    private var timer = Timer()
    var time = 0
    var progressValue: Float = 0
    
    var player: AVAudioPlayer!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        titleLabel.text = "How do you like your eggs?"
        progress.progress = 0
        
        let hardness = sender.currentTitle!
        time = eggTimes[hardness]! // * 60
        
        
        // timer処理
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {(timer) in
            print(self.time)
            self.time -= 1
            self.progressValue = round((1 - (Float(self.time) / Float(self.eggTimes[hardness]!))) * 10) / 10
            print(self.progressValue)
            self.progress.progress = self.progressValue
            if self.time == 0 {
                timer.invalidate()
                self.titleLabel.text = "completed !"
                self.sound()
            }
        })
        
    }
    
    private func sound(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}
