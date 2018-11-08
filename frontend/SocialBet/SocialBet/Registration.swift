//
//  Registration.swift
//  SocialBet
//
//  Created by Alex Chapp on 10/26/18.
//  Copyright © 2018 Nick Cargill. All rights reserved.
//

import UIKit

class Registration: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var RegistrationUsername: UITextField!
    @IBOutlet weak var RegistrationPassword: UITextField!
    @IBOutlet weak var RegistrationConfirmPassword: UITextField!
    @IBOutlet weak var RegistrationPhoneNumber: UITextField!
    @IBOutlet weak var RegistrationFirstName: UITextField!
    @IBOutlet weak var RegistrationLastName: UITextField!
    
    @IBAction func RegistrationSubmit(_ sender: Any) {
        //TODO - Send contents of text boxes for confirmation
        //and account creation
        performSegue(withIdentifier: "RegistrationToLiveFeed", sender: self);
    }
    
     @IBAction func GoToLogin(_ sender: Any) {
        performSegue(withIdentifier: "RegistrationToLogin", sender: self)
     }
    
    @IBAction func GoToHelp(_ sender: Any) {
        performSegue(withIdentifier: "FakeRegToProf", sender: self);
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
