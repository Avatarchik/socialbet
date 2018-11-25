//
//  LiveFeedCell.swift
//  SocialBet
//


import UIKit

class LiveFeedCell: UICollectionViewCell {
    
    @IBOutlet weak var User1Image: UIImageView!
    @IBOutlet weak var User2Image: UIImageView!
    @IBOutlet weak var Team1Image: UIImageView!
    @IBOutlet weak var Team2Image: UIImageView!
    @IBOutlet weak var User1Name: UILabel!
    @IBOutlet weak var User2Name: UILabel!
    @IBOutlet weak var Message: UILabel!
    @IBOutlet weak var TeamName1: UILabel!
    @IBOutlet weak var TeamName2: UILabel!
    @IBOutlet weak var GameTime: UILabel!    
    @IBOutlet weak var WagerAmount: UILabel!    
    @IBOutlet weak var AcceptButton: UIImageView!
    @IBOutlet weak var DeclineButton: UIImageView!
    var bet_id: Int?;
}
