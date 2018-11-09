//
//  Login.swift
//  SocialBet
//


import UIKit

class ViewController: UIViewController {
    
    // PAGE DATA ///////////////////////////////////////////////////////////////////////////////////
    
    @IBOutlet weak var LoginUsername: UITextField!
    @IBOutlet weak var LoginPassword: UITextField!
    
    // PAGE MANAGEMENT METHODS /////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // reset the credentials
        LoginUsername.text = ""
        LoginPassword.text = ""
    }

    // PAGE INTERACTION METHODS ////////////////////////////////////////////////////////////////////
    
    // Login Button
    // Send a POST request to /api/v1/accounts/login/
    // {username:"", pwhash:""}
    @IBAction func LoginSubmit(_ sender: Any) {
        // get the user credentials from the textboxes
        let submitusername = LoginUsername.text
        let submitpassword = LoginPassword.text
        
        // create a dictionary to pass the parameters in
        let parameters = ["username": submitusername, "password": submitpassword] as! Dictionary<String, String>

        // create and send a POST request
        let response = sendPOST(uri: "/api/v1/accounts/login/", parameters: parameters)
        
        // alert the user of success/failure, and either navigate away or refresh the page
        if response.error != nil {
            performSegue(withIdentifier: "LoginToRegistration", sender: self)
        }
        else{
            alert(title: "Authentication Error", message: "The provided username and password pair wasn't recognized. Try again.")
            viewDidLoad()
        }
    }
    
    @IBAction func LoginHelp(_ sender: Any) {
        // TODO - Create help page
    }
    
    
    @IBAction func GoToRegistration(_ sender: Any) {
        performSegue(withIdentifier: "LoginToRegistration", sender: self)
    }
    
    // HELPER METHODS //////////////////////////////////////////////////////////////////////////////
    
    // the following are global functions
    func alert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present (alert, animated: true, completion: nil)
    }
}

