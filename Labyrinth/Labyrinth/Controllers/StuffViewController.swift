//
//  StuffViewController.swift
//  Labyrinth
//
//  Created by Khasanza on 6/8/18.
//  Copyright © 2018 Neobis. All rights reserved.
//

import UIKit
protocol StuffDelegate: class {
    func updateCoins()
}
class StuffViewController: UIViewController {

    @IBOutlet weak var potionLabel: UILabel!
    @IBOutlet weak var swordLabel: UILabel!
    @IBOutlet weak var coinsLabel: UILabel!
    @IBOutlet weak var activeViewLeadingConstraint: NSLayoutConstraint!
    var player: Player?
    var stuffDelegate: StuffDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialValues()
        // Do any additional setup after loading the view.
    }
    private func setupInitialValues() {
        if let player = player, let currentRoom = player.currentRoom {
            self.coinsLabel.text = "\(currentRoom.coins)"
            self.swordLabel.text = currentRoom.sword ? "+1" : "0"
            self.potionLabel.text = currentRoom.potion ? "+1" : "0"
        }
    }
    @IBAction func potionDidTap(_ sender: Any) {
        if let player = player, let currentRoom = player.currentRoom {
            if currentRoom.potion {
                if !player.takeThingIfEnoughSpace(thingName: .potion) {
                    showAlertMessage(title: "Ups", message: "Your backpack is full, please check your backpack to drop unnecessary things")
                }
                setupInitialValues()
                return
            }
            showAlertMessage(title: "Ups", message: "There is now potion in this room")
            
        }
    }
    @IBAction func swordDidTap(_ sender: Any) {
        if let player = player, let currentRoom = player.currentRoom {
            if currentRoom.sword {
                if !player.takeThingIfEnoughSpace(thingName: .sword) {
                    showAlertMessage(title: "Ups", message: "Your backpack is full, please check your backpack to drop unnecessary things")
                }
                setupInitialValues()
                return
            }
            showAlertMessage(title: "Ups", message: "There is now sword in this room")
        }
    }
    @IBAction func coinsDidTap(_ sender: Any) {
        if let player = player, let currentRoom = player.currentRoom {
            if currentRoom.coins > 0 {
                player.addCoins(amount: currentRoom.coins)
                setupInitialValues()
                if let delegate = stuffDelegate {
                    delegate.updateCoins()
                }
                return
            }
            showAlertMessage(title: "Ups", message: "There is now coins in this room")
        }
    }
    @IBAction func backDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
}
