//
//  Constants.swift
//  Labyrinth
//
//  Created by Khasanza on 6/6/18.
//  Copyright © 2018 Neobis. All rights reserved.
//

import Foundation
import UIKit
struct Constants {
    struct ControllerId {
        static let MAIN_VIEW_CONTROLLER = "MainViewController"
        static let MAIN_SCENE = "MainSceneViewController"
        static let BACKPACK_VIEW_CONTROLLER = "BackpackViewController"
        static let STUFF_VIEW_CONTROLLER = "StuffViewController"
        static let MOVE_VIEW_CONTROLLER = "MoveViewController"
        static let RESULT_VIEW_CONTROLLER = "ResultViewController"

    }
    struct Messages {
        static let GOOD_TO_GO = "You are good to go, now you can move forward. But before that check HAND button, if you want to take additional stuff"
        static let ENEMY_ALERT = "There a monster inside next room, you want to fight with him or choose another move if there is?"
        static let MONSTER_IS_DEAD = "This fucking monster is dead, now you can move forward. But before that check HAND button, if you want to take additional stuff. By the way check you health, you can use your backpack to heal yoursef"
        static let NO_POTION_USE = "You dont have any potions to use"
        static let NO_SWORD_USE = "You dont have any sword to use"
        static let NO_POTION_DROP = "Your backpack doesn't has potions to drop"
        static let NO_SWORD_DROP = "Your backpack doesn't has sword to drop"
        static let NO_SWORD_ROOM = "There is now sword in this room"
        static let NO_POTION_ROOM = "There is now potion in this room"
        static let NO_COINS_ROOM = "There is now coins in this room"
        static let FULL_BACKPACK = "Your backpack is full, please check your backpack to drop unnecessary things"


    }
}
