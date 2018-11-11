//
//  SideMenu.swift
//  SocialBet
//
//  Created by Nick Cargill on 11/8/18.
//  Copyright © 2018 SocialBet. All rights reserved.
//

import UIKit

class SideMenu: UITableViewController {

    @IBOutlet weak var enteredHandle: UITextField!
    var searched_user: String?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        switch indexPath.row {
        case 0: toFriendsProfile()
        case 1: toFriendsProfile()
        case 2: toProfile()
        case 3: toMyBets()
        case 4: toSettings()
        default: break
        }
    }
    
    
    @IBAction func toFriendsProfile() {
        self.searched_user = enteredHandle.text;
        performSegue(withIdentifier: "ToProfile", sender: self)
    }
    
    
    @IBAction func toProfile() {
        self.searched_user = username
        performSegue(withIdentifier: "ToProfile", sender: self)
    }
    
    @IBAction func toMyBets() {
        performSegue(withIdentifier: "ToMyBets", sender: self)
    }
    
    @IBAction func toSettings() {
        performSegue(withIdentifier: "ToSettings", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Override works!")
        if let vc = segue.destination as? Profile{
            if (isValidHandle(handle: self.searched_user, friends: false)) {
                vc.searchedUser = self.searched_user!;
            }
        }
    }
    
    
}
