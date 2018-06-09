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
    func updateHp()
}
class StuffViewController: UIViewController {

    @IBOutlet weak var potionLabel: UILabel!
    @IBOutlet weak var swordLabel: UILabel!
    @IBOutlet weak var coinsLabel: UILabel!
    @IBOutlet weak var activeViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var backpackButton: UIButton!
    @IBOutlet weak var potionButton: UIButton!
    @IBOutlet weak var stuffImageView: UIImageView!
    
    @IBOutlet weak var stuffView: UIView!
    @IBOutlet weak var stuffViewVerticalConstraint: NSLayoutConstraint!
    var player: Player?
    var stuffDelegate: StuffDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupInitialValues()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupInitialValues()
    }
    private func setupInitialValues() {
        if let player = player, let currentRoom = player.getCurrentRoom() {
            self.coinsLabel.text = "\(currentRoom.coins)"
            self.swordLabel.text = currentRoom.sword ? "+1" : "0"
            self.potionLabel.text = "\(currentRoom.potion.count == 0 ? "" : "+")\(currentRoom.potion.count)"
        }
    }
    @IBAction func backpackDidTap(_ sender: Any) {
        
        let backPackViewController = storyboard?.instantiateViewController(withIdentifier: Constants.ControllerId.BACKPACK_VIEW_CONTROLLER) as! BackpackViewController
        backPackViewController.player = self.player!
        backPackViewController.backpackDelegate = self
        self.present(backPackViewController, animated: true, completion: nil)
    }
    
    @IBAction func potionDidTap(_ sender: Any) {
        if let player = player, let currentRoom = player.getCurrentRoom() {
            if currentRoom.potion.count > 0 {
                if !player.takeThingIfEnoughSpace(thingName: .potion) {
                    showAlertMessage(title: "Ups", message: Constants.Messages.FULL_BACKPACK)
                }
                setupInitialValues()
                animateStuff(name: "potion")
                return
            }
            showAlertMessage(title: "Ups", message: Constants.Messages.NO_POTION_ROOM)
            
        }
    }
    private func animateStuff(name: String) {
        stuffView.isHidden = false
        stuffImageView.image = UIImage.init(named: name)
        stuffViewVerticalConstraint.constant = 180
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            // Do animation
            self.view.layoutIfNeeded()

        }) { (finished) in
            self.stuffView.isHidden = true
            self.stuffViewVerticalConstraint.constant = 0
            
        }
    }
    @IBAction func swordDidTap(_ sender: Any) {
        if let player = player, let currentRoom = player.getCurrentRoom() {
            if currentRoom.sword {
                if !player.takeThingIfEnoughSpace(thingName: .sword) {
                    showAlertMessage(title: "Ups", message: Constants.Messages.FULL_BACKPACK)
                }
                setupInitialValues()
                animateStuff(name: "sword")
                return
            }
            showAlertMessage(title: "Ups", message: Constants.Messages.NO_SWORD_ROOM)
        }
    }
    @IBAction func coinsDidTap(_ sender: Any) {
        if let player = player, let currentRoom = player.getCurrentRoom() {
            if currentRoom.coins > 0 {
                player.addCoins(amount: currentRoom.coins)
                setupInitialValues()
                if let delegate = stuffDelegate {
                    delegate.updateCoins()
                }
                return
            }
            showAlertMessage(title: "Ups", message: Constants.Messages.NO_COINS_ROOM)
        }
    }
    @IBAction func backDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
}
extension StuffViewController: BackpackDelegate {
    func updateHp() {
        if let delegate = self.stuffDelegate {
            delegate.updateHp()
        }
    }
    
    
}
