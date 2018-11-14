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
    let default_pic = "https://cdn2.iconfinder.com/data/icons/lil-silhouettes/2176/person5-512.png"
    var username = "default"
    var pwhash = "default"
    
    init(){}
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

// data structure definitions
struct LiveBetFeed: Decodable {
    let bets: [LiveBet]
}

struct OpenBetFeed: Decodable {
    let bets: [OpenBet]
}

struct GamesFeed: Decodable {
    let games: [Game]
}

struct ClosedBetFeed: Decodable {
    let bets: [ClosedBet]
}

struct LiveBet: Decodable {
    let bet_id: String
    let time_placed: String
    let game_time: String
    let num_comments: Int
    let num_likes: Int
    let message: String
    let user1: User
    let user2: User
    let user1_team: Team
    let user2_team: Team
    let wagerAmount: String
}

struct OpenBet: Decodable {
    let bet_id: String
    let time_made: String
    let game_time: String
    let num_comments: Int
    let num_likes: Int
    let message: String
    let amount: Int
    let user: User
    let user_team: Team
    let other_team: Team
}

struct Game: Decodable {
    let date: String
    let games: [InnerGame]
}

struct ClosedBet: Decodable {
    let bet_id: String
    let game_time: String
    let num_comments: Int
    let num_likes: Int
    let winningUser: User
    let losingUser: User
    let winningTeam: Team
    let losingTeam: Team
    let finalScore: String
    let wagerAmount: String
}

struct User: Decodable {
    let username: String
    let first_name: String
    let last_name: String
    let profile_pic_url: String
}

struct InnerGame: Decodable {
    let event_id: Int
    let home_team: Team
    let away_team: Team
}

struct Team: Decodable {
    let name: String
    let wins: Int
    let losses: Int
    let team_logo_url: String
}

struct Existance: Decodable {
    let value: Bool
}

