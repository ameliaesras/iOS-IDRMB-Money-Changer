//
//  BuyerProfileViewController.swift
//  IDRMB Money Changer
//
//  Created by Zaen on 5/25/19.
//  Copyright © 2019 ameliaesra. All rights reserved.
//

import UIKit
import Firebase

class BuyerProfileViewController: UIViewController {

    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var emailProfile: UILabel!
    @IBOutlet weak var phoneNumberProfile: UILabel!
    @IBOutlet weak var addressProfile: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataProfile()
    
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getDataProfile()
    }
    
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(loginController, animated: true, completion: nil)
    }
    
    func getDataProfile() {
        guard let uid = Auth.auth().currentUser?.uid else {
            //for some reason uid = nil
            return
        }
        
        Database.database().reference().child("account").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                //                self.navigationItem.title = dictionary["name"] as? String
                
                let name = dictionary["Name"] as? String
                let email = dictionary["Email"] as? String
                let phoneNo = dictionary["PhoneNo"] as? String
                let address = dictionary["Address"] as? String
                
                if name != nil, email != nil, phoneNo != nil, address != nil {
                    self.nameProfile.text = "Name : " + name!
                    self.emailProfile.text = "Email : " + email!
                    self.phoneNumberProfile.text = "PhoneNo : " + phoneNo!
                    self.addressProfile.text = "Address : " + address!
                }
                
            }
            
        }, withCancel: nil)
    }
    
}
