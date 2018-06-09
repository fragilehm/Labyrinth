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
    @IBOutlet weak var resultCoinsLabel: UILabel!
    @IBOutlet weak var resultMovesLabel: UILabel!
    @IBOutlet weak var mazePathView: MazePathView!
    @IBOutlet weak var resultMessageLabel: UILabel!
    var player: Player!
    var resultStatus: ResultStatus = .loser
    override func viewDidLoad() {
        super.viewDidLoad()
        setupResult()
        // Do any additional setup after loading the view.
    }
    private func setupResult() {
        resultCoinsLabel.text = "\(player.getCoins())"
        resultMovesLabel.text = "\(player.getPathDirections().count)"
        switch resultStatus {
        case .winner:
            self.resultStatusLabel.text = "YOU WIN!"
            self.resultStatusLabel.textColor = .green
            resultMessageLabel.text = "Good job, \(player.getName()) you are true winner"
        case .loser:
            self.resultStatusLabel.text = "YOU LOSE!"
            self.resultStatusLabel.textColor = .red
            resultMessageLabel.text = "I am really sorry for you, \(player.getName()), but you can try another game"
        }
        drawPath()
    }
    private func drawPath() {
        for direction in player.getPathDirections() {
            print(direction)
            mazePathView.drawLine(direction: direction)
        }
    }
    @IBAction func newGameDidTap(_ sender: Any) {
        let mainViewController = UINavigationController(rootViewController: (storyboard?.instantiateViewController(withIdentifier: Constants.ControllerId.MAIN_VIEW_CONTROLLER))!)
        self.present(mainViewController, animated: false, completion: nil)
    }
    
}
