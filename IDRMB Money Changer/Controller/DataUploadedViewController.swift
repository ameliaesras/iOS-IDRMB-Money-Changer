//
//  DataUploadedViewController.swift
//  IDRMB Money Changer
//
//  Created by Zaen on 5/25/19.
//  Copyright © 2019 ameliaesra. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseStorage
//import FirebaseAuth
//import FirebaseDatabase

class DataUploadedViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    var fullName: String?
    var email: String?
    var phoneNumber: String?
    var password: String?
    var address: String?
    var passportNumber: String?
    var signUpStatusAcc: String?
    //let image: UIImage!
    var hasBeenTaken: Bool?
    
    @IBOutlet weak var passportImageView: UIImageView!
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }

    
    @IBAction func uploadImageButtonTapped(_ sender: Any) {
        
        if hasBeenTaken != nil || hasBeenTaken == true {
            handleRegister()

        }
        else {
            alertInsertPassportImage()
        }
        
      
        
    }
    
    
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let pickedImage = info[.originalImage] as? UIImage else{
            fatalError("")
        }
        
        var data = Data()
        data = pickedImage.jpegData(compressionQuality: 0.5)!
        passportImageView.image = UIImage(data: data)
        hasBeenTaken = true
        dismiss(animated: true, completion: nil)

        
    }
        
            
    
    
    
    func handleRegister() {
        
        Auth.auth().createUser(withEmail:email!, password: password!) { (user, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            
            guard let uid = user?.user.uid else {
                return
            }
            
            
            //update to firebase database
            let account : [String : Any] = ["Name" : self.fullName!,
                                             "PhoneNo" : self.phoneNumber!,
                                             "Email" : self.email!,
                                             "Address" : self.address!,
                                             "PassportNo" : self.passportNumber!,
                                             "buyerOrSeller" : self.signUpStatusAcc!
                                            
            ]
            
            let databaseRef = Database.database().reference()
            databaseRef.child("account").child(uid).setValue(account)
            
            // update to firebase storage
//            _ = UUID().uuidString
            let storageRef = Storage.storage().reference().child("passportImage").child("\(uid).jpg")
//            _ = self.passportImageView.image!.pngData()
            
            //Data in memory
            
            
            
            if let uploadData = self.passportImageView.image?.jpegData(compressionQuality: 0.1) {
                
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, err) in
                    
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    print("berhasil upload gambar")
                    
                })
            }
            
            print("berhasil")
            
            let uploadPassportImageDone = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmationSignUpController") as! ConfirmationSignUpController
            self.present(uploadPassportImageDone, animated: true, completion: nil)
            
        }
        
    }
    
    @objc func getImage() {
        let passportImage = UIImagePickerController()
        passportImage.delegate = self
        
        //        passportImage.sourceType = UIImagePickerControllerSourceType.camera
        passportImage.sourceType = UIImagePickerController.SourceType.photoLibrary
        passportImage.allowsEditing = false
        self.present(passportImage, animated: true) {
            //After it is complete
        }
    }
    
    func alertInsertPassportImage(){
        
        let alertController = UIAlertController(title: "Error", message: "Please insert your Passport image to continue!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default) {
            (action) in
            print("default action")
        }
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passportImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getImage)))
        
        passportImageView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}




    
    

