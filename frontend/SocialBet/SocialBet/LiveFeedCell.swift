//
//  LiveFeedCell.swift
//  SocialBet
//


import UIKit

class LiveFeedCell: UICollectionViewCell {
    
    @IBOutlet weak var User1Image: UIImageView!
    @IBOutlet weak var User2Image: UIImageView!
    @IBOutlet weak var Team1Image: UIImageView!
    @IBOutlet weak var Team2Image: UIImageView!
    @IBOutlet weak var User1Name: UILabel!
    @IBOutlet weak var User2Name: UILabel!
    @IBOutlet weak var Message: UILabel!
    @IBOutlet weak var TeamName1: UILabel!
    @IBOutlet weak var TeamName2: UILabel!
    @IBOutlet weak var GameTime: UILabel!    
    @IBOutlet weak var WagerAmount: UILabel!    
    @IBOutlet weak var DeclineButton: UIButton!
    @IBOutlet weak var AcceptButton: UIButton!
    var bet_id: Int?;
    
    @IBAction func HiddenAccept(_ sender: Any) {
        let parameters = ["loguser": common.username, "auth": common.pwhash, "bet_id": self.bet_id as Any] as Dictionary<String, Any>;
        
        sendPOST(uri: "/api/betting/accept_bet", parameters: parameters, callback: { (postresponse) in
            /*if postresponse.HTTPsuccess! {
             self.alert(message: "You have accepted the bet!", title: "Bet Accepted");
             }
             else{
             // TODO: check HTML error codes
             self.alert(message: "Bet unable to be accepted", title: "Bet Acceptance Error")
             }*/           
            
        })
    }
    
    @IBAction func HiddenDecline(_ sender: UIButton) {
        let parameters = ["loguser": common.username, "auth": common.pwhash, "bet_id": self.bet_id as Any] as Dictionary<String, Any>;
        
        sendPOST(uri: "/api/betting/cancel_bet", parameters: parameters, callback: { (postresponse) in
            /*if postresponse.HTTPsuccess! {
             self.alert(message: "You have declined the bet!", title: "Bet Declined");
             }
             else{
             // TODO: check HTML error codes
             self.alert(message: "Bet unable to be declined", title: "Bet Decline Error")
             }*/
        })
    }
    
}
