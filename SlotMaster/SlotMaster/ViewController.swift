//
//  ViewController.swift
//  SlotMaster
//
//  Created by Adam Rodrigues on 2022-10-27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var labelPoints: UILabel!
    
    let imageNames: [String] = ["cherries", "number7", "dollarsign", "lemon", "grapes"]
    
    var points:Int = 0
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        
        let random1 = imageNames.randomElement()
        let random2 = imageNames.randomElement()
        let random3 = imageNames.randomElement()
        
        if let imageName1 = random1,
           let imageName2 = random2,
           let imageName3 = random3{
            imageView1.image = UIImage(named: imageName1)
            imageView2.image = UIImage(named: imageName2)
            imageView3.image = UIImage(named: imageName3)
            
            if imageName1 == imageName2 &&
                imageName2 == imageName3{
                points += 5
            }else if imageName1 == imageName2 ||
                        imageName2 == imageName3 ||
                        imageName1 == imageName3{
                points += 2
            }
            labelPoints.text = "Total Points: \(points)"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    
}

