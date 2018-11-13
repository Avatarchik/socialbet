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
        
        self.WagerAmountInput.addTarget(self, action: #selector(WagerInputChanged(sender:)), for: .editingChanged)
    }
    
    @objc func WagerInputChanged(sender: UITextField){
        if let amountString = sender.text?.currencyInputFormatting() {
            sender.text = amountString
        }
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
        
        let wagerNum = (self.WagerAmountInput.text! as NSString).floatValue;
        
        let parameters = ["loguser": username, "auth": pwhash, "game_id": self.selected_game_id!, "message": self.MessageInput.text!, "amount": wagerNum, "user1": username, "user2": self.selected_opponent!, "direct": direct, "accepted": false] as! Dictionary<String, String>
        
        let response = sendPOST(uri: "/api/betting/place_bet", parameters: parameters)
        
        if response.error == nil {
            self.alert(message: "Your bet request was sent!", title: "Bet Successful");
            performSegue(withIdentifier: "TeamSelectToFeed", sender: self) 
        }
        else{
            // TODO: check HTML error codes
            self.alert(message: "Bet unable to be placed", title: "Bet Error")
            performSegue(withIdentifier: "TeamSelectToOpponentSelect", sender: self)
        }
        
        print("Bet Submitted!");
    }
    
    func cancelBet(alert: UIAlertAction!){
        print("Bet Cancelled");
        performSegue(withIdentifier: "TeamSelectToOpponentSelect", sender: self)
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
    
    @IBOutlet weak var MessageInput: UITextField!
    
    //Use this function to pass data through segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("Override Works!");
        //if going to bet builder
        if let vc = segue.destination as? BetBuilderGameSelection{
            vc.selectedOpponent = self.selected_opponent;
        }
    }
    
    @IBAction func GoBack(_ sender: Any) {
        performSegue(withIdentifier: "TeamSelectToGameSelect", sender: self)
    }
    
    @IBAction func OkClick(_ sender: Any) {
        
        let wagerAmount = self.WagerAmountInput.text;
        
        var alertMessage = "Confirm the details of your bet as listed below.\n Opponent: ";
        alertMessage = alertMessage + self.selected_opponent! + "\n Your Team: "
        alertMessage = alertMessage + self.user_team_name! + "\n Other Team: "
        alertMessage = alertMessage + self.other_team_name! + "\n Wager Amount: " + wagerAmount!
        alertMessage = alertMessage + "\n Message: " + self.MessageInput.text!;
        
        let alert = UIAlertController(title: "Bet Confirmation", message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: submitBet))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel it"), style: .default, handler: cancelBet))
        self.present(alert, animated: true, completion: nil)      
        
    }
}

extension String {
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}
