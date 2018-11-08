//
//  BetBuilderGameSelection.swift
//  SocialBet
//
//  Created by Alex Chapp on 11/7/18.
//  Copyright © 2018 Nick Cargill. All rights reserved.
//

import UIKit

class BetBuilderGameSelection: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var BuilderGamesFeed: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.BuilderGamesFeed.register(UINib(nibName: "GamesFeedCell", bundle:nil), forCellWithReuseIdentifier: "GamesFeedCell");

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
        
         /*
         let data: Data = Data(); //TODO - Load the correct data with API call for games feed
         guard let feed = try? JSONDecoder().decode(GamesFeed.self, from: data)
         else {
         print("Error decoding data");
         return 0;
         }
         return feed.games.count;
         */
        return 4;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesFeedCell", for: indexPath) as? GamesFeedCell;
            
            let data: Data = Data(); //TODO - Load the correct data with API call
            guard let feed = try? JSONDecoder().decode(GamesFeed.self, from: data)
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
            
            return cell!;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        //TODO - store the selected event_ID and bring up next screen with that game loaded
    }
    
    
    
    

}
