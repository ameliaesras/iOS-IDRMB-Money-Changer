//
//  LoginViewController.swift
//  IDRMB Money Changer
//
//  Created by Zaen on 5/25/19.
//  Copyright © 2019 ameliaesra. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        if emailAddressTextField.text == "" || passwordTextField.text == "" {
            
            alertFillEmailAndPassword()
        } else {
            
              handleLogin()
            
        }
   
        
    }
    
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        print("Cancel button tapped!")
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
        
        print("User forgot the password!")
        
        let resetPasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
        
        self.present(resetPasswordViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        alertNotification()
        
        
    }
    
    @IBAction func aboutUsButtonTapped(_ sender: Any) {
        
        let aboutUsViewController = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
        
        self.present(aboutUsViewController, animated: true, completion: nil)
        
    }
    
    func alertFillEmailAndPassword(){
        
        let alertController = UIAlertController(title: "Error", message: "Please input your email and password!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default) {
            (action) in
            print("default action")
        }
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    func handleLogin() {
        guard  let email = emailAddressTextField.text, let password = passwordTextField.text else {
            print("Your email or password is wrong!")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error ?? "Form is not valid!")
                return
            }
            
            //Successfully logged in
            
            guard let uid = user?.user.uid else {
                return
            }
            
            Database.database().reference().child("account").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                
                        if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                                        let buyerOrSeller = dictionary["buyerOrSeller"] as? String
                                        if buyerOrSeller == "buyer" {
                    
                                            let buyerTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "buyerTabBarController") as! BuyerTabBarController
                    
                                            self.present(buyerTabBarController, animated: true, completion: nil)
                    
                                        } else if buyerOrSeller == "seller" {
                    
                                            let sellerTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "sellerTabBarController") as! SellerTabBarController
                    
                                            self.present(sellerTabBarController, animated: true, completion: nil)
                    
                                        }
                    
                        } else {
                            self.alertFillEmailAndPassword()
                        }
                
            }, withCancel: nil)
           
//            Database.database().reference().child("account").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
//
//                if let dictionary = snapshot.value as? [String: AnyObject] {
//
//                    let buyerOrSeller = dictionary["buyerOrSeller"] as? String
//                    if buyerOrSeller == "buyer" {
//
//                        let buyerTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "BuyerTabBarController") as! BuyerTabBarController
//
//                        self.present(buyerTabBarController, animated: true, completion: nil)
//
//                    } else if buyerOrSeller == "seller" {
//
//                        let sellerTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "SellerTabBarController") as! SellerTabBarController
//
//                        self.present(sellerTabBarController, animated: true, completion: nil)
//
//                    }
//
//                }
//
//            })
            
            
        })
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        emailAddressTextField.delegate = self
        //        passwordTextField.delegate = self
        
    }
    
    
    
    
    func alertNotification() {
        
        let alertController = UIAlertController(title: "Choose Sign Up As", message: "", preferredStyle: .alert)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        
        let buyerAction = UIAlertAction(title: "Buyer", style: .default) {
            (action) in
            print("Buyer sign up action")
            
            secondViewController.signUpStatusAcc = "buyer"
            self.present(secondViewController, animated: true, completion: nil)
        }
        
        let sellerAction = UIAlertAction(title: "Seller", style: .default) {
            (action) in
            print("Seller sign up action")
            secondViewController.signUpStatusAcc = "seller"
            self.present(secondViewController, animated: true, completion: nil)
        }
        
        alertController.addAction(buyerAction)
        //        present(alertController, animated: true, completion: nil)
        
        alertController.addAction(sellerAction)
        present(alertController, animated: true, completion: nil)
        
//        let signUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
//        
//        self.present(signUpViewController, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
