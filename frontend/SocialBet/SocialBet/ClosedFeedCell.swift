//
//  ClosedFeedCell.swift
//  SocialBet
//

import UIKit

class ClosedFeedCell: UICollectionViewCell {
    
    @IBOutlet weak var WinningUserPic: UIImageView!
    @IBOutlet weak var LosingUserPic: UIImageView!
    @IBOutlet weak var WinningUserName: UILabel!
    @IBOutlet weak var LosingUserName: UILabel!
    @IBOutlet weak var WinningTeamLogo: UIImageView!
    @IBOutlet weak var LosingTeamLogo: UIImageView!
    @IBOutlet weak var WinningTeamName: UILabel!
    @IBOutlet weak var LosingTeamName: UILabel!
    @IBOutlet weak var GameDateTime: UILabel!
    @IBOutlet weak var WagerAmount: UILabel!
}
