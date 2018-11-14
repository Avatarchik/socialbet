//
//  Settings.swift
//  SocialBet
//
//  Created by Alex Chapp on 11/9/18.
//  Copyright © 2018 SocialBet. All rights reserved.
//

import UIKit
import Photos

class Settings: UIViewController, UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var ProfilePic: UIImageView!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //TODO - Add real image based on profile_pic_url here
        self.ProfilePic.image = UIImage(named: "defaultProfilePic.png");
        
        checkPermission();
        
        let firstRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.profilePicPressed(sender:)))
        firstRecognizer.delegate = self
        self.ProfilePic.isUserInteractionEnabled = true;
        self.ProfilePic.addGestureRecognizer(firstRecognizer)
        
    }
    
    @objc func profilePicPressed(sender: AnyObject) {
        // TO DO ADD THE PROFILE PIC
        print("Profile Pic PRESSED");
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : AnyObject]){
        
        if let pickedImage = info[.originalImage] as? UIImage {
            self.ProfilePic.image = pickedImage
            print("Profile picture has been changed to the picked image")
        } else {
            print("Something went wrong")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel profile picture selection is clicked")
        dismiss(animated: true, completion: nil)
    }
    
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    
    
    
    @IBAction func settingsToHome() {
        performSegue(withIdentifier: "SettingsToHome", sender: self)
    }

}
