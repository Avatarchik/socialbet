//
//  Profile.swift
//  SocialBet
//


import UIKit

class Profile: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserHandle: UILabel!
    @IBOutlet weak var ProfileBetFeed: UICollectionView!
    
    var BetweenUsObject: UIButton?
    var RequestsObject: UIButton?
    var BetHistoryObject: UIButton?
    @IBOutlet weak var OpenBetsObject: UIButton!
    @IBOutlet weak var LiveBetsObject: UIButton!
    
    @IBOutlet weak var InitiateBetButton: UIButton!
    @IBOutlet weak var AddFriendButton: UIButton!
    
    var searched_user_number: Int?;
    var search_by_number = false;
    var searchedUser: String?
    var is_friend = false;
    var is_profile_self = false;
    
    func DetermineUser() {
        if(!search_by_number){
            if (searchedUser! == common.username) {
                self.is_profile_self = true;
            } else {
                self.is_profile_self = false;
            }
        }
        else{
            if (searched_user_number! == common.user_id){
                self.is_profile_self = true
            } else {
                self.is_profile_self = false;
            }
        }
    }
    
    func ButtonVisibility() {
        if (self.is_profile_self){
            InitiateBetButton.isHidden = true
            AddFriendButton.isHidden = true
            self.AddSelfFeeds()
        } else if (!self.is_friend) {
            InitiateBetButton.isHidden = true
            AddFriendButton.isHidden = false
            self.AddOtherFeeds()
        } else {
            InitiateBetButton.isHidden = false
            AddFriendButton.isHidden = true
            self.AddOtherFeeds()
        }
    }
    
    var SideMenuOpen = false;
    @IBOutlet weak var SideMenuConstraint: NSLayoutConstraint!
    func toggleSideMenu() {
        if (SideMenuOpen) {
            SideMenuConstraint.constant = -200
            SideMenuOpen = false
        } else {
            SideMenuConstraint.constant = 0
            SideMenuOpen = true
        }
    }
    @IBAction func menuTapped() {
        var betData: BetFeed?;
        let fullURI = addGETParams(path: "/api/games/unnotified/", search: "", search_number: -1, needsUsername: false, needsUser_id: false)
        sendGET(uri: fullURI, callback: { (httpresponse) in
            let data: Data! = httpresponse.data
            
            guard let feedData = try? JSONDecoder().decode(BetFeed.self, from: data)
                else {
                    return
            }
            betData = feedData;
            let num_results = betData!.bets.count
            if(num_results != 0){
                let thisBet = betData!.bets[0];
                var other_user = "";
                var result_type = "";
                if (thisBet.winner == common.username){
                    result_type = "won"
                }
                else{
                    result_type = "lost"
                }
                if (common.username == thisBet.user1.username){
                    other_user = thisBet.user2!.username
                }
                else{
                    other_user = thisBet.user1.username
                }
                var message = "Bet against" + other_user + ":\n"
                message = message + "You " + result_type + "!\n"
                message = message + "See Results in Profile for more information."
                self.alert(message: message)
            }
        })
        toggleSideMenu()
    }
    
    
    @objc func GoToNewProfile(sender: ProfilePicTapGesture){
        self.searchedUser = sender.username!;
        self.viewDidLoad()
    }
    
    
    func AddSelfFeeds(){
        //get rid of Between US tab
        self.BetweenUsObject?.removeFromSuperview();
        self.LiveBetsObject.widthAnchor.constraint(equalTo: self.ProfileBetFeed.widthAnchor, multiplier: 0.25).isActive = true;
        self.LiveBetsObject.leadingAnchor.constraint(equalTo: self.ProfileBetFeed.leadingAnchor).isActive = true;
        
        //add Requests and Bet History tabs
        self.RequestsObject = UIButton();
        self.view.addSubview(self.RequestsObject!)
        self.RequestsObject!.translatesAutoresizingMaskIntoConstraints = false
        self.RequestsObject!.setTitle("Requests", for: .normal)
        self.RequestsObject!.addTarget(self, action: #selector(Requests(sender:)), for: .touchUpInside)
        self.RequestsObject!.widthAnchor.constraint(equalTo: self.LiveBetsObject.widthAnchor, multiplier: 1.0).isActive = true
        self.RequestsObject!.heightAnchor.constraint(equalTo: self.LiveBetsObject.heightAnchor, multiplier: 1.0).isActive = true
        self.RequestsObject!.topAnchor.constraint(equalTo: self.LiveBetsObject.topAnchor).isActive = true
        self.RequestsObject!.leadingAnchor.constraint(equalTo: self.OpenBetsObject.trailingAnchor).isActive = true
        self.RequestsObject!.backgroundColor = UIColor.white;
        self.RequestsObject!.setTitleColor(UIColorFromRGB(rgbValue: 0x007AFF), for: .normal)
        self.RequestsObject!.isHidden = false;
        self.RequestsObject!.isEnabled = true;
        
        self.BetHistoryObject = UIButton();
        //self.BetHistoryObject = UIButton();
        self.view.addSubview(self.BetHistoryObject!)
        self.BetHistoryObject!.translatesAutoresizingMaskIntoConstraints = false
        self.BetHistoryObject!.setTitle("History", for: .normal)
        self.BetHistoryObject!.addTarget(self, action: #selector(BetHistory(sender:)), for: .touchUpInside)
        self.BetHistoryObject!.widthAnchor.constraint(equalTo: self.LiveBetsObject.widthAnchor, multiplier: 1.0).isActive = true
        self.BetHistoryObject!.heightAnchor.constraint(equalTo: self.LiveBetsObject.heightAnchor, multiplier: 1.0).isActive = true
        self.BetHistoryObject!.topAnchor.constraint(equalTo: self.LiveBetsObject.topAnchor).isActive = true
        self.BetHistoryObject!.leadingAnchor.constraint(equalTo: self.RequestsObject!.trailingAnchor).isActive = true
        self.BetHistoryObject!.trailingAnchor.constraint(equalTo: self.ProfileBetFeed.trailingAnchor).isActive = true
        self.BetHistoryObject!.backgroundColor = UIColor.white;
        self.BetHistoryObject!.setTitleColor(UIColorFromRGB(rgbValue: 0x007AFF), for: .normal)
        self.BetHistoryObject!.isHidden = false;
        self.BetHistoryObject!.isEnabled = true;
        
    }
    
    func AddOtherFeeds(){
        //get rid of Requests and History
        self.BetHistoryObject?.removeFromSuperview()
        self.RequestsObject?.removeFromSuperview()
        self.LiveBetsObject.widthAnchor.constraint(equalTo: self.ProfileBetFeed.widthAnchor, multiplier: 1/3).isActive = true;
        self.OpenBetsObject.leadingAnchor.constraint(equalTo: self.LiveBetsObject.trailingAnchor).isActive = true;
        //add Between Us tab
        self.BetweenUsObject = UIButton();
        self.view.addSubview(self.BetweenUsObject!)
        self.BetweenUsObject!.translatesAutoresizingMaskIntoConstraints = false
        self.BetweenUsObject!.setTitle("Between Us", for: .normal)
        self.BetweenUsObject!.addTarget(self, action: #selector(BetweenUs(sender:)), for: .touchUpInside)
        //self.BetweenUsObject!.widthAnchor.constraint(equalTo: self.LiveBetsObject.widthAnchor, multiplier: 1.0).isActive = true
        self.BetweenUsObject!.heightAnchor.constraint(equalTo: self.LiveBetsObject.heightAnchor, multiplier: 1.0).isActive = true
        self.BetweenUsObject!.topAnchor.constraint(equalTo: self.LiveBetsObject.topAnchor).isActive = true
        self.BetweenUsObject!.leadingAnchor.constraint(equalTo: self.OpenBetsObject!.trailingAnchor).isActive = true
        self.BetweenUsObject!.trailingAnchor.constraint(equalTo: self.ProfileBetFeed.trailingAnchor).isActive = true
        self.BetweenUsObject!.backgroundColor = UIColor.white;
        self.BetweenUsObject!.setTitleColor(UIColorFromRGB(rgbValue: 0x007AFF), for: .normal)
        self.BetweenUsObject!.isHidden = false;
        self.BetweenUsObject!.isEnabled = true;
        
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
    
    @objc func AcceptButtonPressed(sender: UIButton) {
        let parameters = ["loguser": common.username, "auth": common.pwhash, "bet_id": sender.tag as Any] as Dictionary<String, Any>;
        
        sendPOST(uri: "/api/betting/accept_bet/", parameters: parameters, callback: { (postresponse) in
            if postresponse["success_status"] as! String == "successful" {
                self.Requests(sender: self)
                self.alert(message: "You have accepted the bet!", title: "Bet Accepted");
            } else {
                self.alert(message: "Bet unable to be accepted", title: "Bet Acceptance Error")
            }
        })
    }
    
    @objc func DeclineButtonPressed(sender: UIButton) {
        let parameters = ["loguser": common.username, "auth": common.pwhash, "bet_id": sender.tag as Any] as Dictionary<String, Any>;
        
        sendPOST(uri: "/api/betting/cancel_bet/", parameters: parameters,
                 callback: { (postresponse) in
                    if postresponse["success_status"] as! String == "successful" {
                        self.Requests(sender: self)
                        self.alert(message: "You have declined the bet!", title: "Bet Declined");
                    } else {
                        self.alert(message: "Bet unable to be declined", title: "Bet Decline Error")
                    }
        })
    }
    
    @IBAction func returnHome() {
        performSegue(withIdentifier: "ProfileToHome", sender: self)
    }
    
    enum ProfileFeedTypes{
        case live
        case open
        case betweenUs
        case request
        case betHistory
    }
    
    var feedType = ProfileFeedTypes.live;
    var liveData: BetFeed?;
    var openData: BetFeed?;
    var requestData: BetFeed?;
    var betHistoryData: BetFeed?;
    var betweenUsData: BetFeed?;
    var feedCount = 0
    
    //var feedType = ProfileFeedTypes.live;
    
    @IBAction func InitiateBet(sender: Any) {
        performSegue(withIdentifier: "ProfileToGameSelect", sender: self);
    }
    
    @objc func LiveBets(sender: Any) {
        var fullURI: String;
        if(self.is_profile_self){
            fullURI = addGETParams(path: "/api/feeds/users_live_bets/", search: common.username, search_number: -1, needsUsername: true, needsUser_id: false)
        }
        else{
            fullURI = addGETParams(path: "/api/feeds/users_live_bets/", search: self.searchedUser!, search_number: -1, needsUsername: true, needsUser_id: false)
        }
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
            if(self.is_profile_self){
                self.RequestsObject!.titleLabel?.font = UIFont.systemFont(ofSize: 15);
                self.BetHistoryObject!.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            }
            else{
                self.BetweenUsObject!.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            }
            self.feedType = .live;
            self.ProfileBetFeed.reloadData();
        })
    }
    
    @objc func OpenBets(sender: Any) {
        var fullURI: String;
        if(self.is_profile_self){
            fullURI = addGETParams(path: "/api/feeds/users_live_bets/", search: common.username, search_number: -1, needsUsername: true, needsUser_id: false)
        }
        else{
            fullURI = addGETParams(path: "/api/feeds/users_open_bets/", search: self.searchedUser!, search_number: -1, needsUsername: true, needsUser_id: false)
        }
        
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
            if(self.is_profile_self){
                self.RequestsObject!.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                self.BetHistoryObject!.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            }
            else{
                self.BetweenUsObject!.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            }
            
            self.feedType = .open;
            self.ProfileBetFeed.reloadData();
        })
        
        
    }
    
    @objc func BetHistory(sender: Any) {
        let fullURI = addGETParams(path: "/api/feeds/bet_history/", search: "", search_number: -1, needsUsername: false, needsUser_id: false)
        sendGET(uri: fullURI, callback: { (httpresponse) in
            let data: Data! = httpresponse.data
            
            guard let feedData = try? JSONDecoder().decode(BetFeed.self, from: data)
                else {
                    self.alert(message: "There was an error while decoding the response.", title: "Malformed Response Error")
                    return
            }
            self.betHistoryData = feedData;
            self.feedCount = self.betHistoryData!.bets.count;
            self.BetHistoryObject!.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
            self.OpenBetsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
            self.LiveBetsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
            self.RequestsObject!.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
            self.feedType = .betHistory
            self.ProfileBetFeed.reloadData()
        })
        
    }
    
    
    @objc func BetweenUs(sender: Any) {
        
        var fullURI = addGETParams(path: "/api/feeds/between_us_bets/", search: "", search_number: -1, needsUsername: false, needsUser_id: false)
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
            self.BetweenUsObject!.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
            self.OpenBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            self.LiveBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            self.feedType = .betweenUs;
            self.ProfileBetFeed.reloadData();
        })
        
    }
    
    @objc func Requests(sender: Any) {
        let fullURI = addGETParams(path: "/api/feeds/direct_bets_pending/", search: "", search_number: -1, needsUsername: false, needsUser_id: false)
        sendGET(uri: fullURI, callback: { (httpresponse) in
            let data: Data! = httpresponse.data
            
            guard let feedData = try? JSONDecoder().decode(BetFeed.self, from: data)
                else {
                    self.alert(message: "There was an error while decoding the response.", title: "Malformed Response Error")
                    return
            }
            self.requestData = feedData;
            self.feedCount = self.requestData!.bets.count;
            self.RequestsObject!.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
            self.OpenBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            self.BetHistoryObject!.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            self.LiveBetsObject.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            self.feedType = .request
            self.ProfileBetFeed.reloadData()
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
        self.LiveBetsObject.addTarget(self, action: #selector(LiveBets(sender:)), for: .touchUpInside)
        self.OpenBetsObject.addTarget(self, action: #selector(OpenBets(sender:)), for: .touchUpInside)
        
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
            
            cell?.User1Image!.setRounded();
            cell?.User2Image!.setRounded();
            cell?.TeamName1.text = thisBet.user1.team;
            cell?.TeamName2.text = thisBet.user2!.team;
            cell?.Message.text = thisBet.message;
            cell?.GameTime.text = thisBet.game_time;
            cell?.WagerAmount.text = "Amount: $" + String(thisBet.ammount);
            
            getImageFromUrl(urlString: thisBet.team1_logo_url, imageView: (cell?.Team1Image)!);
            getImageFromUrl(urlString: thisBet.team2_logo_url, imageView: (cell?.Team2Image)!);
            
            let profileRecognizer1 = ProfilePicTapGesture(target: self, action: #selector(GoToNewProfile(sender:)))
            profileRecognizer1.delegate = self
            cell?.User1Image.isUserInteractionEnabled = true
            cell?.User1Image.addGestureRecognizer(profileRecognizer1)
            profileRecognizer1.username = thisBet.user1.username;
            
            let profileRecognizer2 = ProfilePicTapGesture(target: self, action: #selector(GoToNewProfile(sender:)))
            profileRecognizer2.delegate = self
            cell?.User2Image.isUserInteractionEnabled = true
            cell?.User2Image.addGestureRecognizer(profileRecognizer2)
            profileRecognizer2.username = thisBet.user2!.username;
            
            
            cell?.AcceptButton.isHidden = true;
            cell?.AcceptButton.isEnabled = false;
            cell?.DeclineButton.isHidden = true;
            cell?.DeclineButton.isEnabled = false;
            
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
            
            getImageFromUrl(urlString: thisBet.team1_logo_url, imageView: (cell?.UserTeamLogo)!);
            getImageFromUrl(urlString: thisBet.team2_logo_url, imageView: (cell?.OtherTeamLogo)!);
            getImageFromUrl(urlString: thisBet.user1.profile_pic_url, imageView: (cell?.ProfilePic)!)
            
            cell?.ProfilePic.setRounded();
            
            return cell!;
            
        case .betweenUs:
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
            cell?.WagerAmount.text = "Amount: $" + String(thisBet.ammount);
            
            cell?.WinningUserPic!.setRounded();
            cell?.LosingUserPic!.setRounded();
            
            return cell!;
            
        case .request:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveFeedCell", for: indexPath) as? LiveFeedCell;
            
            let thisBet = self.requestData!.bets[indexPath.row];
            
            cell?.User1Name.text = thisBet.user1.first_name + " " + thisBet.user1.last_name;
            cell?.User2Name.text = thisBet.user2!.first_name + " " + thisBet.user2!.last_name;
            getImageFromUrl(urlString: thisBet.user1.profile_pic_url, imageView: (cell?.User1Image)!);
            getImageFromUrl(urlString: thisBet.user2!.profile_pic_url, imageView: (cell?.User2Image)!);
            cell?.TeamName1.text = thisBet.user1.team;
            cell?.TeamName2.text = thisBet.user2!.team;
            cell?.Message.text = thisBet.message;
            cell?.GameTime.text = thisBet.game_time;
            cell?.WagerAmount.text = "Amount: $" + String(thisBet.ammount);
            cell?.bet_id = thisBet.bet_id;
            
            getImageFromUrl(urlString: thisBet.team1_logo_url, imageView: (cell?.Team1Image)!);
            getImageFromUrl(urlString: thisBet.team2_logo_url, imageView: (cell?.Team2Image)!);
            
            cell?.User1Image!.setRounded();
            cell?.User2Image!.setRounded();
            
            cell?.AcceptButton.setImage(UIImage(named: "accept.png"), for: .normal)
            cell?.DeclineButton.setImage(UIImage(named: "decline.png"), for: .normal)
            
            cell?.AcceptButton.isEnabled = true;
            cell?.DeclineButton.isEnabled = true;
            cell?.AcceptButton.isHidden = false;
            cell?.DeclineButton.isHidden = false;
            
            cell?.AcceptButton.tag = thisBet.bet_id
            cell?.DeclineButton.tag = thisBet.bet_id
            
            // add actions for the buttons
            cell?.AcceptButton.addTarget(self, action: #selector(AcceptButtonPressed(sender:)), for: .touchUpInside)
            cell?.DeclineButton.addTarget(self, action: #selector(DeclineButtonPressed(sender:)), for: .touchUpInside)
            
            return cell!;
            
        case .betHistory:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClosedFeedCell", for: indexPath) as? ClosedFeedCell;
            
            let thisBet = self.betHistoryData!.bets[indexPath.row];
            
            let betResults = findResults(winner: thisBet.winner!, user1: thisBet.user1, user2: thisBet.user2!);
            
            getImageFromUrl(urlString: betResults.winner.profile_pic_url, imageView: (cell?.WinningUserPic)!)
            getImageFromUrl(urlString: betResults.loser.profile_pic_url, imageView: (cell?.LosingUserPic)!)
            cell?.WinningUserName.text = betResults.winner.username;
            cell?.LosingUserName.text = betResults.loser.username;
            
            cell?.WinningTeamName.text = betResults.winner.team;
            cell?.LosingTeamName.text = betResults.loser.team;
            cell?.GameDateTime.text = thisBet.game_time;
            cell?.WagerAmount.text = "Amount: $" + String(thisBet.ammount);
            
            var winningTeamUrl = "";
            var losingTeamUrl = "";
            
            if(thisBet.winner == thisBet.team1){
                winningTeamUrl = thisBet.team1_logo_url
                losingTeamUrl = thisBet.team2_logo_url
            }
            else{
                winningTeamUrl = thisBet.team2_logo_url
                losingTeamUrl = thisBet.team1_logo_url
            }
            
            
            getImageFromUrl(urlString: winningTeamUrl, imageView: (cell?.WinningTeamLogo)!)
            getImageFromUrl(urlString: losingTeamUrl, imageView: (cell?.LosingTeamLogo)!)
            
            return cell!;
        }        
        
    }
    
    func loadProfileInfo(){
        var fullURI = "";
        if(!self.search_by_number){
            fullURI = addGETParams(path: "/api/users/find/", search: self.searchedUser!, search_number: -1, needsUsername: true, needsUser_id: false)
        }
        else{
            fullURI = addGETParams(path: "/api/users/find_id/", search: "", search_number: self.searched_user_number!, needsUsername: false, needsUser_id: true)
        }
        sendGET(uri: fullURI, callback: { (httpresponse) in
            let data: Data! = httpresponse.data
            
            //if httpresponse.HTTPsuccess! {
            guard let userData = try? JSONDecoder().decode(User.self, from: data)
                else {
                    self.alert(message: "There was an error while decoding the response.", title: "Malformed Response Error")
                    return
            }
            getImageFromUrl(urlString: userData.profile_pic_url, imageView: self.ProfilePic!);
            self.ProfilePic!.setRounded();
            
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
            self.LiveBets(sender: self)
            //} else{
                //self.alert(message: "There was an error processing your request.", title: "Network Error")
            //}
        })
    }
}

extension Profile: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 160)
    }
    
}
