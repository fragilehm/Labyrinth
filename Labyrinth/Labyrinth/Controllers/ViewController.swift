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
            let mainSceneViewController = storyboard?.instantiateViewController(withIdentifier: Constants.ControllerId.MAIN_SCENE) as! MainSceneViewController
            mainSceneViewController.name = nameTextField.text!
            self.navigationController?.present(mainSceneViewController, animated: false, completion: nil)
        } else {
            self.showAlertMessage(title: "Please", message: "Enter your name")
        }
    }
    

}

