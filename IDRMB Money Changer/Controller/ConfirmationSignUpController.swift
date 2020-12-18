//
//  ConfirmationSignUpController.swift
//  IDRMB Money Changer
//
//  Created by Zaen on 5/25/19.
//  Copyright © 2019 ameliaesra. All rights reserved.
//

import UIKit

class ConfirmationSignUpController: UIViewController {

    @IBAction func okButtonTapped(_ sender: Any) {
        
        let currencyRatesViewController = self.storyboard?.instantiateViewController(withIdentifier: "CurrencyRatesViewController") as! CurrencyRatesViewController
        
        self.present(currencyRatesViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}
