//
//  SignUpViewController.swift
//  IDRMB Money Changer
//
//  Created by Zaen on 5/25/19.
//  Copyright © 2019 ameliaesra. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var signUpStatusAcc: String?
    
    let alertController = UIAlertController(title: "Error", message: "Your data is not complete!", preferredStyle: .alert)
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var phoneNoTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var passportNoTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
 
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {        
        print("Cancel button tapped!")
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        profileImage.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
    }

    

    
    
    func alertNotification() {
        
        let defaultAction = UIAlertAction(title: "OK", style: .default) {
            (action) in
            print("default action")
        }
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        if fullNameTextField.text != "", emailAddressTextField.text != "", phoneNoTextField.text != "", passwordTextField.text != "", confirmPasswordTextField.text != "", addressTextField.text != "", passportNoTextField.text != "" {
            
            if passwordTextField.text == confirmPasswordTextField.text {
                //                createSellerAccount()
                //                authenticationUserAccount()
                
                let nextPage = self.storyboard?.instantiateViewController(withIdentifier: "DataUploadedViewController") as! DataUploadedViewController
                
                nextPage.fullName = fullNameTextField.text
                nextPage.address = addressTextField.text
                nextPage.phoneNumber = phoneNoTextField.text
                nextPage.email = emailAddressTextField.text
                nextPage.passportNumber = passportNoTextField.text
                nextPage.password = passwordTextField.text
                nextPage.signUpStatusAcc = signUpStatusAcc!
                
                
                self.present(nextPage, animated: true, completion: nil)
            } else {
                alertController.message = "Password doesn't match"
                alertNotification()
            }
            
            
        } else {
            alertNotification()
        }
        
        //warning if data is not complete
        
    }
    
//    func authenticationUserAccount() {
//
//        Auth.auth().createUser(withEmail:emailAddressTextField.text!, password: passwordTextField.text!) { (user, error) in
//
//            if error == nil {
//                print("You have successfully signed up")
//                //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
//
//
//
//            } else {
//
//                self.alertNotification()
//            }
//
//        }
//
//
//    }
    
    
    @objc func getImage() {
        print("keClick")
        let userProfileImage = UIImagePickerController()
        userProfileImage.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        //        passportImage.sourceType = UIImagePickerControllerSourceType.camera
        userProfileImage.sourceType = UIImagePickerController.SourceType.photoLibrary
        userProfileImage.allowsEditing = false
        self.present(userProfileImage, animated: true) {
            //After it is complete
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getImage)))
            profileImage.isUserInteractionEnabled = true
        
    }
    
//    func createSellerAccount() {
//        
//        let sellerAccount : [String : Any ] = ["sellerName" : fullNameTextField.text!,
//                                               "sellerPhoneNo" : phoneNoTextField.text!,
//                                               "sellerEmail" : emailAddressTextField.text!,
//                                               "sellerPassword" : passwordTextField.text!,
//                                               "sellerAddress" : addressTextField.text!,
//                                               "sellerPassportNo" : passportNoTextField.text!]
//        
//        let databaseRef: DatabaseReference!
//        databaseRef = Database.database().reference()
//        databaseRef.child("sellerAccount").childByAutoId().setValue(sellerAccount)
//        
//        
//    }
    
    
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
