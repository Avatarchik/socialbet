//
//  BetBuilderTeamSelection.swift
//  SocialBet
//
//  Created by Alex Chapp on 11/7/18.
//  Copyright © 2018 Nick Cargill. All rights reserved.
//

import UIKit

class BetBuilderTeamSelection: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBOutlet weak var TeamOneLogo: UIImageView!
    
    @IBOutlet weak var TeamTwoLogo: UIImageView!
    
    @IBOutlet weak var TeamOneName: UILabel!
    
    @IBOutlet weak var TeamTwoName: UILabel!
    
    @IBOutlet weak var WagerAmountInput: UITextField!
    
    
    @IBAction func OkClick(_ sender: Any) {
        
        //TODO - Check to make sure wagerAmount isn't empty or like 0. Print error message if it is
        
        let userTeam = self.TeamOneName.text; //TODO - make this 2 if they select Team2 (listen to clicks of logos)
        let otherTeam = self.TeamTwoName.text; //TODO - update this based on actual clicks
        let opponentName = ""; //TODO - Fill this in
        let wagerAmount = self.WagerAmountInput.text;
        
        var alertMessage = "Confirm the details of your bet as listed below.\n Opponent: ";
            alertMessage = alertMessage + opponentName + "\n Your Team: "
            alertMessage = alertMessage + userTeam! + "\n Other Team: "
            alertMessage = alertMessage + otherTeam! + "\n Wager Amount: " + wagerAmount!;
        
        let alert = UIAlertController(title: "Bet Confirmation", message: alertMessage, preferredStyle: .alert) //TODO - Add Team, Opponent, and Amount Info
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: submitBet))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel it"), style: .default, handler: cancelBet))
        self.present(alert, animated: true, completion: nil)
        
        
        
        
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
