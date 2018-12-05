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
    
    @IBAction func NewBet(_ sender: Any) {
        performSegue(withIdentifier: "FeedToOpponentSelect", sender: self)
    }
    
    
    @IBAction func menuTapped() {
        getNotifications()
        toggleSideMenu()
    }
    
    enum FeedTypes{
        case live
        case open
        case games
    }
    
    var feedType = FeedTypes.live;
    var liveData: BetFeed?;
    var openData: BetFeed?;
    var gamesData: GamesFeed?;
    var feedCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        // default to live bets view
        if (self.feedType == FeedTypes.open) {
            OpenBetsButton(self)
        } else {
            LiveBetsButton(self)
        }
       
        
        self.Collection.register(UINib(nibName: "LiveFeedCell", bundle:nil), forCellWithReuseIdentifier: "LiveFeedCell");
        self.Collection.register(UINib(nibName: "OpenFeedCell", bundle:nil), forCellWithReuseIdentifier: "OpenFeedCell");
        self.Collection.register(UINib(nibName: "GamesFeedCell", bundle:nil), forCellWithReuseIdentifier: "GamesFeedCell");
        
        self.Collection.delegate = self
        self.Collection.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
    }
    
    @objc func OpenAcceptButtonPressed(sender: UIButton){
        let parameters = ["loguser": common.username, "auth": common.pwhash, "bet_id": sender.tag as Any] as Dictionary<String, Any>;
        
        sendPOST(uri: "/api/betting/accept_bet/", parameters: parameters, callback: { (postresponse) in
            if postresponse["success_status"] as! String == "successful" {
                self.OpenBetsButton(self)
                self.alert(message: "You have accepted the bet!", title: "Bet Accepted");
            } else {
                self.alert(message: "Bet unable to be accepted", title: "Bet Acceptance Error")
            }
        })
    }
    
    @IBAction func LiveBetsButton(_ sender: Any) {
        // submit a GET request to get the live feed object
        let fullURI = addGETParams(path: "/api/feeds/live_bets/", search: "", needsUsername: false)
        sendGET(uri: fullURI, callback: { (httpresponse) in
            let data: Data! = httpresponse.data
            
            // decode the information recieved
            //if httpresponse.error != nil {
            /*do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    print(jsonResult)
                }
            } catch let error {
                print(error.localizedDescription)
            }*/
            
            
            
            guard let feedData = try? JSONDecoder().decode(BetFeed.self, from: data)
            else {
                self.alert(message: "There was an error while decoding the response.", title: "Malformed Response Error")
                return
            }
            self.liveData = feedData;
            self.feedCount = self.liveData!.bets.count;
            //} else{
                //self.alert(message: "There was an error processing your request.", title: "Network Error")
            //}
            
            self.LiveBetsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
            self.OpenBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            self.GamesObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            self.feedType = .live;
            self.Collection.reloadData();
        })
    }
    
    @IBAction func OpenBetsButton(_ sender: Any) {
        // submit a GET request to get the open feed object
        let fullURI = addGETParams(path: "/api/feeds/open_bets/", search: "", needsUsername: false)
        sendGET(uri: fullURI, callback: { (httpresponse) in
            let data: Data! = httpresponse.data
            
            // decode the information recieved
            if httpresponse.HTTPsuccess! {
                guard let feedData = try? JSONDecoder().decode(BetFeed.self, from: data)
                    else {
                        self.alert(message: "There was an error while decoding the response.", title: "Malformed Response Error")
                        return
                }
                self.openData = feedData;
                self.feedCount = feedData.bets.count;
            } else{
                self.alert(message: "There was an error processing your request.", title: "Network Error")
            }
            
            
            self.OpenBetsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
            self.LiveBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            self.GamesObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            self.feedType = .open;
            self.Collection.reloadData();
        })
    }
    
    @IBAction func GamesButton(_ sender: Any) {
        // submit a GET request to get the game feed object
        let fullURI = addGETParams(path: "/api/sports_api_emulator/", search: "", needsUsername: false)
        sendGET(uri: fullURI, callback: { (httpresponse) in
            let data: Data! = (httpresponse.data)
            
            // decode the information recieved
            if httpresponse.HTTPsuccess! {
                guard let feedData = try? JSONDecoder().decode(GamesFeed.self, from: data)
                    else {
                        self.alert(message: "There was an error while decoding the response.", title: "Malformed Response Error")
                        return
                }
                self.gamesData = feedData;
                self.feedCount = feedData.games.count;
            } else{
                self.alert(message: "There was an error processing your request.", title: "Network Error")
            }
            
            self.GamesObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
            self.OpenBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            self.LiveBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            self.feedType = .games;
            self.Collection.reloadData();
        })
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
            cell?.User2Name.text = thisBet.user2!.first_name + " " + thisBet.user2!.last_name;
            getImageFromUrl(urlString: thisBet.user1.profile_pic_url, imageView: (cell?.User1Image)!);
            getImageFromUrl(urlString: thisBet.user2!.profile_pic_url, imageView: (cell?.User2Image)!);
            cell?.TeamName1.text = thisBet.team1;
            cell?.TeamName2.text = thisBet.team2;
            cell?.Message.text = thisBet.message;
            cell?.GameTime.text = thisBet.game_time;
            cell?.User1Image.setRounded()
            cell?.User2Image.setRounded()
            getImageFromUrl(urlString: thisBet.team1_logo_url, imageView: (cell?.Team1Image)!);
            getImageFromUrl(urlString: thisBet.team2_logo_url, imageView: (cell?.Team2Image)!);
            cell?.WagerAmount.text = "";
            
            cell?.AcceptButton.setImage(nil, for: .normal)
            cell?.DeclineButton.setImage(nil, for: .normal)
            cell?.AcceptButton.isEnabled = false;
            cell?.AcceptButton.isEnabled = false;            
            
            return cell!;
            
        case .open:
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
            
        case .games:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesFeedCell", for: indexPath) as? GamesFeedCell;
            
            //TODO - Figure out how to correctly use this indexPath thing for nested arrays
            
            let thisGame = gamesData!.games[indexPath.row];
    
            cell?.HomeTeamName.text = thisGame.team1;
            cell?.AwayTeamName.text = thisGame.team2;
            cell?.event_id = thisGame.game_id;
            getImageFromUrl(urlString: thisGame.team1_url, imageView: (cell?.HomeTeamLogo)!);
            getImageFromUrl(urlString: thisGame.team2_url, imageView: (cell?.AwayTeamLogo)!);
            cell?.TimeOfGame.text = thisGame.game_time
            
            return cell!;
        }
    }

}

extension Feed: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 160)
    }
    
}
