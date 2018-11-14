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
        var fullURI = addGETParams(path: "/api/users/exist", search: self.searched_user!, needsUsername: true)
        fullURI = fullURI + "&friends=false";
        sendGET(uri: fullURI, callback: { (httpresponse) in
            let data: Data! = httpresponse.data
            // decode the information recieved
            if httpresponse.error != nil {
                guard let feedData = try? JSONDecoder().decode(Existance.self, from: data)
                    else {
                        self.alert(message: "Error loading profile.")
                        return
                }
                if (feedData.value){
                    self.performSegue(withIdentifier: "ToProfile", sender: self)
                }
                else{
                    self.alert(message: "Not a valid username.")
                }
            } else{
                self.alert(message: "Error loading profile.")
            }
        })
    }
    
    
    @IBAction func toProfile() {
        self.searched_user = common.username
        performSegue(withIdentifier: "ToProfile", sender: self)
    }
    
    @IBAction func toMyBets() {
        performSegue(withIdentifier: "ToMyBets", sender: self)
    }
    
    @IBAction func toSettings() {
        performSegue(withIdentifier: "ToSettings", sender: self)
    }
    
}
