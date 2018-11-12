//
//  Feed.swift
//  SocialBet
//

import UIKit

class Feed: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet weak var Collection: UICollectionView!
    @IBOutlet weak var GamesObject: UIButton!
    @IBOutlet weak var OpenBetsObject: UIButton!
    @IBOutlet weak var LiveBetsObject: UIButton!
    
    
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
    var liveData: LiveBetFeed?;
    var openData: OpenBetFeed?;
    var gamesData: GamesFeed?;
    var feedCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        // default to live bets view
        LiveBetsButton(self)
        
        self.Collection.register(UINib(nibName: "LiveFeedCell", bundle:nil), forCellWithReuseIdentifier: "LiveFeedCell");
        self.Collection.register(UINib(nibName: "OpenFeedCell", bundle:nil), forCellWithReuseIdentifier: "OpenFeedCell");
        self.Collection.register(UINib(nibName: "GamesFeedCell", bundle:nil), forCellWithReuseIdentifier: "GamesFeedCell");
        
    }
    
    @IBAction func LiveBetsButton(_ sender: Any) {
        // submit a GET request to get the live feed object
        let fullURI = addGETParams(path: "/api/live/", search: "", needsUsername: false)
        let response: GETResponse? = sendGET(uri: fullURI);
        let data: Data! = response?.data
        
        // decode the information recieved
        if response?.error != nil {
            guard let feedData = try? JSONDecoder().decode(LiveBetFeed.self, from: data)
            else {
                self.alert(message: "There was an error while decoding the response.", title: "Malformed Response Error")
                return
            }
            self.liveData = feedData;
            feedCount = self.liveData!.bets.count;
        } else{
            self.alert(message: "There was an error processing your request.", title: "Network Error")
        }
        
        self.LiveBetsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
        self.OpenBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        self.GamesObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        self.feedType = .live;
        self.Collection.reloadData();
    }
    
    @IBAction func OpenBetsButton(_ sender: Any) {
        // submit a GET request to get the open feed object
        let fullURI = addGETParams(path: "/api/open/", search: "", needsUsername: false)
        let response: GETResponse? = sendGET(uri: fullURI);
        let data: Data! = response?.data
        
        // decode the information recieved
        if response?.error != nil {
            guard let feedData = try? JSONDecoder().decode(OpenBetFeed.self, from: data)
                else {
                    self.alert(message: "There was an error while decoding the response.", title: "Malformed Response Error")
                    return
            }
            self.openData = feedData;
            feedCount = feedData.bets.count;
        } else{
            self.alert(message: "There was an error processing your request.", title: "Network Error")
        }
        
        
        self.OpenBetsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
        self.LiveBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        self.GamesObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        self.feedType = .open;
        self.Collection.reloadData();
    }
    
    @IBAction func GamesButton(_ sender: Any) {
        // submit a GET request to get the game feed object
        let fullURI = addGETParams(path: "/api/games/", search: "", needsUsername: false)
        let response: GETResponse? = sendGET(uri: fullURI);
        let data: Data! = response?.data
        
        // decode the information recieved
        if response?.error != nil {
            guard let feedData = try? JSONDecoder().decode(GamesFeed.self, from: data)
                else {
                    self.alert(message: "There was an error while decoding the response.", title: "Malformed Response Error")
                    return
            }
            self.gamesData = feedData;
            feedCount = feedData.games.count;
        } else{
            self.alert(message: "There was an error processing your request.", title: "Network Error")
        }
        
        self.GamesObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
        self.OpenBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        self.LiveBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        self.feedType = .games;
        self.Collection.reloadData();
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.feedCount
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
            
        case .games:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesFeedCell", for: indexPath) as? GamesFeedCell;
            
            //TODO - Figure out how to correctly use this indexPath thing for nested arrays
            
            let theseGames = gamesData!.games[indexPath.row];
            let thisGame = theseGames.games[indexPath.item];
            
            getImageFromUrl(urlString: thisGame.home_team.team_logo_url, imageView: (cell?.HomeTeamLogo)!);
            getImageFromUrl(urlString: thisGame.away_team.team_logo_url, imageView: (cell?.AwayTeamLogo)!);
            cell?.HomeTeamName.text = thisGame.home_team.name;
            cell?.AwayTeamName.text = thisGame.away_team.name;
            cell?.HomeTeamRecord.text = String(thisGame.home_team.wins) + "-" + String(thisGame.home_team.losses);
            cell?.AwayTeamRecord.text = String(thisGame.away_team.wins) + "-" + String(thisGame.away_team.losses);
            cell?.event_id = thisGame.event_id;
            
            return cell!;
        }
    }

}
