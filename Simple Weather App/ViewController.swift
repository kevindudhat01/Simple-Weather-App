import UIKit

class ViewController: UIViewController,UITextFieldDelegate, WeatherManagerDelegate {
    
    var weatherManager = WeatherManager()

    @IBOutlet var cityNameTextField: UITextField!
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameTextField.delegate = self
        weatherManager.delegate = self
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        print(cityNameTextField.text!)
        cityNameTextField.endEditing(true)
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(cityNameTextField.text!)
        cityNameTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == ""{
            cityNameTextField.placeholder = "Write Something..."
            return false
        }else{
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = cityNameTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = "\(weather.temperatureString)°"
            self.conditionImageView.image = UIImage(named: weather.conditionName)
            self.cityNameLabel.text = self.cityNameTextField.text
            self.windLabel.text = String(Double(weather.windSpeed))
            self.humidityLabel.text = String(Int(weather.humidity))
            self.descriptionLabel.text = weather.conditionDescription
        }
    }
}
