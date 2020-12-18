//
//  CurrencyRateViewController.swift
//  IDRMB Money Changer
//
//  Created by Zaen on 5/25/19.
//  Copyright © 2019 ameliaesra. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class CurrencyRatesViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate{
    

    let baseURL = "https://api.exchangerate-api.com/v4/latest/CNY"
    let currencyArray = ["CNY","IDR","EUR","USD","MYR","HKD","KRW","JPY","AUD","INR","THB","SGD","NOK","SEK","ISK","CAD","CZK"]
    let currencySymbolsArray = ["¥", "Rp", "€", "$", "RM", "$", "₩", "¥","$","₹","฿","$","kr","kr","kr","$","Kč"]
    
    var currencySelected = ""
    var targetCurrency = ""
  
    @IBOutlet weak var cnyExchangeRatesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        print("Login Button Tapped!")
        
        let loginButtonViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        self.present(loginButtonViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        getDateOfCurrencyRate(url: baseURL)
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 //single column in picker view
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        targetCurrency = currencyArray[row]
        print(targetCurrency)
        print(baseURL)
        currencySelected = currencySymbolsArray[row]
        
        getCurrencyRateData(url: baseURL)
        
    }
    
    
    //NETWORKING
    func getCurrencyRateData(url: String) {
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    print("Success! Got the currency exchange rates data")
                    let currencyJSON : JSON = JSON(response.result.value!) //swiftyJSON
                    
                    
                    self.updateCurrencyRatesData(json : currencyJSON)
                    
                } else {
                    
                    print("Error: \(String(describing: response.result.error))")
                    self.cnyExchangeRatesLabel.text = "Connection Issues"
                }
        }
    }
    
    func updateCurrencyRatesData(json : JSON) {
        
        
        if let cnyRateResult = json["rates"][targetCurrency] .float {
            
            cnyExchangeRatesLabel.text = currencySelected + " " + String(cnyRateResult)
            
        } else {
            
            cnyExchangeRatesLabel.text = "Rates Unavailable"
            
        }
        
    }
    
    func getDateOfCurrencyRate(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    print("Success! Got the date of currency rates data")
                    let dateJSON : JSON = JSON(response.result.value!) //swiftyJSON
                    
                    self.updateDateOfCurrencyRate(json: dateJSON)
                } else {
                    
                    print("Error: \(String(describing: response.result.error))")
                    self.dateLabel.text = "Connection Issues"
                    
                }
        }
    }
    
    func updateDateOfCurrencyRate(json : JSON) {
        
        if let dateDisplay = json["date"].string {
            
            dateLabel.text = dateDisplay
            
        } else {
            
            dateLabel.text = "Error"
            
        }
    }

}
