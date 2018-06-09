//
//  BackpackViewController.swift
//  Labyrinth
//
//  Created by Khasanza on 6/8/18.
//  Copyright © 2018 Neobis. All rights reserved.
//

import UIKit
enum ThingToUse {
    case potion
    case sword
}
protocol BackpackDelegate: class {
    func updateHp()
}
class BackpackViewController: UIViewController {

    @IBOutlet weak var potionCountLabel: UILabel!
    @IBOutlet weak var swordButton: UIButton!
    @IBOutlet weak var activeViewConstraint: NSLayoutConstraint!
    private var thingToUse = ThingName.potion
    var backpackDelegate: BackpackDelegate?
    var player = Player()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setupInitialValues()
    }
    private func setupInitialValues() {
        potionCountLabel.text = "\(player.getBackpack().getPotions().count)"
        if player.getBackpack().getSword() {
            swordButton.isHidden = false
        }
    }
    @IBAction func potionDidTap(_ sender: Any) {
        updateActiveButton(constant: 24)
        thingToUse = .potion
    }
    
    @IBAction func swordDidTap(_ sender: Any) {
        let screenWidth = UIScreen.main.bounds.width
        let leftContraint = screenWidth * 2 / 3 - 24
        updateActiveButton(constant: leftContraint)
        thingToUse = .sword
    }
    @IBAction func useThingDidTap(_ sender: Any) {
        switch thingToUse {
        case .potion:
            if !player.useThingIfThereIsOne(thingName: .potion) {
                showAlertMessage(title: "I am really sorry", message: Constants.Messages.NO_POTION_USE)
            } else {
                updatePotionCount()
            }
        case .sword:
            if !player.useThingIfThereIsOne(thingName: .sword) {
                showAlertMessage(title: "I am really sorry", message: Constants.Messages.NO_SWORD_USE)
            }
        }
    }
    @IBAction func dropThingDidTap(_ sender: Any) {
        switch thingToUse {
        case .potion:
            if  !player.dropThingIfNotEmpty(thingName: .potion) {
                showAlertMessage(title: "Shit", message: Constants.Messages.NO_POTION_DROP)
            } else {
                updatePotionCount()
            }
        case .sword:
            if !player.dropThingIfNotEmpty(thingName: .sword) {
                showAlertMessage(title: "Shit", message: Constants.Messages.NO_SWORD_DROP)
            } else {
                self.swordButton.isHidden = true
                thingToUse = .potion
                updateActiveButton(constant: 24)
            }
        }
    }
    @IBAction func backDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    private func updateActiveButton(constant: CGFloat) {
        self.activeViewConstraint.constant = constant
        self.animateView(timeInterval: 0.3)
    }
    private func updatePotionCount() {
        self.potionCountLabel.text = "\(player.getBackpack().getPotions().count)"
        if let delegate = backpackDelegate {
            delegate.updateHp()
        }
    }
}
