//
//  GameOpenFeed.swift
//  SocialBet
//
//  Created by Alex Chapp on 12/4/18.
//  Copyright © 2018 SocialBet. All rights reserved.
//

import UIKit

class GameOpenFeed: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    
    var selected_game_id: Int?;
    var feedCount = 0;
    var openData: BetFeed?;
    var selected_profile: String?;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.BetsFeed.delegate = self
        self.BetsFeed.dataSource = self

        // Do any additional setup after loading the view.
        self.BetsFeed.register(UINib(nibName: "OpenFeedCell", bundle:nil), forCellWithReuseIdentifier: "OpenFeedCell");
        
        var fullURI = addGETParams(path: "/api/feeds/open_bets_by_game/", search: "", needsUsername: false)
        fullURI = fullURI + "&game_id=" + String(self.selected_game_id!);
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
                print(self.feedCount);
            } else{
                self.alert(message: "There was an error processing your request.", title: "Network Error")
            }
            self.BetsFeed.reloadData();
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? Profile{
            vc.searchedUser = self.selected_profile;
        }
    }
    
    @objc func GoToProfile(sender: ProfilePicTapGesture){
        print("In the GoToProfile func")
        self.selected_profile = sender.username!;
        performSegue(withIdentifier: "OpenFeedToProfile", sender: self)
    }
    
    @IBAction func GoHome(_ sender: UIButton) {
        performSegue(withIdentifier: "OpenFeedToHome", sender: self)
    }
    
    @objc func OpenAcceptButtonPressed(sender: UIButton){
        // confirm that they intended to place this bet
        let alert = UIAlertController(title: "Confirm", message: "Do you want to accept this bet?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
            let parameters = ["loguser": common.username, "auth": common.pwhash, "bet_id": sender.tag as Any] as Dictionary<String, Any>;
            
            sendPOST(uri: "/api/betting/accept_bet/", parameters: parameters, callback: { (postresponse) in
                if postresponse["success_status"] as! String == "successful" {
                    self.BetsFeed.reloadData();
                    self.alert(message: "You have accepted the bet!", title: "Bet Accepted");
                } else {
                    self.alert(message: "Bet unable to be accepted", title: "Bet Acceptance Error")
                }
            })
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            return
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var BetsFeed: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("In population, feed count is: " + String(self.feedCount));
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
        
        let profileRecognizer = ProfilePicTapGesture(target: self, action: #selector(GoToProfile(sender:)))
        profileRecognizer.delegate = self
        cell?.ProfilePic.isUserInteractionEnabled = true
        cell?.ProfilePic.addGestureRecognizer(profileRecognizer)
        profileRecognizer.username = thisBet.user1.username;
        
        
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
