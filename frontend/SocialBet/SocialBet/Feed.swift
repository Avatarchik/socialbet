//
//  Feed.swift
//  SocialBet
//

import UIKit
import Foundation

func getImageFromUrl(urlString: String) -> UIImage {
    var image: UIImage = UIImage();
    let url:URL = URL(string: urlString)!;
    DispatchQueue.global(qos: .userInitiated).async {
        if let data:NSData = try? NSData(contentsOf: url){
            DispatchQueue.main.async {
                image = UIImage(data: data as Data)!;
            }
        }
        else{
            print("Error loading images");
        }
    }
    
    return image;
}

class Feed: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet weak var Collection: UICollectionView!
    
    @IBOutlet weak var SideMenuConstraint: NSLayoutConstraint!
    var sideMenuOpen = false
    
    func toggleSideMenu() {
        if (sideMenuOpen) {
            SideMenuConstraint.constant = -200
            sideMenuOpen = false
        } else {
            SideMenuConstraint.constant = 0
            sideMenuOpen = true
        }
    }
    
    
    
    @IBAction func menuTapped() {
        toggleSideMenu()
    }
    
    
    
    enum FeedTypes{
        case live
        case open
        case games
    }
    
    var feedType = FeedTypes.live;
    var feedData = Data()
    var feedCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        loadProfileInfo();
        
        // default to live bets view
        LiveBetsButton(self)
        
        self.Collection.register(UINib(nibName: "LiveFeedCell", bundle:nil), forCellWithReuseIdentifier: "LiveFeedCell");
        self.Collection.register(UINib(nibName: "OpenFeedCell", bundle:nil), forCellWithReuseIdentifier: "OpenFeedCell");
        self.Collection.register(UINib(nibName: "GamesFeedCell", bundle:nil), forCellWithReuseIdentifier: "GamesFeedCell");
        
    }
    
    @IBAction func LiveBetsButton(_ sender: Any) {
        // submit a GET request to get the live feed object
        let response: GETResponse? = sendGET(uri:"/api/v1/live/")
        let data: Data! = response?.data
        
        // decode the information recieved
        if response?.error != nil {
            guard let feedData = try? JSONDecoder().decode(LiveBetFeed.self, from: data)
            else {
                self.alert(message: "There was an error while decoding the response.", title: "Malformed Response Error")
                return
            }
            feedCount = feedData.bets.count;
        } else{
            self.alert(message: "There was an error processing your request.", title: "Network Error")
        }
        
        self.feedType = .live;
        self.Collection.reloadData();
    }
    
    @IBAction func OpenBetsButton(_ sender: Any) {
        // submit a GET request to get the open feed object
        let response: GETResponse? = sendGET(uri:"/api/v1/open/")
        let data: Data! = response?.data
        
        // decode the information recieved
        if response?.error != nil {
            guard let feedData = try? JSONDecoder().decode(OpenBetFeed.self, from: data)
                else {
                    self.alert(message: "There was an error while decoding the response.", title: "Malformed Response Error")
                    return
            }
            feedCount = feedData.bets.count;
        } else{
            self.alert(message: "There was an error processing your request.", title: "Network Error")
        }
        
        self.feedType = .open;
        self.Collection.reloadData();
    }
    
    @IBAction func GamesButton(_ sender: Any) {
        // submit a GET request to get the game feed object
        let response: GETResponse? = sendGET(uri:"/api/v1/games/")
        let data: Data! = response?.data
        
        // decode the information recieved
        if response?.error != nil {
            guard let feedData = try? JSONDecoder().decode(GamesFeed.self, from: data)
                else {
                    self.alert(message: "There was an error while decoding the response.", title: "Malformed Response Error")
                    return
            }
            feedCount = feedData.games.count;
        } else{
            self.alert(message: "There was an error processing your request.", title: "Network Error")
        }
        
        self.feedType = .games;
        self.Collection.reloadData();
    }
    
    func loadProfileInfo() {
        //TODO - Get the info for this user and use it to populate the profile pic and events
    }    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch self.feedType {
            
        case .live:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveFeedCell", for: indexPath) as? LiveFeedCell;
            
            guard let feed = try? JSONDecoder().decode(LiveBetFeed.self, from: feedData)
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
            
            guard let feed = try? JSONDecoder().decode(OpenBetFeed.self, from: feedData)
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
            
        case .games:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesFeedCell", for: indexPath) as? GamesFeedCell;
            
            guard let feed = try? JSONDecoder().decode(GamesFeed.self, from: feedData)
                else {
                    print("Error decoding data");
                    return cell!;
            }
            
            //TODO - Figure out how to correctly use this indexPath thing for nested arrays
            
            let theseGames = feed.games[indexPath.row];
            let thisGame = theseGames.games[indexPath.item];
            
            cell?.HomeTeamLogo.image = getImageFromUrl(urlString: thisGame.home_team.team_logo_url);
            cell?.AwayTeamLogo.image = getImageFromUrl(urlString: thisGame.away_team.team_logo_url);
            cell?.HomeTeamName.text = thisGame.home_team.name;
            cell?.AwayTeamName.text = thisGame.away_team.name;
            cell?.HomeTeamRecord.text = String(thisGame.home_team.wins) + "-" + String(thisGame.home_team.losses);
            cell?.AwayTeamRecord.text = String(thisGame.away_team.wins) + "-" + String(thisGame.away_team.losses);
            cell?.event_id = thisGame.event_id;
            
            return cell!;
        }
    }

}
