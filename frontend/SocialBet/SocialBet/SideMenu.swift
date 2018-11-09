//
//  SideMenu.swift
//  SocialBet
//
//  Created by Nick Cargill on 11/8/18.
//  Copyright © 2018 SocialBet. All rights reserved.
//

import UIKit

class SideMenu: UITableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        switch indexPath.row {
        case 0: print("Add search bar functionality")
        case 1: toProfile()
        case 2: toNotifications()
        case 3: toSettings()
        default: break
        }
    }
    
    
    @IBAction func toProfile() {
        performSegue(withIdentifier: "ToProfile", sender: self)
    }
    
    @IBAction func toNotifications() {
        performSegue(withIdentifier: "ToNotifications", sender: self)
    }
    
    @IBAction func toSettings() {
        performSegue(withIdentifier: "MenuToSettings", sender: self)
    }
    
    
    
    
}
