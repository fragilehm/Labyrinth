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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialValues()
        // Do any additional setup after loading the view.
    }
    private func setupInitialValues() {
        player.currentRoom = maze.maze[0][0]
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
        hideAll()
        showChildController(constraint: stuffControllerHorizontalConstraint)
    }
    @IBAction func moveDidTap(_ sender: Any) {
        hideAll()
        showChildController(constraint: moveControllerHorizontalConstraint)
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
        let differencePercentage = CGFloat(100 - player.health)
        let differenceWidth = differencePercentage * hpView.bounds.width / 100
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

