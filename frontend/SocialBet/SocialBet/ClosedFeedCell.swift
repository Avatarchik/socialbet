//
//  ClosedFeedCell.swift
//  SocialBet
//
//  Created by Alex Chapp on 11/6/18.
//  Copyright © 2018 Nick Cargill. All rights reserved.
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
    @IBOutlet weak var FinalScore: UILabel!
}
