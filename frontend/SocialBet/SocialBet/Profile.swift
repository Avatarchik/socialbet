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
    
    @IBOutlet weak var AddFriendButton: UIButton!
    
    
    var searchedUser: String = ""
    
    var is_profile_self = false;
    
    func DetermineUser() {
        if (searchedUser == common.username) {
            self.is_profile_self = true;
        } else {
            self.is_profile_self = false;
        }
    }
    
    
    func FriendButtonToggle(profile_check: Bool) {
        if (profile_check) {
            AddFriendButton.isHidden = true
        } else {
            AddFriendButton.isHidden = false
        }
    }
    
    
    
    @IBAction func addFriend() {
        let URI = "/api/users/add_friend/"
        
        let params = ["loguser": common.username, "auth": common.pwhash, "user1": common.username, "user2": searchedUser]
        
        sendPOST(uri: URI, parameters: params, callback: { (postresponse) in
            // check for errors
            if postresponse.HTTPsuccess! {
                self.alert(message: "Your friend request was successfully sent", title: "Friend added!");
            }
            else{
                // TODO: check HTML error codes
                self.alert(message: "Unable to add friend", title: "Add Friend Error")
            }
            print("Added friend!");
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
    
    @IBAction func InitiateBet(_ sender: Any) {
        performSegue(withIdentifier: "ProfileToGameSelect", sender: self);
    }
    
    @IBAction func LiveBets(_ sender: Any) {
        self.LiveBetsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
        self.OpenBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        self.BetweenUsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        feedType = .live;
        self.ProfileBetFeed.reloadData();
    }
    
    @IBAction func OpenBets(_ sender: Any) {
        self.OpenBetsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
        self.LiveBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        self.BetweenUsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        feedType = .open;
        self.ProfileBetFeed.reloadData();
    }
    
    
    @IBAction func BetweenUs(_ sender: Any) {
        self.BetweenUsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
        self.OpenBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        self.LiveBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        feedType = .closed;
        self.ProfileBetFeed.reloadData();
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ProfileBetFeed.register(UINib(nibName: "LiveFeedCell", bundle:nil), forCellWithReuseIdentifier: "LiveFeedCell");
        self.ProfileBetFeed.register(UINib(nibName: "OpenFeedCell", bundle:nil), forCellWithReuseIdentifier: "OpenFeedCell");
        self.ProfileBetFeed.register(UINib(nibName: "ClosedFeedCell", bundle:nil), forCellWithReuseIdentifier: "ClosedFeedCell");

        // Do any additional setup after loading the view.
        
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
            guard let feed = try? JSONDecoder().decode(BetFeed.self, from: data)
                else {
                    print("Error decoding data");
                    return cell!;
            }
            
            let thisBet = feed.bets[indexPath.row];
            
            cell?.User1Name.text = thisBet.user1.first_name + " " + thisBet.user1.last_name;
            cell?.User2Name.text = thisBet.user2.first_name + " " + thisBet.user2.last_name;
            getImageFromUrl(urlString: thisBet.user1.profile_pic_url, imageView: (cell?.User1Image)!);
            getImageFromUrl(urlString: thisBet.user2.profile_pic_url, imageView: (cell?.User2Image)!);
            
            cell?.TeamName1.text = thisBet.user1.team;
            cell?.TeamName2.text = thisBet.user2.team;
            cell?.Message.text = thisBet.message;
            cell?.GameTime.text = thisBet.game_time;
            
            let team1Url = teamURL(teamname: thisBet.team1);
            let team2Url = teamURL(teamname: thisBet.team2);
            
            getImageFromUrl(urlString: team1Url, imageView: (cell?.Team1Image)!);
            getImageFromUrl(urlString: team2Url, imageView: (cell?.Team2Image)!);
            
            return cell!;
            
        case .open:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OpenFeedCell", for: indexPath) as? OpenFeedCell;
            
            let data: Data = Data(); //TODO - Load the correct data with API call
            guard let feed = try? JSONDecoder().decode(BetFeed.self, from: data)
                else {
                    print("Error decoding data");
                    return cell!;
            }
            
            let thisBet = feed.bets[indexPath.row];
            
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
            
            let data: Data = Data(); //TODO - Load the correct data with API call
            guard let feed = try? JSONDecoder().decode(BetFeed.self, from: data)
                else {
                    print("Error decoding data");
                    return cell!;
            }
            
            //TODO - Figure out how to correctly use this indexPath thing for nested arrays
            
            let thisBet = feed.bets[indexPath.row];
            
            let betResults = findResults(winner: thisBet.winner, user1: thisBet.user1, user2: thisBet.user2);
            
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
        let fullURI = addGETParams(path: "/api/users/find/", search: self.searchedUser, needsUsername: true)
        sendGET(uri: fullURI, callback: { (httpresponse) in
            let data: Data! = httpresponse.data
            
            if httpresponse.HTTPsuccess! {
                guard let userData = try? JSONDecoder().decode(User.self, from: data)
                    else {
                        self.alert(message: "There was an error while decoding the response.", title: "Malformed Response Error")
                        return
                }
                getImageFromUrl(urlString: userData.profile_pic_url, imageView: self.ProfilePic!);
                self.UserHandle.text = userData.username;
                self.UserName.text = userData.first_name + " " + userData.last_name;
            } else{
                self.alert(message: "There was an error processing your request.", title: "Network Error")
            }
        })
    }
}
