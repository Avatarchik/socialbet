//
//  BetBuilderGameSelection.swift
//  SocialBet
//

import UIKit

class BetBuilderGameSelection: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var selectedOpponent: String?;
    var selectedGame: Int?;
    var feedCount: Int = 0;
    var gamesData: GamesFeed?;
    @IBOutlet weak var BuilderGamesFeed: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.BuilderGamesFeed.register(UINib(nibName: "GamesFeedCell", bundle:nil), forCellWithReuseIdentifier: "GamesFeedCell");

        // Do any additional setup after loading the view.
        print("Opponent Handle: " + self.selectedOpponent!);
        
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
            self.feedCount = feedData.games.count;
        } else{
            self.alert(message: "There was an error processing your request.", title: "Network Error")
        }
    }
    
    @IBAction func GoBack(_ sender: Any) {
        performSegue(withIdentifier: "GameSelectToOpponentSelect", sender: self)
    }
    
    //Use this function to pass data through segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("Override Works!");
        //if going to next stage of bet builder
        if let vc = segue.destination as? BetBuilderTeamSelection{
            vc.selected_game_id = self.selectedGame;
            vc.selected_opponent = self.selectedOpponent;
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.feedCount;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesFeedCell", for: indexPath) as? GamesFeedCell;
            
            //TODO - Figure out how to correctly use this indexPath thing for nested arrays
            
            let theseGames = self.gamesData!.games[indexPath.row];
            let thisGame = theseGames.games[indexPath.item];
            
            getImageFromUrl(urlString: thisGame.home_team.team_logo_url, imageView: (cell?.HomeTeamLogo)!);
            getImageFromUrl(urlString: thisGame.away_team.team_logo_url, imageView: (cell?.AwayTeamLogo)!);
            cell?.HomeTeamName.text = thisGame.home_team.name;
            cell?.AwayTeamName.text = thisGame.away_team.name;
            cell?.HomeTeamRecord.text = String(thisGame.home_team.wins) + "-" + String(thisGame.home_team.losses);
            cell?.AwayTeamRecord.text = String(thisGame.away_team.wins) + "-" + String(thisGame.away_team.losses);
            
            return cell!;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        if let indexPath = self.BuilderGamesFeed.indexPathsForSelectedItems?.first{
            let cell = self.BuilderGamesFeed.cellForItem(at: indexPath) as? GamesFeedCell;
            self.selectedGame = cell?.event_id;
            performSegue(withIdentifier: "GameSelectToTeamSelect", sender: self);
        }
        
    }
    
}
