//
//  WelcomePageViewController.swift
//  IDRMB Money Changer
//
//  Created by Zaen on 5/25/19.
//  Copyright © 2019 ameliaesra. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBAction func nextButtonTapped(_ sender: Any) {
        
        print("Next button tapped!")
        
        let currencyRatesViewController = self.storyboard?.instantiateViewController(withIdentifier: "CurrencyRatesViewController") as! CurrencyRatesViewController
        
        self.present(currencyRatesViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   

}
