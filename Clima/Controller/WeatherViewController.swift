//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
//MARK: variables
    var weatherManager = WeatherManager()
    
    //MARK: IB Variables
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        // sets up a notifier of all user interactions with the text field.  Notifies this view controller.
        searchTextField.delegate = self
    }
}


//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    //MARK: IB actions
    // When the user presses the magnifying glass search button
    @IBAction func searchPressed(_ sender: UIButton) {
        // force the softkeyboard closed
        searchTextField.endEditing(true)
    }

    // Action to take when the user presses the softkeyboard return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // force the softkeyboard closed
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


//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        // When using a long running task like a network call, we need to wrap dependednt data
        // with the following so it doesn't hang, waiting on the network
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
