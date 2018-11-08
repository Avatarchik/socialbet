//
//  Profile.swift
//  SocialBet
//
//  Created by John Krieg on 10/31/18.
//  Copyright © 2018 Nick Cargill. All rights reserved.
//

import UIKit

class Profile: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserHandle: UILabel!
    @IBOutlet weak var ProfileBetFeed: UICollectionView!
    
    enum ProfileFeedTypes{
        case live
        case open
        case closed
    }
    
    var feedType = ProfileFeedTypes.live;
    
    @IBAction func InitiateBet(_ sender: Any) {
        performSegue(withIdentifier: "FakeProfileToOpponentSelect", sender: self);
    }
    
    @IBAction func LiveBets(_ sender: Any) {
        feedType = .live;
        self.ProfileBetFeed.reloadData();
    }
    
    @IBAction func OpenBets(_ sender: Any) {
        feedType = .open;
        self.ProfileBetFeed.reloadData();
    }
    
    
    @IBAction func BetweenUs(_ sender: Any) {
        feedType = .closed;
        self.ProfileBetFeed.reloadData();
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ProfileBetFeed.register(UINib(nibName: "LiveFeedCell", bundle:nil), forCellWithReuseIdentifier: "LiveFeedCell");
        self.ProfileBetFeed.register(UINib(nibName: "OpenFeedCell", bundle:nil), forCellWithReuseIdentifier: "OpenFeedCell");
        self.ProfileBetFeed.register(UINib(nibName: "ClosedFeedCell", bundle:nil), forCellWithReuseIdentifier: "ClosedFeedCell");

        // Do any additional setup after loading the view.
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /*switch feedType {
         case .live:
         let data: Data = Data(); //TODO - Load the correct data with API call for live feed
         guard let feed = try? JSONDecoder().decode(LiveBetFeed.self, from: data)
         else {
         print("Error decoding data");
         return 0;
         }
         return feed.bets.count;
         
         
         case .open:
         let data: Data = Data(); //TODO - Load the correct data with API call for open feed
         guard let feed = try? JSONDecoder().decode(OpenBetFeed.self, from: data)
         else {
         print("Error decoding data");
         return 0;
         }
         return feed.bets.count;
         
         case .games:
         let data: Data = Data(); //TODO - Load the correct data with API call for games feed
         guard let feed = try? JSONDecoder().decode(GamesFeed.self, from: data)
         else {
         print("Error decoding data");
         return 0;
         }
         return feed.games.count;
         }*/
        return 4;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch feedType {
            
        case .live:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveFeedCell", for: indexPath) as? LiveFeedCell;
            
            let data: Data = Data(); //TODO - Load the correct data with API call
            guard let feed = try? JSONDecoder().decode(LiveBetFeed.self, from: data)
                else {
                    print("Error decoding data");
                    return cell!;
            }
            
            let thisBet = feed.bets[indexPath.row];
            
            cell?.User1Name.text = thisBet.user1.first_name + " " + thisBet.user1.last_name;
            cell?.User2Name.text = thisBet.user2.first_name + " " + thisBet.user2.last_name;
            cell?.User1Image.image = getImageFromUrl(urlString: thisBet.user1.profile_pic_url);
            cell?.User2Image.image = getImageFromUrl(urlString: thisBet.user2.profile_pic_url);
            cell?.Team1Image.image = getImageFromUrl(urlString: thisBet.user1.team_logo_url);
            cell?.Team2Image.image = getImageFromUrl(urlString: thisBet.user2.team_logo_url);
            cell?.TeamName1.text = thisBet.user1.team;
            cell?.TeamName2.text = thisBet.user2.team;
            cell?.Message.text = thisBet.message;
            cell?.GameTime.text = thisBet.game_time;
            
            return cell!;
            
        case .open:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OpenFeedCell", for: indexPath) as? OpenFeedCell;
            
            let data: Data = Data(); //TODO - Load the correct data with API call
            guard let feed = try? JSONDecoder().decode(OpenBetFeed.self, from: data)
                else {
                    print("Error decoding data");
                    return cell!;
            }
            
            let thisBet = feed.bets[indexPath.row];
            
            cell?.UserName.text = thisBet.user.first_name + " " + thisBet.user.last_name;
            cell?.UserTeamName.text = thisBet.user.team;
            cell?.UserTeamLogo.image = getImageFromUrl(urlString: thisBet.user.team_logo_url);
            cell?.UserTeamLowerText.text = thisBet.user.team;
            cell?.OtherTeamLogo.image = getImageFromUrl(urlString: thisBet.other_team_logo_url);
            cell?.OtherTeamLowerText.text = thisBet.other_team;
            cell?.BetAmount.text = "Amount: $" + String(thisBet.amount);
            cell?.GameTime.text = thisBet.game_time;
            
            return cell!;
            
        case .closed:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClosedFeedCell", for: indexPath) as? ClosedFeedCell;
            
            let data: Data = Data(); //TODO - Load the correct data with API call
            guard let feed = try? JSONDecoder().decode(ClosedBetFeed.self, from: data)
                else {
                    print("Error decoding data");
                    return cell!;
            }
            
            //TODO - Figure out how to correctly use this indexPath thing for nested arrays
            
            let thisBet = feed.bets[indexPath.row];
            
            cell?.WinningTeamLogo.image = getImageFromUrl(urlString: thisBet.winningUser.team_logo_url);
            cell?.WinningTeamName.text = thisBet.winningUser.team;
            cell?.LosingTeamLogo.image = getImageFromUrl(urlString: thisBet.losingUser.team_logo_url);
            cell?.LosingTeamName.text = thisBet.losingUser.team;
            cell?.FinalScore.text = thisBet.finalScore;
            cell?.GameDateTime.text = thisBet.game_time;
            cell?.WinningUserPic.image = getImageFromUrl(urlString: thisBet.winningUser.profile_pic_url);
            cell?.WinningUserName.text = thisBet.winningUser.first_name + " " + thisBet.winningUser.last_name;
            cell?.LosingUserPic.image = getImageFromUrl(urlString: thisBet.losingUser.profile_pic_url);
            cell?.LosingUserName.text = thisBet.losingUser.first_name + " " + thisBet.losingUser.last_name;
            
            return cell!;
        }        
        
    }


}
