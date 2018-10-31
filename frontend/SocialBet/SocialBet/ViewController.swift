//
//  ViewController.swift
//  SocialBet
//
//  Created by Nick Cargill on 10/19/18.
//  Copyright © 2018 Nick Cargill. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBOutlet weak var LoginUsername: UITextField!
    @IBOutlet weak var LoginPassword: UITextField!
    
    
    @IBAction func LoginSubmit(_ sender: Any) {
        //TODO - Send LoginUsername and LoginPassword for confirmation
    }
    
    @IBAction func LoginHelp(_ sender: Any) {
    }
    
    
    @IBAction func GoToRegistration(_ sender: Any) {
        performSegue(withIdentifier: "LoginToRegistration", sender: self)
    }
}

