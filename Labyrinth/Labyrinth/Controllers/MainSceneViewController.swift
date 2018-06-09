//
//  MainSceneViewController.swift
//  Labyrinth
//
//  Created by Khasanza on 6/6/18.
//  Copyright © 2018 Neobis. All rights reserved.
//

import UIKit
enum Direction: Int {
    case south = 0
    case east
    case north
    case west
}

class MainSceneViewController: UIViewController {


    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var mainMessageTextView: UITextView!
    @IBOutlet weak var coinsLabel: UILabel!
    @IBOutlet weak var hpSuperView: UIView! {
        didSet {
            hpSuperView.layer.borderWidth = 1
            hpSuperView.layer.borderColor = UIColor.black.cgColor
            hpSuperView.layer.masksToBounds = true
            hpSuperView.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var mazePathHintHorizontalConstraint: NSLayoutConstraint!
    @IBOutlet weak var mazePathHintView: UIView!
    @IBOutlet weak var mazePathView: MazePathView!
    @IBOutlet weak var hpView: UIView!
    @IBOutlet weak var hpViewTrailingConstraint: NSLayoutConstraint!
    var name = ""
    private var player = Player()
    private var maze = Maze()
    private var row = 0
    private var col = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialValues()
    }
    private func setupInitialValues() {
        player.setCurrentRoom(room: maze.getMaze()[0][0])
        player.setName(name: name)
        //let maze = Maze().maze
//        for i in 0..<3 {
//            for j in 0..<3 {
//                print("     ", maze.maze[i][j].north)
//                print(maze.maze[i][j].west, "     ", maze.maze[i][j].east)
//                print("     ", maze.maze[i][j].south)
//                print("enemy ", maze.maze[i][j].enemy)
//                print("potion ", maze.maze[i][j].potion)
//                print("sword ", maze.maze[i][j].sword)
//                print("coins ", maze.maze[i][j].coins)
//
//            }
//        }
    }
    @IBAction func backpackDidTap(_ sender: Any) {
        let backPackViewController = storyboard?.instantiateViewController(withIdentifier: Constants.ControllerId.BACKPACK_VIEW_CONTROLLER) as! BackpackViewController
        backPackViewController.player = self.player
        backPackViewController.backpackDelegate = self
        self.present(backPackViewController, animated: true, completion: nil)

    }
    @IBAction func takeDidTap(_ sender: Any) {
        let stuffViewController = storyboard?.instantiateViewController(withIdentifier: Constants.ControllerId.STUFF_VIEW_CONTROLLER) as! StuffViewController
        stuffViewController.player = self.player
        stuffViewController.stuffDelegate = self
        self.present(stuffViewController, animated: true, completion: nil)

    }
    @IBAction func moveDidTap(_ sender: Any) {
        let moveViewController = storyboard?.instantiateViewController(withIdentifier: Constants.ControllerId.MOVE_VIEW_CONTROLLER) as! MoveViewController
        moveViewController.player = self.player
        moveViewController.moveDelegate = self
        self.present(moveViewController, animated: true, completion: nil)

    }
    @IBAction func hideMazeHintDidTap(_ sender: Any) {
        mazePathHintHorizontalConstraint.constant = 500
        animateView(timeInterval: 0.5)
    }
}
extension MainSceneViewController: BackpackDelegate {
    func updateHp() {
        hpLabel.text = "\(player.getHealth())"
        let differenceWidth = CGFloat(100 - player.getHealth())
        hpViewTrailingConstraint.constant = differenceWidth
        self.animateView(timeInterval: 0.3)
        print("updated hp")
    }

}
extension MainSceneViewController: MoveDelegate {
    func move(direction: Direction) {
        print(direction)
        
        switch direction {
        case .north:
            row -= 1
        case .east:
            col += 1
        case .south:
            if player.isCurrentRoomAnExit() {
                presentResultViewController(status: .winner)
            } else {
                row += 1
            }
        case .west:
            col -= 1
        }
        let room = maze.getMaze()[row][col]

        checkForMonster(room: room, direction: direction)
        
    }
    private func checkForMonster(room: Room, direction: Direction) {
        if room.enemy {
            showEnemyAlert(room: room, direction: direction)
        } else {
            mazePathView.drawLine(direction: direction)
            player.moveToRoomIfNotExit(room: room, direction: direction)
            mainMessageTextView.text = Constants.Messages.GOOD_TO_GO
        }
    }
    private func showEnemyAlert(room: Room, direction: Direction) {
        let alertController = UIAlertController(title: "Ups", message: Constants.Messages.ENEMY_ALERT, preferredStyle: .alert)
        let fightAction = UIAlertAction(title: "Fight", style: .default) { (action) in
            self.checkIfDead(room: room, direction: direction)
        }
        let chooseAnother = UIAlertAction(title: "Another", style: .cancel, handler : { (action) in
            self.resetIndexes(direction: direction)
        })
        alertController.addAction(fightAction)
        alertController.addAction(chooseAnother)
        self.present(alertController, animated: true, completion: nil)
    }
    private func resetIndexes(direction: Direction) {
        switch direction {
        case .north:
            row += 1
        case .east:
            col -= 1
        case .south:
            row -= 1
        case .west:
            col += 1
        }
    }
    private func checkIfDead(room: Room, direction: Direction) {
        self.player.attackEnemy()
        if player.getHealth() == 0 {
            presentResultViewController(status: .loser)
            //you lose
        } else {
            updateHp()
            room.enemy = false
            mazePathView.drawLine(direction: direction)
            player.moveToRoomIfNotExit(room: room, direction: direction)
            updateCoins(amount: 50)
            mainMessageTextView.text = Constants.Messages.MONSTER_IS_DEAD
        }
    }
    private func updateCoins(amount: Int) {
        self.player.addCoins(amount: amount)
        self.coinsLabel.text = "\(self.player.getCoins())"
    }
    private func presentResultViewController(status: ResultStatus) {
        let resultViewController = storyboard?.instantiateViewController(withIdentifier: Constants.ControllerId.RESULT_VIEW_CONTROLLER) as! ResultViewController
        resultViewController.player = self.player
        resultViewController.resultStatus = status
        self.present(resultViewController, animated: true, completion: nil)
    }
}
extension MainSceneViewController: StuffDelegate {
    func updateCoins() {
        self.coinsLabel.text = "\(player.getCoins())"
    }
}


