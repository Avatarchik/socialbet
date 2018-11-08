//
//  BetBuilderOpponentSelection.swift
//  SocialBet
//
//  Created by Alex Chapp on 11/8/18.
//  Copyright © 2018 Nick Cargill. All rights reserved.
//

import UIKit

class BetBuilderOpponentSelection: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Here is the function where we define what to do during each segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("Prepare Override works!");
        
        //If going to next stage of bet builder
        if let vc = segue.destination as? BetBuilderGameSelection{
            if (self.isValidHandle(handle: self.entered_handle)){
                vc.selectedOpponent = self.entered_handle;
            }
            else{
                //TODO - Print some error message about invalid handle
            }
            
        }
    }
    
    func isValidHandle(handle: String?) -> Bool{
        //TODO - Check this handle against all handles in db to find a match
        return true; //TODO - Change this! Just a placeholder
    }
    
    var entered_handle: String?;
    @IBOutlet weak var OpponentHandle: UITextField!
    
    @IBAction func CreateOpenBet(_ sender: Any) {
        self.entered_handle = "";
        performSegue(withIdentifier: "OpponentSelectToGameSelect", sender: self);
    }
    
    @IBAction func CreateDirectBet(_ sender: Any) {
        self.entered_handle = self.OpponentHandle.text;
        performSegue(withIdentifier: "OpponentSelectToGameSelect", sender: self);
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
