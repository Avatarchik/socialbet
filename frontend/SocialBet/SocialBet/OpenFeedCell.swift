//
//  OpenFeedCell.swift
//  SocialBet
//
//  Created by Alex Chapp on 11/4/18.
//  Copyright © 2018 Nick Cargill. All rights reserved.
//

import UIKit

class OpenFeedCell: UICollectionViewCell {
    
    @IBOutlet weak var ProfilePic: UIImageView!
    
    @IBOutlet weak var UserName: UILabel!
    
    @IBOutlet weak var UserTeamName: UILabel!
    
    @IBOutlet weak var BetAmount: UILabel!
    
    @IBOutlet weak var UserTeamLogo: UIImageView!
    
    @IBOutlet weak var OtherTeamLogo: UIImageView!
    
    @IBOutlet weak var UserTeamLowerText: UILabel!
    
    @IBOutlet weak var OtherTeamLowerText: UILabel!
    
    @IBOutlet weak var GameTime: UILabel!
    
    @IBAction func AcceptBet(_ sender: Any) {
    }
    
}
