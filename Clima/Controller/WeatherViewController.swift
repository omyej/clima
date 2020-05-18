//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
//MARK: variables
    var weatherManager = WeatherManager()
    
    //MARK: IB Variables
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets up a notifier of all user interactions with the text field.  Notifies this view controller.
        searchTextField.delegate = self
    }

//MARK: IB actions
    // When the user presses the magnifying glass search button
    @IBAction func searchPressed(_ sender: UIButton) {
        // force the softkeyboard closed
        print(searchTextField.text!)
        searchTextField.endEditing(true)
    }

//MARK: Delegate Methods
    // Action to take when the user presses the softkeyboard return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // force the softkeyboard closed
        print(searchTextField.text!)
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type a location here"
            return false
        }
    }
    
    // When delegate (this view controller / self) receives a notification that the the user is done editing, clear the search field
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Use searchTextField.text to get the weather for that city.
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

