//
//  ResultViewController.swift
//  Labyrinth
//
//  Created by Khasanza on 6/8/18.
//  Copyright © 2018 Neobis. All rights reserved.
//

import UIKit
enum ResultStatus {
    case winner
    case loser
}
class ResultViewController: UIViewController {

    @IBOutlet weak var resultStatusLabel: UILabel!
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultCoinsLabel: UILabel!
    @IBOutlet weak var resultMovesLabel: UILabel!
    var player: Player!
    var resultStatus: ResultStatus = .loser
    override func viewDidLoad() {
        super.viewDidLoad()
        setupResult()
        // Do any additional setup after loading the view.
    }
    private func setupResult() {
        resultCoinsLabel.text = "You got \(player.coins)"
        resultMovesLabel.text = "And \(38) moves"
        switch resultStatus {
        case .winner:
            self.resultStatusLabel.text = "YOU WIN!"
            self.resultStatusLabel.textColor = .green
            self.resultImageView.image = UIImage(named: "winner")
        case .loser:
            self.resultStatusLabel.text = "YOU LOSE!"
            self.resultStatusLabel.textColor = .red
            self.resultImageView.image = UIImage(named: "loser")
        }
    }
    
    @IBAction func newGameDidTap(_ sender: Any) {
    }
    
}
