//
//  Settings.swift
//  SocialBet
//
//  Created by Alex Chapp on 11/9/18.
//  Copyright © 2018 SocialBet. All rights reserved.
//

import UIKit

class Settings: UIViewController, UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var ProfilePic: UIImageView!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let firstRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.profilePicPressed(sender:)))
        firstRecognizer.delegate = self
        self.ProfilePic.addGestureRecognizer(firstRecognizer)
        
    }
    
    @objc func profilePicPressed(sender: AnyObject) {
        // TO DO ADD THE PROFILE PIC
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        self.ProfilePic.image = image
        
    }
    
    @IBAction func settingsToHome() {
        performSegue(withIdentifier: "SettingsToHome", sender: self)
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
