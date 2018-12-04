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
        var auth = sha256(data: (submitpassword!).data(using: String.Encoding.utf8)! as NSData);
        auth = String(auth.dropFirst().dropLast())
        auth = auth.uppercased();
        common.username = submitusername!;
        common.pwhash = auth;
        // create a dictionary to pass the parameters in
        let parameters = ["username": submitusername, "auth": auth] as! Dictionary<String, String>
        
        // create and send a POST request
        sendPOST(uri: "/api/users/login/", parameters: parameters, callback: { (jsonDictionary) in
            // alert the user of success/failure, and either navigate away or refresh the page
            if jsonDictionary["success_status"] as! String == "successful" {
                //self.performSegue(withIdentifier: "LoginToFeed", sender: self)
                self.performSegue(withIdentifier: "SBLoginToCoinbaseLogin", sender: self)

            } else {
                self.alert(message: "The provided username and password pair wasn't recognized. Try again.", title: "Authentication Error")
                self.viewDidLoad()
            }
        })
    }
    
    @IBAction func LoginHelp(_ sender: Any) {
        performSegue(withIdentifier: "FakeLoginToProfile", sender: self)
    }
    
    @IBAction func GoToRegistration(_ sender: Any) {
        performSegue(withIdentifier: "LoginToRegistration", sender: self)
    }
    
    
    
}

