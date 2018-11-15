//
//  Common.swift
//  SocialBet
//

import Foundation
import UIKit
import CommonCrypto

// global variables

class Common {
    let domain = "socialbet.jpkrieg.com"
    let port = "5000"
    let default_pic = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREya1ZUSfvxj7zwOwWeCOtLk3JlDTbeuHZy4lcyKilbcmgpgEA"
    var username = "default"
    var pwhash = "default"
    //var teamInfo = getTeamData()
    
}

var common = Common()



// global methods
extension UIViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

func sha256(data : NSData) -> String {
    
    let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH))
    
    let rawPtr = UnsafeMutableRawPointer(res!.mutableBytes);
    let opaquePtr = OpaquePointer(rawPtr);
    
    CC_SHA256(data.bytes, CC_LONG(data.length), UnsafeMutablePointer(opaquePtr));
    
    return "\(res!)".replacingOccurrences(of: "", with: "").replacingOccurrences(of: " ", with: "");
    
}

func getImageFromUrl(urlString: String, imageView: UIImageView) {
    let url = URL(string: urlString)
    
    DispatchQueue.global().async {
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        DispatchQueue.main.async {
            imageView.image = UIImage(data: data!)
        }
    }
}

func addGETParams(path: String, search: String, needsUsername: Bool) -> String {
    let params = "?loguser=" + common.username + "&auth=" + common.pwhash;
    var fullString = path + params;
    if (needsUsername){
        fullString = fullString + "&username=" + search;
    }    
    return fullString;
}

func getTeamData() -> Teams? {
    
    var ret_val: Teams?
    
    let URI = addGETParams(path: "/api/teams/", search: "", needsUsername: false)
    sendGET(uri: URI, callback: { (httpresponse) in
        
        let data: Data! = httpresponse.data
        
        if httpresponse.error == nil {
            guard let teamData = try? JSONDecoder().decode(Teams.self, from: data)
                else {
                    print("Error loading teams data")
                    return
            }
            // DO SHIT WITH DATA HERE
            ret_val = teamData
        } else {
            print("There was an error processing your request")
            return
        }
        
    })
    return ret_val
}

func teamURL(teamname: String) -> String {
    let teamInfo = getTeamData()
    for team in teamInfo!.teams {
        if team.team_full_name == teamname {
            return team.logo_url;
        }
    }
    print("ERROR FINDING TEAM URL")
    return "Error"
}

func findResults(winner: String, user1: UserInBet, user2: UserInBet) -> BetResults {
    var winningUser: UserInBet?;
    var losingUser: UserInBet?;
    if (user1.user_id == winner){
        losingUser = user2;
        winningUser = user1;
    }
    else{
        losingUser = user1;
        winningUser = user2;
    }
    return BetResults(winner: winningUser!, loser: losingUser!);
}


// data structure definitions
struct BetFeed: Decodable {
    let bets: [Bet]
}

struct GamesFeed: Decodable {
    let games: [Game]
}

struct Teams: Decodable {
    let teams: [Team]
}

struct Bet: Decodable {
    let accepted: Bool
    let ammount: Float
    let bet_id: Int
    let direct: Bool
    let game_id: Int
    let game_time: String
    let message: String
    let num_comments: Int
    let team1: String
    let team2: String
    let time_placed: String
    let user1: UserInBet
    let user2: UserInBet
    let winner: String
}

struct User: Decodable {
    let username: String
    let first_name: String
    let last_name: String
    let profile_pic_url: String
}

struct UserInBet: Decodable {
    let first_name: String
    let last_name: String
    let profile_pic_url: String
    let team: String
    let user_id: String
}

struct Game: Decodable {
    let game_id: Int
    let game_time: String
    let record1: String
    let record2: String
    let team1: Team
    let team2: Team
}

struct Team: Decodable {
    let team_full_name: String
    let logo_url: String
}

struct Existance: Decodable {
    let value: Bool
}

struct BetResults{
    let winner: UserInBet
    let loser: UserInBet
}

