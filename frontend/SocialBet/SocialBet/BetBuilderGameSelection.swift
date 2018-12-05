//
//  BetBuilderGameSelection.swift
//  SocialBet
//

import UIKit

class BetBuilderGameSelection: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var selectedOpponent: String?;
    var selectedGame: Int?;
    var teamOne: String?;
    var teamOneLogo: UIImageView?;
    var teamTwo: String?;
    var teamTwoLogo: UIImageView?;
    var feedCount: Int = 0;
    var gamesData: GamesFeed?;
    var teamOneLogoURL: String?
    var teamTwoLogoURL: String?
    @IBOutlet weak var BuilderGamesFeed: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.BuilderGamesFeed.register(UINib(nibName: "GamesFeedCell", bundle:nil), forCellWithReuseIdentifier: "GamesFeedCell");
        
        self.BuilderGamesFeed.delegate = self
        self.BuilderGamesFeed.dataSource = self
/*
        // Do any additional setup after loading the view.
        print("Opponent Handle: " + self.selectedOpponent!);
        
        // submit a GET request to get the game feed object
        let fullURI = addGETParams(path: "/api/games/", search: "", needsUsername: false)
        
        // TODO go through this
        sendGET(uri: fullURI, callback: { (httpresponse) in
            let data: Data! = httpresponse.data
            
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
        })*/
        
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
            
            self.BuilderGamesFeed.reloadData();
        })
        
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
            vc.teamOne = self.teamOne;
            vc.teamTwo = self.teamTwo;
            vc.TeamOneLogo = self.teamOneLogo;
            vc.TeamTwoLogo = self.teamTwoLogo;
            vc.teamOneLogoURL = self.teamOneLogoURL
            vc.teamTwoLogoURL = self.teamTwoLogoURL
            
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.feedCount;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesFeedCell", for: indexPath) as? GamesFeedCell;
        
        //TODO - Figure out how to correctly use this indexPath thing for nested arrays
        
        let thisGame = gamesData!.games[indexPath.row];
        
        cell?.HomeTeamName.text = thisGame.team1;
        cell?.AwayTeamName.text = thisGame.team2;
        cell?.event_id = thisGame.game_id;
        getImageFromUrl(urlString: thisGame.team1_url, imageView: (cell?.HomeTeamLogo)!);
        getImageFromUrl(urlString: thisGame.team2_url, imageView: (cell?.AwayTeamLogo)!);
        cell?.TimeOfGame.text = thisGame.game_time
        
        cell?.SeeOpenBets.isHidden = true;
        cell?.SeeOpenBets.isEnabled = false;
        
        return cell!;
    }
    
    // TODO -- SEE IF THIS IS NECESSARY
    //func numberOfSections(in collectionView: UICollectionView) -> Int {
     //   return 1;
    //}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("IN THE SELECT FUNCTION")
        
        let thisGame = gamesData!.games[indexPath.row];
        if let indexPath = self.BuilderGamesFeed.indexPathsForSelectedItems?.first{
            
            let cell = self.BuilderGamesFeed.cellForItem(at: indexPath) as? GamesFeedCell;
            self.selectedGame = cell?.event_id;
            self.teamOne = cell?.HomeTeamName.text;
            self.teamTwo = cell?.AwayTeamName.text;
            print("Adding images");
            self.teamOneLogoURL = thisGame.team1_url;
            
            self.teamTwoLogoURL = thisGame.team2_url;
            self.teamOneLogo = cell?.HomeTeamLogo;
            self.teamTwoLogo = cell?.AwayTeamLogo;
            performSegue(withIdentifier: "GameSelectToTeamSelect", sender: self);
        }
    }
    /*
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
    }*/
    
}
