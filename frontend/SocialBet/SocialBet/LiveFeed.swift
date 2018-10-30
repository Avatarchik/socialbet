//
//  LiveFeed.swift
//  SocialBet
//
//  Created by Alex Chapp on 10/28/18.
//  Copyright © 2018 Nick Cargill. All rights reserved.
//

import UIKit
import Foundation

struct Feed: Decodable {
    let bets: [Bet]
}

struct Bet: Decodable {
    let bet_id: String
    let time_placed: String
    let game_time: String
    let num_comments: Int
    let num_likes: Int
    let message: String
    let user1: User
    let user2: User
}

struct User: Decodable {
    let user_id: Int
    let first_name: String
    let last_name: String
    let profile_pic_url: String
    let team: String
    let team_logo_url: String
}

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

class LiveFeed: UIViewController {
    
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var LiveBetsCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        ProfilePic.layer.cornerRadius = ProfilePic.frame.size.width / 2;
        ProfilePic.clipsToBounds = true;
        
        loadProfileInfo();
        // Do any additional setup after loading the view.
        ProfilePic.image = UIImage(named: "./sample_data/Chapptain_America.png");
    }
    
    @IBAction func GamesButton(_ sender: Any) {
        //TODO - Navigate to Games Feed
    }
    
    @IBAction func OpenBetsButton(_ sender: Any) {
        //TODO - Navigate to Open Bets Feed
    }
    
    @IBAction func LiveBetsButton(_ sender: Any) {
        //Do Nothing
    }
    
    func loadProfileInfo() {
        //TODO - Get the info for this user and use
        //it to populate the profile pic and events
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data: Data = Data(); //TODO - Load the correct data with API call
        guard let feed = try? JSONDecoder().decode(Feed.self, from: data)
            else {
                print("Error decoding data");
                return 0;
        }
        return feed.bets.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveCell1", for: indexPath) as? LiveFeedCell;
        
        let data: Data = Data(); //TODO - Load the correct data with API call
        guard let feed = try? JSONDecoder().decode(Feed.self, from: data)
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
        cell?.BetTime.text = thisBet.time_placed;
        
        return cell!;
        
    }
}



