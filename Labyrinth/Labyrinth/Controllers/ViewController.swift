//
//  ViewController.swift
//  Labyrinth
//
//  Created by Khasanza on 6/5/18.
//  Copyright © 2018 Neobis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func startButtonTap(_ sender: Any) {
        if let name = nameTextField.text, !name.isEmpty {
            self.navigationController?.show((storyboard?.instantiateViewController(withIdentifier: Constants.ControllerId.MainScene))!, sender: self)
        } else {
            self.showAlertMessage(title: "Please", message: "Enter your name")
        }
    }
    

}

