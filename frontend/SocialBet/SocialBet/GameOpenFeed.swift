//
//  GameOpenFeed.swift
//  SocialBet
//
//  Created by Alex Chapp on 12/4/18.
//  Copyright © 2018 SocialBet. All rights reserved.
//

import UIKit

class GameOpenFeed: UIViewController {
    
    var selected_game_id: Int?;
    var feedCount = 0;
    var openData: BetFeed?;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.BetsFeed.register(UINib(nibName: "OpenFeedCell", bundle:nil), forCellWithReuseIdentifier: "OpenFeedCell");
        
        //TODO perform GET request once this endpoint is set up.
    }
    
    @IBAction func GoHome(_ sender: UIButton) {
        //TODO go home
    }
    
    @objc func OpenAcceptButtonPressed(sender: UIButton){
        let parameters = ["loguser": common.username, "auth": common.pwhash, "bet_id": sender.tag as Any] as Dictionary<String, Any>;
        
        sendPOST(uri: "/api/betting/accept_bet/", parameters: parameters, callback: { (postresponse) in
            if postresponse["success_status"] as! String == "successful" {
                self.BetsFeed.reloadData();
                self.alert(message: "You have accepted the bet!", title: "Bet Accepted");
            } else {
                self.alert(message: "Bet unable to be accepted", title: "Bet Acceptance Error")
            }
        })
    }
    
    @IBOutlet weak var BetsFeed: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.feedCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OpenFeedCell", for: indexPath) as? OpenFeedCell;
        
        let thisBet = self.openData!.bets[indexPath.row];
        
        cell?.UserName.text = thisBet.user1.first_name + " " + thisBet.user1.last_name;
        cell?.UserTeamName.text = thisBet.user1.team;
        cell?.UserTeamLowerText.text = thisBet.user1.team;
        cell?.OtherTeamLowerText.text = thisBet.team2;
        cell?.BetAmount.text = "Amount: $" + String(thisBet.ammount);
        cell?.GameTime.text = thisBet.game_time;
        cell?.ProfilePic.setRounded()
        getImageFromUrl(urlString: thisBet.user1.profile_pic_url, imageView: (cell?.ProfilePic)!);
        getImageFromUrl(urlString: thisBet.team1_logo_url, imageView: (cell?.UserTeamLogo)!);
        getImageFromUrl(urlString: thisBet.team2_logo_url, imageView: (cell?.OtherTeamLogo)!);
        
        cell?.AcceptButton.tag = thisBet.bet_id
        cell?.AcceptButton.addTarget(self, action: #selector(OpenAcceptButtonPressed(sender:)), for: .touchUpInside)
        
        if(thisBet.user1.username == common.username){
            cell?.AcceptButton.isHidden = true;
            cell?.AcceptButton.isEnabled = false;
        }
        else{
            cell?.AcceptButton.isHidden = false;
            cell?.AcceptButton.isEnabled = true;
        }
        
        return cell!;
    }
}
