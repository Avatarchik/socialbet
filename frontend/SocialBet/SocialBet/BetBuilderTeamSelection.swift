//
//  BetBuilderTeamSelection.swift
//  SocialBet
//

import UIKit

class BetBuilderTeamSelection: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.TeamOneLogo.isUserInteractionEnabled = true;
        self.TeamTwoLogo.isUserInteractionEnabled = true;
        
        let firstRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.teamOneSelected(sender:)))
        firstRecognizer.delegate = self
        let secondRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.teamTwoSelected(sender:)))
        self.TeamOneLogo.addGestureRecognizer(firstRecognizer)
        self.TeamTwoLogo.addGestureRecognizer(secondRecognizer)
    }
    
    @objc func teamOneSelected(sender: AnyObject){
        self.TeamOneName.textColor = UIColor.green;
        self.TeamTwoName.textColor = UIColor.black;
        self.user_team_name = self.TeamOneName.text;
        self.other_team_name = self.TeamTwoName.text;
    }
    
    @objc func teamTwoSelected(sender: AnyObject){
        self.TeamTwoName.textColor = UIColor.green;
        self.TeamOneName.textColor = UIColor.black;
        self.user_team_name = self.TeamTwoName.text;
        self.other_team_name = self.TeamOneName.text;
    }
    
    func submitBet(alert: UIAlertAction!) {
        let direct = (self.selected_opponent != "");
        
        let parameters = ["loguser": username, "auth": pwhash, "game_id": self.selected_game_id!, "message": "", "amount": self.WagerAmountInput.text!, "user1": username, "user2": self.selected_opponent!, "direct": direct, "accepted": false] as! Dictionary<String, String>
        
        let response = sendPOST(uri: "/api/betting/place_bet", parameters: parameters)
        
        if response.error == nil {
            self.alert(message: "Your bet request was sent!", title: "Bet Successful");
            //TODO - perform segue going back to feed
        }
        else{
            // TODO: check HTML error codes
            self.alert(message: "Bet unable to be placed", title: "Bet Error")
            //TODO perform segue going back to beginning of bet builder
        }
        
        print("Bet Submitted!");
    }
    
    func cancelBet(alert: UIAlertAction!){
        //TODO - perform segue back to beginning of bet builder
        print("Bet Cancelled");
    }
    
    var selected_game_id: Int?;
    var selected_opponent: String?;
    var user_team_name: String?;
    var other_team_name: String?;
    @IBOutlet weak var TeamOneLogo: UIImageView!
    
    @IBOutlet weak var TeamTwoLogo: UIImageView!
    
    @IBOutlet weak var TeamOneName: UILabel!
    
    @IBOutlet weak var TeamTwoName: UILabel!
    
    @IBOutlet weak var WagerAmountInput: UITextField!
    
    
    @IBAction func OkClick(_ sender: Any) {
        
        //TODO - Check to make sure wagerAmount isn't empty or 0. Print error message if it is
        let wagerAmount = self.WagerAmountInput.text;
        
        var alertMessage = "Confirm the details of your bet as listed below.\n Opponent: ";
            alertMessage = alertMessage + self.selected_opponent! + "\n Your Team: "
            alertMessage = alertMessage + self.user_team_name! + "\n Other Team: "
            alertMessage = alertMessage + self.other_team_name! + "\n Wager Amount: " + wagerAmount!;
        
        let alert = UIAlertController(title: "Bet Confirmation", message: alertMessage, preferredStyle: .alert) //TODO - Add Team, Opponent, and Amount Info
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: submitBet))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel it"), style: .default, handler: cancelBet))
        self.present(alert, animated: true, completion: nil)      
        
    }
}
