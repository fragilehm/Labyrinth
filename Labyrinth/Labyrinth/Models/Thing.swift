//
//  Thing.swift
//  Labyrinth
//
//  Created by Khasanza on 6/6/18.
//  Copyright © 2018 Neobis. All rights reserved.
//

import Foundation
enum ThingName: Int {
    case potion = 10
    case sword  = 20
}
struct Thing {
    var name: ThingName
}
