//
//  BetBuilderWagerAndMessage.swift
//  SocialBet
//
//  Created by Alex Chapp on 11/30/18.
//  Copyright © 2018 SocialBet. All rights reserved.
//

import UIKit

class BetBuilderWagerAndMessage: UIViewController {
    
    var userTeamName: String?
    var otherTeamName: String?
    var selected_game_id: Int?;
    var selected_opponent: String?;
    var teamOne: String?;
    var teamTwo: String?;
    var teamOneLogoURL: String?
    var teamTwoLogoURL: String?
    @IBOutlet weak var WagerAmountInput: UITextField!
    @IBOutlet weak var MessageInput: UITextField!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.WagerAmountInput.addTarget(self, action: #selector(WagerInputChanged(sender:)), for: .editingChanged)

        // Do any additional setup after loading the view.
    }
    
    //Use this function to pass data through segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("Override Works!");
        //if going to next stage of bet builder
        if let vc = segue.destination as? Feed {
            if (self.selected_opponent == "") {
                vc.feedType = .open
            } else {
                vc.feedType = .live
            }
            
        }
        
        if let vc_back = segue.destination as? BetBuilderTeamSelection{
            vc_back.selected_opponent = self.selected_opponent
            vc_back.selected_game_id = self.selected_game_id
            vc_back.teamOne = self.teamOne
            vc_back.teamTwo = self.teamTwo
            vc_back.teamOneLogoURL = self.teamOneLogoURL
            vc_back.teamTwoLogoURL = self.teamTwoLogoURL
        }
    }
    
    func submitBet(alert: UIAlertAction!) {
        let direct = (self.selected_opponent! != "");
        var parameters: Dictionary<String, Any>;
        
        parameters = ["loguser": common.username, "auth": common.pwhash, "game_id": self.selected_game_id!, "message": "", "amount": self.WagerAmountInput.text!, "user1": common.username, "user2": self.selected_opponent!, "team1": self.userTeamName!, "team2": self.otherTeamName!, "direct": direct, "accepted": false]
        
        sendPOST(uri: "/api/betting/place_bet/", parameters: parameters, callback: { (jsonDict) in
            print(jsonDict)
            // parse the data
            // TODOOOO
            
            // check for errors
            /*if postresponse.HTTPsuccess! {
             self.alert(message: "Your bet request was sent!", title: "Bet Successful");
             //TODO - perform segue going back to feed
             }
             else{
             // TODO: check HTML error codes
             self.alert(message: "Bet unable to be placed", title: "Bet Error")
             //TODO perform segue going back to beginning of bet builder
             }*/
            print("Bet Submitted!");
            self.performSegue(withIdentifier: "WagerAndMessageToFeed", sender: nil)
            
        })
    }
    
    func cancelBet(alert: UIAlertAction!){
        print("Bet Cancelled");
        performSegue(withIdentifier: "TeamSelectToOpponentSelect", sender: self)
    }
    

    @IBAction func OkClick(_ sender: Any) {
        
        let wagerAmount = self.WagerAmountInput.text;
        
        var alertMessage = "Confirm the details of your bet as listed below.\n Opponent: ";
        alertMessage = alertMessage + self.selected_opponent! + "\n Your Team: "
        alertMessage = alertMessage + self.userTeamName! + "\n Other Team: "
        alertMessage = alertMessage + self.otherTeamName! + "\n Wager Amount: " + wagerAmount!
        alertMessage = alertMessage + "\n Message: " + self.MessageInput.text!;
        
        let alert = UIAlertController(title: "Bet Confirmation", message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: submitBet))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel it"), style: .default, handler: cancelBet))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func WagerInputChanged(sender: UITextField){
        if let amountString = sender.text?.currencyInputFormatting() {
            sender.text = amountString
        }
    }
    
    @IBAction func GoBack(_ sender: Any) {
        performSegue(withIdentifier: "WagerToTeamSelection", sender: self)
    }
    
}
