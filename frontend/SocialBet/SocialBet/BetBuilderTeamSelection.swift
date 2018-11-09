//
//  BetBuilderTeamSelection.swift
//  SocialBet
//

import UIKit

class BetBuilderTeamSelection: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        //TODO - Finalize the bet as user has confirmed. Will need to add parameters, just not sure what we will need yet.
        print("Bet Submitted!");
    }
    
    func cancelBet(alert: UIAlertAction!){
        //TODO - clear this info and cancel the bet. Return them to feeds page
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
        
        //TODO - Get wallclock time for time placed
        //TODO - Get game time and pass that too
        //TODO - Get Message from user
        //TODO - Send NOT accepted, YES direct
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
