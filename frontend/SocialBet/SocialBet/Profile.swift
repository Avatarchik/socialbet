//
//  Profile.swift
//  SocialBet
//


import UIKit

class Profile: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserHandle: UILabel!
    @IBOutlet weak var ProfileBetFeed: UICollectionView!
    
    @IBOutlet weak var BetweenUsObject: UIButton!
    @IBOutlet weak var OpenBetsObject: UIButton!
    @IBOutlet weak var LiveBetsObject: UIButton!
    
    @IBOutlet weak var InitiateBetButton: UIButton!
    @IBOutlet weak var AddFriendButton: UIButton!
    
    
    var searchedUser: String?
    var is_friend = false;
    var is_profile_self = false;
    
    func DetermineUser() {
        if (searchedUser! == common.username) {
            self.is_profile_self = true;
        } else {
            self.is_profile_self = false;
        }
    }
    
    func ButtonVisibility() {
        if (self.searchedUser! == common.username){
            InitiateBetButton.isHidden = true
            AddFriendButton.isHidden = true
        } else if (!self.is_friend) {
            InitiateBetButton.isHidden = true
            AddFriendButton.isHidden = false
        } else {
            InitiateBetButton.isHidden = false
            AddFriendButton.isHidden = true
        }
    }
    
    @objc func AddFriendButtonPressed(sender: Any){
        let URI = "/api/users/add_friend/"
        
        let params = ["loguser": common.username, "auth": common.pwhash, "user1": common.username, "user2": searchedUser!]
        
        sendPOST(uri: URI, parameters: params, callback: { (postresponse) in
            // alert the user of success/failure, and either navigate away or refresh the page
            if postresponse["success_status"] as! String == "successful" {
                self.alert(message: "Your friend request was successfully sent", title: "Friend added!");
                self.viewDidLoad() // TODO: confirm that this is what we want
                
            } else {
                self.alert(message: "Unable to add friend.", title: "Add Friend Error")
            }
        })
    }
    
    @IBAction func returnHome() {
        performSegue(withIdentifier: "ProfileToHome", sender: self)
    }
    
    enum ProfileFeedTypes{
        case live
        case open
        case closed
    }
    
    var feedType = ProfileFeedTypes.live;
    var liveData: BetFeed?;
    var openData: BetFeed?;
    var betweenUsData: BetFeed?;
    var feedCount = 0
    
    //var feedType = ProfileFeedTypes.live;
    
    @IBAction func InitiateBet(_ sender: Any) {
        performSegue(withIdentifier: "ProfileToGameSelect", sender: self);
    }
    
    @IBAction func LiveBets(_ sender: Any) {
        let fullURI = addGETParams(path: "/api/feeds/users_live_bets/", search: self.searchedUser!, needsUsername: true)
        sendGET(uri: fullURI, callback: { (httpresponse) in
            let data: Data! = httpresponse.data
            
            guard let feedData = try? JSONDecoder().decode(BetFeed.self, from: data)
                else {
                    self.alert(message: "There was an error while decoding the response.", title: "Malformed Response Error")
                    return
            }
            self.liveData = feedData;
            self.feedCount = self.liveData!.bets.count;
            self.LiveBetsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
            self.OpenBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            self.BetweenUsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            self.feedType = .live;
            self.ProfileBetFeed.reloadData();
        })
    }
    
    @IBAction func OpenBets(_ sender: Any) {
        let fullURI = addGETParams(path: "/api/feeds/users_open_bets/", search: self.searchedUser!, needsUsername: true)
        sendGET(uri: fullURI, callback: { (httpresponse) in
            let data: Data! = httpresponse.data
            
            guard let feedData = try? JSONDecoder().decode(BetFeed.self, from: data)
                else {
                    self.alert(message: "There was an error while decoding the response.", title: "Malformed Response Error")
                    return
            }
            self.openData = feedData;
            self.feedCount = self.openData!.bets.count;
            self.OpenBetsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
            self.LiveBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            self.BetweenUsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            self.feedType = .open;
            self.ProfileBetFeed.reloadData();
        })
        
        
    }
    
    
    @IBAction func BetweenUs(_ sender: Any) {
        
        var fullURI = addGETParams(path: "/api/feeds/between_us_bets/", search: "", needsUsername: false)
        fullURI = fullURI + "&user2=" + self.searchedUser!;
        sendGET(uri: fullURI, callback: { (httpresponse) in
            let data: Data! = httpresponse.data
            
            guard let feedData = try? JSONDecoder().decode(BetFeed.self, from: data)
                else {
                    self.alert(message: "There was an error while decoding the response.", title: "Malformed Response Error")
                    return
            }
            self.betweenUsData = feedData;
            self.feedCount = self.betweenUsData!.bets.count;
            self.BetweenUsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
            self.OpenBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            self.LiveBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            self.feedType = .closed;
            self.ProfileBetFeed.reloadData();
        })
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ProfileBetFeed.register(UINib(nibName: "LiveFeedCell", bundle:nil), forCellWithReuseIdentifier: "LiveFeedCell");
        self.ProfileBetFeed.register(UINib(nibName: "OpenFeedCell", bundle:nil), forCellWithReuseIdentifier: "OpenFeedCell");
        self.ProfileBetFeed.register(UINib(nibName: "ClosedFeedCell", bundle:nil), forCellWithReuseIdentifier: "ClosedFeedCell");
        
        self.ProfileBetFeed.delegate = self
        self.ProfileBetFeed.dataSource = self

        // Do any additional setup after loading the view.
        
        AddFriendButton.addTarget(self, action: #selector(AddFriendButtonPressed(sender:)), for: .touchUpInside)
        
        self.loadProfileInfo();
        
    }
    
    //Use this function to pass data through segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("Override Works!");
        //if going to bet builder
        if let vc = segue.destination as? BetBuilderGameSelection{
            vc.selectedOpponent = self.UserHandle.text;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.feedCount;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch feedType {
            
        case .live:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveFeedCell", for: indexPath) as? LiveFeedCell;
            
            if(self.liveData == nil){
                return cell!;
            }
            
            let thisBet = self.liveData!.bets[indexPath.row];
            
            cell?.User1Name.text = thisBet.user1.first_name + " " + thisBet.user1.last_name;
            cell?.User2Name.text = thisBet.user2!.first_name + " " + thisBet.user2!.last_name;
            getImageFromUrl(urlString: thisBet.user1.profile_pic_url, imageView: (cell?.User1Image)!);
            getImageFromUrl(urlString: thisBet.user2!.profile_pic_url, imageView: (cell?.User2Image)!);
            
            cell?.TeamName1.text = thisBet.user1.team;
            cell?.TeamName2.text = thisBet.user2!.team;
            cell?.Message.text = thisBet.message;
            cell?.GameTime.text = thisBet.game_time;
            
            let team1Url = teamURL(teamname: thisBet.team1);
            let team2Url = teamURL(teamname: thisBet.team2);
            
            getImageFromUrl(urlString: team1Url, imageView: (cell?.Team1Image)!);
            getImageFromUrl(urlString: team2Url, imageView: (cell?.Team2Image)!);
            
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
            
            let team1Url = teamURL(teamname: thisBet.user1.team)
            let team2Url = teamURL(teamname: thisBet.team2);
            
            // TODO - initialize all teams at start
            getImageFromUrl(urlString: team1Url, imageView: (cell?.UserTeamLogo)!);
            getImageFromUrl(urlString: team2Url, imageView: (cell?.OtherTeamLogo)!);
            
            return cell!;
            
        case .closed:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClosedFeedCell", for: indexPath) as? ClosedFeedCell;
            
            let thisBet = self.betweenUsData!.bets[indexPath.row]
            
            let betResults = findResults(winner: thisBet.winner!, user1: thisBet.user1, user2: thisBet.user2!);
            
            let winningUrl = teamURL(teamname: betResults.winner.team);
            let losingUrl = teamURL(teamname: betResults.loser.team);
            
            getImageFromUrl(urlString: winningUrl, imageView: (cell?.WinningTeamLogo)!);
            cell?.WinningTeamName.text = betResults.winner.team;
            getImageFromUrl(urlString: losingUrl, imageView: (cell?.LosingTeamLogo)!);
            cell?.LosingTeamName.text = betResults.loser.team;
            cell?.GameDateTime.text = thisBet.game_time;
        
            getImageFromUrl(urlString: betResults.winner.profile_pic_url, imageView: (cell?.WinningUserPic)!);
            cell?.WinningUserName.text = betResults.winner.first_name + " " + betResults.winner.last_name;
            getImageFromUrl(urlString: betResults.loser.profile_pic_url, imageView: (cell?.LosingUserPic)!);
            cell?.LosingUserName.text = betResults.loser.first_name + " " + betResults.loser.last_name;
            
            return cell!;
        }        
        
    }
    
    func loadProfileInfo(){
        let fullURI = addGETParams(path: "/api/users/find/", search: self.searchedUser!, needsUsername: true)
        sendGET(uri: fullURI, callback: { (httpresponse) in
            let data: Data! = httpresponse.data
            
            //if httpresponse.HTTPsuccess! {
            guard let userData = try? JSONDecoder().decode(User.self, from: data)
                else {
                    self.alert(message: "There was an error while decoding the response.", title: "Malformed Response Error")
                    return
            }
            getImageFromUrl(urlString: userData.profile_pic_url, imageView: self.ProfilePic!);
            self.UserHandle.text = userData.username;
            self.UserName.text = userData.first_name + " " + userData.last_name;
            
            //TODO needs a slight tweak to allow for deleting friends, just not important for task at hand right now
            if (self.searchedUser! == common.username){
                self.is_friend = true;
            }
            else{
                if(userData.friends){
                    self.is_friend = true;
                }
                else{
                    self.is_friend = false;
                }
            }
            
            self.DetermineUser();
            self.ButtonVisibility()
            self.LiveBets(self)
            //} else{
                //self.alert(message: "There was an error processing your request.", title: "Network Error")
            //}
        })
    }
}
