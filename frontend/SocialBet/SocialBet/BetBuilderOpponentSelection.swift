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
    
    @IBAction func CreateOpenBet(_ sender: Any) {
        self.entered_handle = "";
        performSegue(withIdentifier: "OpponentSelectToGameSelect", sender: self);
    }
    
    @IBAction func CreateDirectBet(_ sender: Any) {
        self.entered_handle = self.OpponentHandle.text;
        if (isValidHandle(handle: self.entered_handle, friends: true)){
            performSegue(withIdentifier: "OpponentSelectToGameSelect", sender: self);
        }
        else{
            self.alert(message: "The username entered does not match any of your friends. Please try again.");
        }
        
    }
}
