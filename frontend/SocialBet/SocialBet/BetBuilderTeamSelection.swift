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
        getImageFromUrl(urlString: self.teamOneLogoURL!, imageView: self.TeamOneLogo)
        getImageFromUrl(urlString: self.teamTwoLogoURL!, imageView: self.TeamTwoLogo)
        
        self.TeamOneName.text = self.teamOne;
        self.TeamTwoName.text = self.teamTwo;
        
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
    }
    
    func submitBet(alert: UIAlertAction!) {
        let direct = (self.selected_opponent != "");
        
        let parameters = ["loguser": common.username, "auth": common.pwhash, "game_id": self.selected_game_id!, "message": "", "amount": self.WagerAmountInput.text!, "user1": common.username, "user2": self.selected_opponent!, "direct": direct, "accepted": false] as! Dictionary<String, Any>
        
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
            self.performSegue(withIdentifier: "TeamSelectToFeed", sender: nil)
            
        })
    }
    
    func cancelBet(alert: UIAlertAction!){
        print("Bet Cancelled");
        performSegue(withIdentifier: "TeamSelectToOpponentSelect", sender: self)
    }
    
    var selected_game_id: Int?;
    var selected_opponent: String?;
    var user_team_name: String?;
    var other_team_name: String?;
    var teamOne: String?;
    var teamTwo: String?;
    var teamOneLogoURL: String?
    var teamTwoLogoURL: String?
    
    @IBOutlet weak var TeamOneLogo: UIImageView!
    
    @IBOutlet weak var TeamTwoLogo: UIImageView!
    
    @IBOutlet weak var TeamOneName: UILabel!
    
    @IBOutlet weak var TeamTwoName: UILabel!
    
    @IBOutlet weak var WagerAmountInput: UITextField!
    
    @IBOutlet weak var MessageInput: UITextField!
    
    @IBAction func GoBack(_ sender: Any) {
        performSegue(withIdentifier: "TeamSelectToGameSelect", sender: self)
    }
    
    @IBAction func OkClick(_ sender: Any) {
        
        let wagerAmount = self.WagerAmountInput.text;
        
        var alertMessage = "Confirm the details of your bet as listed below.\n Opponent: ";
        alertMessage = alertMessage + self.selected_opponent! + "\n Your Team: "
        alertMessage = alertMessage + self.teamOne! + "\n Other Team: "
        alertMessage = alertMessage + self.teamTwo! + "\n Wager Amount: " + wagerAmount!
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
