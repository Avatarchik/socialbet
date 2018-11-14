//
//  Common.swift
//  SocialBet
//

import Foundation
import UIKit
import CommonCrypto

// global variables

<<<<<<< HEAD
let domain = "socialbet.jpkrieg.com"
let port = "5000"
var username = "default"
var pwhash = "default"
=======
class Common {
    let domain = "socialbet.jpkrieg.com"
    let port = "5000"
    let default_pic = "data:image/jpeg;base64,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"
    var username = "default"
    var pwhash = "default"
    
    init(){}
}

var common = Common()
>>>>>>> 110

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

func isValidHandle(handle: String?, friends: Bool) -> Bool{
    var fullURI = addGETParams(path: "/api/users/exist", search: handle!, needsUsername: true)
    if (friends){
        fullURI = fullURI + "&friends=true";
    }
    else{
        fullURI = fullURI + "&friends=false";
    }
    let response: GETResponse? = sendGET(uri: fullURI);
    let data: Data! = response?.data
    // decode the information recieved
    if response?.error != nil {
        guard let feedData = try? JSONDecoder().decode(Existance.self, from: data)
            else {
                return false;
        }
        return feedData.value;
    } else{
        return false;
    }
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

