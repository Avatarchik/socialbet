//
//  MyBets.swift
//  SocialBet
//
//  Created by Alex Chapp on 11/8/18.
//  Copyright © 2018 Nick Cargill. All rights reserved.
//

import UIKit

class MyBets: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var ResultsObject: UIButton!
    @IBOutlet weak var RequestsObject: UIButton!
    @IBOutlet weak var OpenObject: UIButton!
    @IBOutlet weak var LiveObject: UIButton!
    
    
    @IBAction func notificationsToHome() {
        performSegue(withIdentifier: "NotificationsToHome", sender: self)
    }
    
    @IBAction func Live(_ sender: Any) {
        self.LiveObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
        self.OpenObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
        self.ResultsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
        self.RequestsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
    }
    
    @IBAction func Open(_ sender: Any) {
        self.OpenObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
        self.LiveObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
        self.ResultsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
        self.RequestsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
    }
    
    @IBAction func Requests(_ sender: Any) {
        self.RequestsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
        self.OpenObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
        self.ResultsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
        self.LiveObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
    }
    
    @IBAction func Results(_ sender: Any) {
        self.ResultsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
        self.OpenObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
        self.LiveObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
        self.RequestsObject.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15);
    }
    
    
    @IBOutlet weak var MyFeed: UICollectionView!

}
