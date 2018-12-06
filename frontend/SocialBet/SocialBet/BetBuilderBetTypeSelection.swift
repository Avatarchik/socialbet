//
//  BetBuilderOpponentSelection.swift
//  SocialBet
//

import UIKit

class BetBuilderBetTypeSelection: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.OpponentHandle.isHidden = true;
        self.OKObject.isHidden = true;
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    //Here is the function where we define what to do during each segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("Prepare Override works!");
        
        //If going to next stage of bet builder
        if let vc = segue.destination as? BetBuilderGameSelection{
            vc.selectedOpponent = self.entered_handle;
        }
    }
    
    @IBOutlet weak var OKObject: UIButton!
    @IBOutlet weak var OpponentHandle: UITextField!
    var entered_handle: String?;
    
    @objc func OKButton(sender: Any?) {
        self.entered_handle = self.OpponentHandle.text!;
        if(self.entered_handle == common.username){
            self.alert(message: "Error: cannot create a bet against yourself");
        }
        let fullURI = addGETParams(path: "/api/users/find/", search: self.entered_handle!, search_number: -1, needsUsername: true, needsUser_id: false)
        sendGET(uri: fullURI, callback: { (httpresponse) in
            let data: Data! = httpresponse.data
            // decode the information recieved
            if httpresponse.HTTPsuccess! {
                guard let feedData = try? JSONDecoder().decode(UserExists.self, from: data)
                    else {
                        self.alert(message: "Error creating bet.")
                        return
                }
                if (feedData.first_name != nil){
                    if (feedData.friends!) {
                        // TODO: Pass feedData username to the next page
                        self.performSegue(withIdentifier: "BetTypeSelectToGameSelect", sender: self)
                    } else {
                        self.alert(message: "Username entered does not match any of your friends. Please try again.")
                    }
                }
                else{
                    self.alert(message: "Username does not exists. Are you crazy? Please try again.")
                }
            } else{
                self.alert(message: "Error loading profile.")
            }
        })
    }
    
    @IBAction func HomeButton(_ sender: Any) {
        performSegue(withIdentifier: "BetTypeSelectToFeed", sender: self)
    }
    
    @IBAction func CreateOpenBetButton(_ sender: Any) {
        self.entered_handle = "";
        performSegue(withIdentifier: "BetTypeSelectToGameSelect", sender: self);
    }
    
    
    @IBAction func CreateDirectBetButton(_ sender: Any) {
        self.OKObject.isHidden = false;
        self.OpponentHandle.isHidden = false;
        self.OKObject.addTarget(self, action: #selector(OKButton(sender:)), for: .touchUpInside)
    }
}

