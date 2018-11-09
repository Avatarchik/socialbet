//
//  config.swift
//  SocialBet
//

import Foundation
import UIKit
import CommonCrypto

// global variables

let domain = "socialbet.jpkrieg.com"
var username = "default"
var pwhash = "default"

// global methods
extension UIViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
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
    let other_team: String
    let other_team_logo_url: String
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
    let finalScore: String
}

struct User: Decodable {
    let user_id: Int
    let first_name: String
    let last_name: String
    let profile_pic_url: String
    let team: String
    let team_logo_url: String
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
