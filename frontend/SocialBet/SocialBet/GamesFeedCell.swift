//
//  GamesFeedCell.swift
//  SocialBet
//
//  Created by Alex Chapp on 11/4/18.
//  Copyright © 2018 Nick Cargill. All rights reserved.
//

import UIKit

class GamesFeedCell: UICollectionViewCell {
    
    var event_id: Int?;
    @IBOutlet weak var HomeTeamLogo: UIImageView!
    
    @IBOutlet weak var AwayTeamLogo: UIImageView!
    
    @IBOutlet weak var HomeTeamName: UILabel!
    
    @IBOutlet weak var AwayTeamName: UILabel!
    
    @IBOutlet weak var HomeTeamRecord: UILabel!
    
    @IBOutlet weak var AwayTeamRecord: UILabel!
    
    @IBOutlet weak var TimeOfGame: UILabel!
    
    @IBAction func ViewOpenBets(_ sender: Any) {
    }
    
    @IBAction func ViewLiveBets(_ sender: Any) {
    }
    
    @IBAction func CreateOpenBet(_ sender: Any) {
    }
    
    @IBAction func CreateDirectBet(_ sender: Any) {
    }
    
}
