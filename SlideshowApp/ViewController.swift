//
//  ViewController.swift
//  SlideshowApp
//
//  Created by ouyou on 2019/04/05.
//  Copyright © 2019 ouyou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBAction func unwind(_ segue:UIStoryboardSegue){
        
    }
    var total:Int = 0
    var selected:Int = 0
    var nowImgIndex = 0
    var timer:Timer!
    var images:[String] = ["pic0","pic1","pic2","pic3","pic4","pic5","pic6","pic7"]

    override func viewDidLoad() {
        super.viewDidLoad()
    
        imageView.image = UIImage(named: "pic0")
    }

    //進むボタン
    @IBAction func showNextImg(_ sender: Any) {
        total += 1
        if total == images.count{
            imageView.image = UIImage(named: images[0])
            total = 0
        }else{
           imageView.image = UIImage(named: images[total])
        }
        
    }
    
    //戻るボタン
    @IBAction func showPreviousImg(_ sender: Any) {
        total -= 1
        if total == -1{
            total = images.count-1
            imageView.image = UIImage(named: images[total])
            
        }else{
            imageView.image = UIImage(named: images[total])
        }
    }
    
    //再生停止ボタン
    @IBAction func startStopBtn(_ sender: Any) {
        if selected == 0 {
            selected = 1
            startStopButton.setTitle("停止", for: .normal)
            nextButton.isEnabled = false
            previousButton.isEnabled = false
        
            if self.timer == nil {
                self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector:#selector(startShow(_:)), userInfo: nil, repeats: true)
            }
            }else if selected == 1{
            selected = 0
            startStopButton.setTitle("再生", for: .normal)
            nextButton.isEnabled = true
            previousButton.isEnabled = true
            if self.timer != nil {
                self.timer.invalidate()
                self.timer = nil
            }

        }
    }
    
        @objc func startShow(_:Timer){
        imageView.image = UIImage(named: images[nowImgIndex])
        nowImgIndex += 1
        if nowImgIndex == images.count {
            nowImgIndex = 0
        }
        
    }
    
    //セグエで渡すデータ
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let nowImage = imageView.image
        //print(type(of: nowImage))
        var resultViewController : ResultViewController = segue.destination as! ResultViewController
        resultViewController.image = nowImage
    }
    
}

