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
    var user_id = -1
    var pwhash = "default"
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
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
func getImageFromUrl(urlString: String, imageView: UIImageView) {
    let url = "http://socialbet.jpkrieg.com:5000/" + urlString
    imageView.load(url: URL(string: url)!)
}

func addGETParams(path: String, search: String, search_number: Int, needsUsername: Bool, needsUser_id: Bool) -> String {
    let params = "?loguser=" + common.username + "&auth=" + common.pwhash;
    var fullString = path + params;
    if (needsUsername){
        fullString = fullString + "&username=" + search;
    }
    if(needsUser_id){
        fullString = fullString + "&user_id=" + String(search_number);
    }
    return fullString;
}

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func getTeamData() -> Teams? {
    
    var ret_val: Teams?
    
    let URI = addGETParams(path: "/api/teams/", search: "", search_number: -1, needsUsername: false, needsUser_id: false)
    sendGET(uri: URI, callback: { (httpresponse) in
        
        let data: Data! = httpresponse.data
        
        //if httpresponse.error == nil {
        //if httpresponse.HTTPsuccess! {
            guard let teamData = try? JSONDecoder().decode(Teams.self, from: data)
                else {
                    print("Error loading teams data")
                    return
            }
            // DO SHIT WITH DATA HERE
            ret_val = teamData
        //} else {
            print("There was an error processing your request")
            return
        //}
        
    })
    return ret_val
}

func teamURL(teamname: String) -> String {
    return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREya1ZUSfvxj7zwOwWeCOtLk3JlDTbeuHZy4lcyKilbcmgpgEA" //TODO Remove
    
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
    if (user1.username == winner){
        losingUser = user2;
        winningUser = user1;
    }
    else{
        losingUser = user1;
        winningUser = user2;
    }
    return BetResults(winner: winningUser!, loser: losingUser!);
}

extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

extension NSDictionary {
    var swiftDictionary: Dictionary<String, Any> {
        var swiftDictionary = Dictionary<String, Any>()
        
        for key : Any in self.allKeys {
            let stringKey = key as! String
            if let keyValue = self.value(forKey: stringKey){
                swiftDictionary[stringKey] = keyValue
            }
        }
        
        return swiftDictionary
    }
}

func getNotifications() {
    print("Get notifications function triggered")
    let URI = addGETParams(path: "/api/teams/", search: "", search_number: -1, needsUsername: true, needsUser_id: false)   
    
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
    let accepted: Int
    let ammount: Float
    let bet_id: Int
    let direct: Int
    let game_id: Int
    let game_time: String
    let message: String
    let num_comments: Int
    let team1: String
    let team1_logo_url: String
    let team2: String
    let team2_logo_url: String
    let time_placed: String
    let user1_id: Int;
    let user2_id: Int?;
    let user1: UserInBet
    let user2: UserInBet?
    let winner: String?
}

struct User: Decodable {
    let username: String
    let first_name: String
    let last_name: String
    let profile_pic_url: String
    let friends: Bool
}

struct UserExists: Decodable {
    let username: String?
    let first_name: String?
    let last_name: String?
    let profile_pic_url: String?
    let friends: Bool?
}

struct UserInBet: Decodable {
    let first_name: String
    let last_name: String
    let profile_pic_url: String
    let team: String
    let username: String
}

struct Game: Decodable {
    let game_id: Int
    let game_time: String
    let team1: String
    let team1_url: String
    let team2: String
    let team2_url: String
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

// POST response decode structs
struct POSTResponseStruct: Decodable {
    let errors: [String]
    let success_status: String
}
