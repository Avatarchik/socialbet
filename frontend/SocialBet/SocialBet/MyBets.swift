//
//  MyBets.swift
//  SocialBet
//
//  Created by Alex Chapp on 11/8/18.
//  Copyright © 2018 Nick Cargill. All rights reserved.
//

import UIKit

class MyBets: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.MyFeed.register(UINib(nibName: "LiveFeedCell", bundle:nil), forCellWithReuseIdentifier: "LiveFeedCell");
        self.MyFeed.register(UINib(nibName: "OpenFeedCell", bundle:nil), forCellWithReuseIdentifier: "OpenFeedCell");
        self.MyFeed.register(UINib(nibName: "ClosedFeedCell", bundle:nil), forCellWithReuseIdentifier: "ClosedFeedCell");
    }
    
    enum FeedTypes{
        case live
        case open
        case result
        case request
    }
    
    
    @IBOutlet weak var ResultsObject: UIButton!
    @IBOutlet weak var RequestsObject: UIButton!
    @IBOutlet weak var OpenObject: UIButton!
    @IBOutlet weak var LiveObject: UIButton!
    
    var feedCount: Int?;
    var feedType = FeedTypes.live;
    var liveData: LiveBetFeed?;
    var openData: OpenBetFeed?;
    var requestData: LiveBetFeed?;
    var resultData: ClosedBetFeed?;
    var current_bet_id: String?;
    
    
    @IBAction func notificationsToHome() {
        performSegue(withIdentifier: "NotificationsToHome", sender: self)
    }
    
    @IBAction func Live(_ sender: Any) {
        self.LiveObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
        self.OpenObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
        self.ResultsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
        self.RequestsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
    }
    
    @IBAction func Open(_ sender: Any) {
        self.OpenObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
        self.LiveObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
        self.ResultsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
        self.RequestsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
    }
    
    @IBAction func Requests(_ sender: Any) {
        self.RequestsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
        self.OpenObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
        self.ResultsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
        self.LiveObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
    }
    
    @IBAction func Results(_ sender: Any) {
        self.ResultsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
        self.OpenObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
        self.LiveObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
        self.RequestsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
    }
    
    @objc func AcceptPressed(sender: LiveFeedCell) {
        let parameters = ["loguser": username, "auth": pwhash, "bet_id": sender.bet_id, "user_name": username] as! Dictionary<String, String>;
        
        let response = sendPOST(uri: "/api/betting/accept_bet", parameters: parameters)
        
        if response.error == nil {
            self.alert(message: "You have accepted the bet!", title: "Bet Accepted");
        }
        else{
            // TODO: check HTML error codes
            self.alert(message: "Bet unable to be accepted", title: "Bet Acceptance Error")
        }
        
        self.MyFeed.reloadData();
        
    }
    
    @objc func DeclinePressed(sender: LiveFeedCell){
        
        //TODO - Fix these parameters once I know what I have to send
        let parameters = ["loguser": username, "auth": pwhash, "bet_id": sender.bet_id, "user_name": username] as! Dictionary<String, String>;
        
        let response = sendPOST(uri: "/api/betting/cancel_bet", parameters: parameters)
        
        if response.error == nil {
            self.alert(message: "You have declined the bet!", title: "Bet Declined");
        }
        else{
            // TODO: check HTML error codes
            self.alert(message: "Bet unable to be declined", title: "Bet Decline Error")
        }
        
        self.MyFeed.reloadData();
    }
    
    
    @IBOutlet weak var MyFeed: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.feedCount!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch self.feedType {
            
        case .live:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveFeedCell", for: indexPath) as? LiveFeedCell;
            
            let thisBet = self.liveData!.bets[indexPath.row];
            
            cell?.User1Name.text = thisBet.user1.first_name + " " + thisBet.user1.last_name;
            cell?.User2Name.text = thisBet.user2.first_name + " " + thisBet.user2.last_name;
            getImageFromUrl(urlString: thisBet.user1.profile_pic_url, imageView: (cell?.User1Image)!);
            getImageFromUrl(urlString: thisBet.user2.profile_pic_url, imageView: (cell?.User2Image)!);
            getImageFromUrl(urlString: thisBet.user1_team.team_logo_url, imageView: (cell?.Team1Image)!);
            getImageFromUrl(urlString: thisBet.user2_team.team_logo_url, imageView: (cell?.Team2Image)!);
            cell?.TeamName1.text = thisBet.user1_team.name;
            cell?.TeamName2.text = thisBet.user2_team.name;
            cell?.Message.text = thisBet.message;
            cell?.GameTime.text = thisBet.game_time;
            cell?.WagerAmount.text = thisBet.wagerAmount;
            
            return cell!;
            
        case .open:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OpenFeedCell", for: indexPath) as? OpenFeedCell;
            
            let thisBet = self.openData!.bets[indexPath.row];
            
            cell?.UserName.text = thisBet.user.first_name + " " + thisBet.user.last_name;
            cell?.UserTeamName.text = thisBet.user_team.name;
            getImageFromUrl(urlString: thisBet.user_team.team_logo_url, imageView: (cell?.UserTeamLogo)!);
            cell?.UserTeamLowerText.text = thisBet.user_team.name;
            getImageFromUrl(urlString: thisBet.other_team.team_logo_url, imageView: (cell?.OtherTeamLogo)!);
            cell?.OtherTeamLowerText.text = thisBet.other_team.name;
            cell?.BetAmount.text = "Amount: $" + String(thisBet.amount);
            cell?.GameTime.text = thisBet.game_time;
            
            return cell!;
            
        case .result:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClosedFeedCell", for: indexPath) as? ClosedFeedCell;
            
            let thisBet = self.resultData!.bets[indexPath.row];
            
            getImageFromUrl(urlString: thisBet.winningUser.profile_pic_url, imageView: (cell?.WinningUserPic)!)
            getImageFromUrl(urlString: thisBet.losingUser.profile_pic_url, imageView: (cell?.LosingUserPic)!)
            cell?.WinningUserName.text = thisBet.winningUser.username;
            cell?.LosingUserName.text = thisBet.losingUser.username;
            getImageFromUrl(urlString: thisBet.winningTeam.team_logo_url, imageView: (cell?.WinningTeamLogo)!)
            getImageFromUrl(urlString: thisBet.losingTeam.team_logo_url, imageView: (cell?.LosingTeamLogo)!)
            cell?.WinningTeamName.text = thisBet.winningTeam.name;
            cell?.LosingTeamName.text = thisBet.losingTeam.name;
            cell?.GameDateTime.text = thisBet.game_time;
            cell?.FinalScore.text = thisBet.finalScore;
            cell?.WagerAmount.text = thisBet.wagerAmount;
            
            return cell!;
            
        case .request:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveFeedCell", for: indexPath) as? LiveFeedCell;
            
            let thisBet = self.requestData!.bets[indexPath.row];
            
            cell?.User1Name.text = thisBet.user1.first_name + " " + thisBet.user1.last_name;
            cell?.User2Name.text = thisBet.user2.first_name + " " + thisBet.user2.last_name;
            getImageFromUrl(urlString: thisBet.user1.profile_pic_url, imageView: (cell?.User1Image)!);
            getImageFromUrl(urlString: thisBet.user2.profile_pic_url, imageView: (cell?.User2Image)!);
            getImageFromUrl(urlString: thisBet.user1_team.team_logo_url, imageView: (cell?.Team1Image)!);
            getImageFromUrl(urlString: thisBet.user2_team.team_logo_url, imageView: (cell?.Team2Image)!);
            cell?.TeamName1.text = thisBet.user1_team.name;
            cell?.TeamName2.text = thisBet.user2_team.name;
            cell?.Message.text = thisBet.message;
            cell?.GameTime.text = thisBet.game_time;
            cell?.WagerAmount.text = thisBet.wagerAmount;
            cell?.bet_id = thisBet.bet_id;
            
            cell?.AcceptButton.image = UIImage(named: "accept.png")
            cell?.DeclineButton.image = UIImage(named: "decline.png")
            
            cell?.AcceptButton.isUserInteractionEnabled = true;
            cell?.DeclineButton.isUserInteractionEnabled = true;
            
            let acceptRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.AcceptPressed(sender:)))
            acceptRecognizer.delegate = self;
            cell?.AcceptButton.addGestureRecognizer(acceptRecognizer);
            
            let declineRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.DeclinePressed(sender:)))
            declineRecognizer.delegate = self;
            cell?.DeclineButton.addGestureRecognizer(declineRecognizer);
            
            return cell!;
        }
    }

}
