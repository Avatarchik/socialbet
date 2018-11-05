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
        username = "";
        pwhash = "";
    }


    @IBOutlet weak var _username: UITextField!
    @IBOutlet weak var _password: UITextField!
    
    
    @IBAction func LoginSubmit(_ sender: Any) {
        //TODO - Send LoginUsername and LoginPassword for confirmation
    }
    
    @IBAction func LoginHelp(_ sender: Any) {
    }
    
    
    @IBAction func GoToRegistration(_ sender: Any) {
        // take the sha256 hash of the password
        username = _username.text!;
        pwhash = "TODO";
        
        
        // Submit a POST request containing the username and hash(passowrd)
        let url = URL(string: domain)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = (username + "&" + pwhash).data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            guard let data = data, error == nil, else {
                print("error=\(error)")
                return
            }
            
            
        }
        
        
        
        
        
        
        //performSegue(withIdentifier: "LoginToRegistration", sender: self)
    }
}

