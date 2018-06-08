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

    @IBOutlet weak var actionControllerHorizontalConstraint: NSLayoutConstraint!
    @IBOutlet weak var backpackcControllerHorizontalConstraint: NSLayoutConstraint!
    @IBOutlet weak var stuffControllerHorizontalConstraint: NSLayoutConstraint!
    @IBOutlet weak var moveControllerHorizontalConstraint: NSLayoutConstraint!
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
    @IBOutlet weak var hpView: UIView!
    @IBOutlet weak var hpViewTrailingConstraint: NSLayoutConstraint!
    var player = Player()
    var maze = Maze()
    var row = 0
    var col = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialValues()
        
        // Do any additional setup after loading the view.
    }
    private func setupInitialValues() {
        player.currentRoom = maze.maze[0][0]
        //let maze = Maze().maze
        for i in 0..<3 {
            for j in 0..<3 {
                print("     ", maze.maze[i][j].north)
                print(maze.maze[i][j].west, "     ", maze.maze[i][j].east)
                print("     ", maze.maze[i][j].south)
                print("enemy ", maze.maze[i][j].enemy)
                print("potion ", maze.maze[i][j].potion)
                print("sword ", maze.maze[i][j].sword)
                print("coins ", maze.maze[i][j].coins)

            }
        }
    }
    @IBAction func backpackDidTap(_ sender: Any) {
        let backPackViewController = storyboard?.instantiateViewController(withIdentifier: "BackpackViewController") as! BackpackViewController
        backPackViewController.player = self.player
        backPackViewController.backpackDelegate = self
        self.present(backPackViewController, animated: true, completion: nil)
//        hideAll()
//        showChildController(constraint: backpackcControllerHorizontalConstraint)
    }
    @IBAction func takeDidTap(_ sender: Any) {
        let stuffViewController = storyboard?.instantiateViewController(withIdentifier: "StuffViewController") as! StuffViewController
        stuffViewController.player = self.player
        stuffViewController.stuffDelegate = self
        self.present(stuffViewController, animated: true, completion: nil)
//        hideAll()
//        showChildController(constraint: stuffControllerHorizontalConstraint)
    }
    @IBAction func moveDidTap(_ sender: Any) {
        let moveViewController = storyboard?.instantiateViewController(withIdentifier: "MoveViewController") as! MoveViewController
        moveViewController.player = self.player
        moveViewController.moveDelegate = self
        self.present(moveViewController, animated: true, completion: nil)
//        hideAll()
//        showChildController(constraint: moveControllerHorizontalConstraint)
    }
    private func showChildController(constraint: NSLayoutConstraint) {
        constraint.constant = 0
        self.animateView(timeInterval: 0.5)
    }
    private func hideAll() {
        self.actionControllerHorizontalConstraint.constant = 500
        self.backpackcControllerHorizontalConstraint.constant = -500
        self.stuffControllerHorizontalConstraint.constant = 500
        self.moveControllerHorizontalConstraint.constant = -500
        self.animateView(timeInterval: 0.5)
    }
    @IBAction func generateMaze(_ sender: Any) {
        let maze = Maze().maze
        for i in 0..<3 {
            for j in 0..<3 {
                print("     ", maze[i][j].north)
                print(maze[i][j].west, "     ", maze[i][j].east)
                print("     ", maze[i][j].south)
                print("enemy ", maze[i][j].enemy)
                print("potion ", maze[i][j].potion)
                print("sword ", maze[i][j].sword)
            }
        }
    }
}
extension MainSceneViewController: BackpackDelegate {
    func updateHp() {
        //player.health = 80
        hpLabel.text = "\(player.health)"
        let differenceWidth = CGFloat(100 - player.health)
        hpViewTrailingConstraint.constant = differenceWidth
        self.animateView(timeInterval: 0.3)
        print("updated hp")
    }
//    private func animateView(timeInterval: TimeInterval) {
//        UIView.animate(withDuration: timeInterval) {
//            self.view.layoutIfNeeded()
//        }
//    }
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
            if let currentRoom = player.currentRoom, currentRoom.isExit {
                presentResultViewController(status: .winner)

                print("You win")
            } else {
                row += 1
            }
        case .west:
            col -= 1
        }
        checkForMonster(row: row, col: col)
        
    }
    private func checkForMonster(row: Int, col: Int) {
        let room = maze.maze[row][col]
        //showEnemyAlert(room: room)
        if room.enemy {
            showEnemyAlert(room: room)
        } else {
            player.moveToRoomIfNotExit(room: room)
            mainMessageTextView.text = "You are good to go, now you can move forward. But before that check HAND button, if you want to take additional stuff"
        }
    }
    private func showEnemyAlert(room: Room) {
        let alertController = UIAlertController(title: "Ups", message: "There a monster inside next room, you want to fight with him or choose another move if there is?", preferredStyle: .alert)
        let fightAction = UIAlertAction(title: "Fight", style: .default) { (action) in
            self.checkIfDead(room: room)
        }
        let chooseAnother = UIAlertAction(title: "Another", style: .cancel, handler : nil)
        alertController.addAction(fightAction)
        alertController.addAction(chooseAnother)
        self.present(alertController, animated: true, completion: nil)
    }
    private func checkIfDead(room: Room) {
        self.player.attackEnemy()
        if player.health == 0 {
            
            presentResultViewController(status: .loser)
            print("you lose")
            //you lose
        } else {
            updateHp()
            room.enemy = false
            player.moveToRoomIfNotExit(room: room)
            updateCoins(amount: 50)
            mainMessageTextView.text = "This fucking monster is dead, now you can move forward. But before that check HAND button, if you want to take additional stuff. By the way check you health, you can use your backpack to heal yoursef"
        }
    }
    private func updateCoins(amount: Int) {
        self.player.addCoins(amount: amount)
        self.coinsLabel.text = "\(self.player.coins)"
    }
    private func presentResultViewController(status: ResultStatus) {
        let resultViewController = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        resultViewController.player = self.player
        resultViewController.resultStatus = status
        self.present(resultViewController, animated: true, completion: nil)
    }
}
extension MainSceneViewController: StuffDelegate {
    func updateCoins() {
        self.coinsLabel.text = "\(player.coins)"
    }
}


