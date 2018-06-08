//
//  Extensions.swift
//  Labyrinth
//
//  Created by Khasanza on 6/6/18.
//  Copyright © 2018 Neobis. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlertMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: false, completion: nil)
    }
    func animateView(timeInterval: TimeInterval) {
        UIView.animate(withDuration: timeInterval) {
            self.view.layoutIfNeeded()
        }
    }
}
