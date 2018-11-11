//
//  Login.swift
//  SocialBet
//


import UIKit

class Login: UIViewController {
    
    // PAGE DATA ///////////////////////////////////////////////////////////////////////////////////
    
    @IBOutlet weak var LoginUsername: UITextField!
    @IBOutlet weak var LoginPassword: UITextField!
    
    let parameters: Dictionary<String, String> = [:];
    
    // PAGE MANAGEMENT METHODS /////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // reset the credentials
        self.LoginUsername.text = ""
        self.LoginPassword.text = ""
    }

    // PAGE INTERACTION METHODS ////////////////////////////////////////////////////////////////////
    @IBAction func LoginSubmit(_ sender: Any) {
        // get the user credentials from the textboxes
        let submitusername = LoginUsername.text
        let submitpassword = LoginPassword.text
        let auth = sha256(data: (submitpassword!).data(using: String.Encoding.utf8)! as NSData);
        // create a dictionary to pass the parameters in
        let parameters = ["username": submitusername, "auth": auth] as! Dictionary<String, String>
        
        // create and send a POST request
        let response = sendPOST(uri: "/api/accounts/login/", parameters: parameters)
        
        // alert the user of success/failure, and either navigate away or refresh the page
        if response.error == nil {
            // TODO: error isn't being handled properly, figure out
            performSegue(withIdentifier: "LoginToFeed", sender: self)
        }
        else{
            // TODO: check HTML error codes
            self.alert(message: "The provided username and password pair wasn't recognized. Try again.", title: "Authentication Error")
            viewDidLoad()
        }
    }
    
    @IBAction func LoginHelp(_ sender: Any) {
        // TODO - Create help page
    }
    
    @IBAction func GoToRegistration(_ sender: Any) {
        performSegue(withIdentifier: "LoginToRegistration", sender: self)
    }
}

