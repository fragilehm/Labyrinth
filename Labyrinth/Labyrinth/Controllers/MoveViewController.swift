//
//  MoveViewController.swift
//  Labyrinth
//
//  Created by Khasanza on 6/8/18.
//  Copyright © 2018 Neobis. All rights reserved.
//

import UIKit
protocol MoveDelegate: class {
    func move(direction: Direction)
}
class MoveViewController: UIViewController {

    @IBOutlet weak var northButton: UIButton!
    @IBOutlet weak var eastButton: UIButton!
    @IBOutlet weak var southButton: UIButton!
    @IBOutlet weak var westButton: UIButton!
    @IBOutlet weak var hintLabel: UILabel!

    var player = Player()
    var moveDelegate: MoveDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        hintLabel.text = "Hi \(player.getName()) in this maze you must find exit, but to find exit you should move. You have four choices to move, but some rooms are blocked. it means that only GREEN arrows are allowed."
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupInitialValues()
    }
    private func setupInitialValues() {
        if let currentRoom = player.getCurrentRoom() {
            setupArrowButtons(isAllowedToPass: currentRoom.north, button: northButton, directionName: "north")
            setupArrowButtons(isAllowedToPass: currentRoom.east, button: eastButton, directionName: "east")
            setupArrowButtons(isAllowedToPass: currentRoom.south, button: southButton, directionName: "south")
            setupArrowButtons(isAllowedToPass: currentRoom.west, button: westButton, directionName: "west")
        }
    }
    @IBAction func northDidTap(_ sender: Any) {
        move(direction: .north)
    }
    @IBAction func eastDidTap(_ sender: Any) {
        move(direction: .east)
    }
    @IBAction func southDidTap(_ sender: Any) {
        move(direction: .south)
    }
    @IBAction func westDidTap(_ sender: Any) {
        move(direction: .west)
    }
    private func move(direction: Direction) {
        self.dismiss(animated: true, completion: {
            if let delegate = self.moveDelegate {
                delegate.move(direction: direction)
            }
        })
        
    }
    private func setupArrowButtons(isAllowedToPass: Bool, button: UIButton, directionName: String) {
        if isAllowedToPass {
            setButtonImage(button: button, imageName: "\(directionName)_green")
            button.isEnabled = true
        } else {
            setButtonImage(button: button, imageName: "\(directionName)_red")
            button.isEnabled = false
        }
    }
    private func setButtonImage(button: UIButton, imageName: String) {
        button.setImage(UIImage.init(named: imageName), for: .normal)
    }
    @IBAction func backDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
