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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BetBuilderWagerAndMessage{
            vc.userTeamName = self.user_team_name;
            vc.otherTeamName = self.other_team_name;
            print("user team: " + self.user_team_name!);
            print("other team: " + self.other_team_name!);
            vc.selected_game_id = self.selected_game_id;
            vc.selected_opponent = self.selected_opponent;
            vc.teamOne = self.teamOne;
            vc.teamTwo = self.teamTwo;
            vc.teamOneLogoURL = self.teamOneLogoURL;
            vc.teamTwoLogoURL = self.teamTwoLogoURL;
        }
        
        if let vc_back = segue.destination as? BetBuilderGameSelection{
            vc_back.selectedOpponent = self.selected_opponent
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
    
    @IBAction func GoBack(_ sender: Any) {
        //TODO prepare for segue by sending backwards info
        performSegue(withIdentifier: "TeamSelectToGameSelect", sender: self)
    }
    
    @IBAction func OkClick(_ sender: Any) {
        if(self.user_team_name == nil || self.user_team_name == ""){
            self.alert(message: "Must choose a team by clicking logo");
        }
        else{
            performSegue(withIdentifier: "TeamSelectionToWagerAndMessage", sender: self);
        }
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
