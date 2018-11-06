//
//  Profile.swift
//  SocialBet
//
//  Created by John Krieg on 10/31/18.
//  Copyright © 2018 Nick Cargill. All rights reserved.
//

import UIKit

class Profile: UIViewController {
    
    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserHandle: UILabel!
    @IBOutlet weak var ProfileBetFeed: UICollectionView!
    
    @IBAction func InitiateBet(_ sender: Any) {
        
    }
    
    @IBAction func LiveBets(_ sender: Any) {
        feedType = .live;
        self.ProfileBetFeed.reloadData();
    }
    
    @IBAction func OpenBets(_ sender: Any) {
        feedType = .open;
        self.ProfileBetFeed.reloadData();
    }
    
    
    @IBAction func BetweenUs(_ sender: Any) {
        feedType = .live; //Note, I should probably create a fourth bet type - closed
        self.ProfileBetFeed.reloadData();
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
