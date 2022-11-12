//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Adam Rodrigues on 2022-10-30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cpuImageView: UIImageView!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var labelScores: UILabel!
    
    let imageNames: [String] = ["rock", "paper", "scissors"]
    var playerImageIndex: Int = 1;
    var playerImageName: String = "paper"
    var playerWins: Int = 0
    var cpuWins: Int = 0
    var ties: Int = 0
    
    
    @IBAction func changeBtnTapped(_ sender: UIButton) {
        playerImageIndex = (playerImageIndex + 1) % 3
        playerImageName = imageNames[playerImageIndex]
        playerImageView.image = UIImage(named: playerImageName)
        
    }
    
    @IBAction func selectBtnTapped(_ sender: UIButton) {
        if let cpuImageName = imageNames.randomElement(){
            cpuImageView.image = UIImage(named: cpuImageName)
            if playerImageName == cpuImageName {
                ties += 1
            }else
            {
                switch playerImageName {
                case "rock":
                    if cpuImageName == "paper"{
                        cpuWins += 1
                    }else{
                        playerWins += 1
                    }
                case "paper":
                    if cpuImageName == "scissors"{
                        cpuWins += 1
                    }else{
                        playerWins += 1
                    }
                default: // playerImageName == "scissors"
                    if cpuImageName == "rock"{
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

