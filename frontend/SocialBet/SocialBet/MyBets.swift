//
//  MyBets.swift
//  SocialBet
//
//  Created by Alex Chapp on 11/8/18.
//  Copyright © 2018 Nick Cargill. All rights reserved.
//

import UIKit

class MyBets: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            
            //TODO - Set up all the necessary stuff in here
            
            return cell!;
            
        case .request:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveFeedCell", for: indexPath) as? LiveFeedCell;
            
            let thisBet = self.requestData!.bets[indexPath.row];
            
            //TODO - Set up all the necessary stuff in here
            
            return cell!;
        }
    }

}
