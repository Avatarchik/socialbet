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
    let errors: [String]
    let bets: [ClosedBet]
}

struct LiveBet: Decodable {
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

struct OpenBet: Decodable {
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
    let winner: String
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
    let team1: String
    let team1_url: String
    let team2: String
    let team2_url: String
}

struct Team: Decodable {
    let name: String
    let team_logo_url: String
}

struct Existance: Decodable {
    let value: Bool
}

