//
//  SellerEditProfileViewController.swift
//  IDRMB Money Changer
//
//  Created by Zaen on 5/26/19.
//  Copyright © 2019 ameliaesra. All rights reserved.
//

import UIKit
import Firebase

class SellerEditProfileViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var address: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editProfile(_ sender: Any) {
        guard let uid = Auth.auth().currentUser?.uid else {
            //for some reason uid = nil
            return
        }
        
        if name.text != "", phoneNumber.text != "", email.text != "", address.text != "" {
            let account : [String : Any] = ["Name" : name.text!,
                                            "PhoneNo" : phoneNumber.text!,
                                            "Email" : email.text!,
                                            "Address" : address.text!,
                                            ]
            
            let databaseRef = Database.database().reference()
            databaseRef.child("account").child(uid).updateChildValues(account)
        }
        
        
    }

}
