//
//  GamesFeedCell.swift
//  SocialBet
//


import UIKit

class GamesFeedCell: UICollectionViewCell {
    
    var event_id: Int?;
    @IBOutlet weak var HomeTeamLogo: UIImageView!
    
    @IBOutlet weak var AwayTeamLogo: UIImageView!
    
    @IBOutlet weak var HomeTeamName: UILabel!
    
    @IBOutlet weak var AwayTeamName: UILabel!
    
    @IBOutlet weak var TimeOfGame: UILabel!
    
    @IBOutlet weak var SeeOpenBets: UIButton!
}
