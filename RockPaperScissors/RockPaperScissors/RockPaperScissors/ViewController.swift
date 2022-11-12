//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Adam Rodrigues on 2022-10-30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!

    @IBOutlet weak var labelScores: UILabel!
    
    let imageNames: [String] = ["rock", "paper", "scissors"]
    var imageIndex: Int = 1;
    var imageName2: String = "paper"
    var playerWins: Int = 0
    var cpuWins: Int = 0
    var ties: Int = 0
    
    
    @IBAction func changeBtnTapped(_ sender: UIButton) {
        imageIndex = (imageIndex + 1) % 3
        imageName2 = imageNames[imageIndex]
        imageView2.image = UIImage(named: imageName2)
        
    }
    
    @IBAction func selectBtnTapped(_ sender: UIButton) {
        if let imageName1 = imageNames.randomElement(){
            imageView1.image = UIImage(named: imageName1)
            if imageName2 == imageName1 {
                ties += 1
            }else
            {
                switch imageName2 {
                case "rock":
                    if imageName1 == "paper"{
                        cpuWins += 1
                    }else{
                        playerWins += 1
                    }
                case "paper":
                    if imageName1 == "scissors"{
                        cpuWins += 1
                    }else{
                        playerWins += 1
                    }
                default: // imageName2 == "scissors"
                    if imageName1 == "rock"{
                        cpuWins += 1
                    }else{
                        playerWins += 1
                    }
                }
            }
            labelScores.text = "Total Scores: Computer \(cpuWins), You \(playerWins), Ties \(ties)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

