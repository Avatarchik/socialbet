//
//  BetBuilderOpponentSelection.swift
//  SocialBet
//

import UIKit

class BetBuilderOpponentSelection: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Here is the function where we define what to do during each segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("Prepare Override works!");
        
        //If going to next stage of bet builder
        if let vc = segue.destination as? BetBuilderGameSelection{
            vc.selectedOpponent = self.entered_handle;
        }
    }
    
    var entered_handle: String?;
    @IBOutlet weak var OpponentHandle: UITextField!
    
    @IBAction func GoHome(_ sender: Any) {
        performSegue(withIdentifier: "OpponentSelectToFeed", sender: self)
    }
    
    @IBAction func CreateOpenBet(_ sender: Any) {
        self.entered_handle = "";
        performSegue(withIdentifier: "OpponentSelectToGameSelect", sender: self);
    }
    
    @IBAction func CreateDirectBet(_ sender: Any) {
        self.entered_handle = self.OpponentHandle.text;
        var fullURI = addGETParams(path: "/api/users/find/", search: self.entered_handle!, needsUsername: true)
        sendGET(uri: fullURI, callback: { (httpresponse) in
            let data: Data! = httpresponse.data
            // decode the information recieved
            if httpresponse.HTTPsuccess! {
                guard let feedData = try? JSONDecoder().decode(UserExists.self, from: data)
                    else {
                        self.alert(message: "Error creating bet.")
                        return
                }
                if (feedData.first_name != nil){
                    if (feedData.friends!) {
                        // TODO: Pass feedData username to the next page
                        self.performSegue(withIdentifier: "OpponentSelectToGameSelect", sender: self)
                    } else {
                        self.alert(message: "Username entered does not match any of your friends. Please try again.")
                    }
                }
                else{
                    self.alert(message: "Username does not exists. Are you crazy? Please try again.")
                }
            } else{
                self.alert(message: "Error loading profile.")
            }
        })
    }
}

