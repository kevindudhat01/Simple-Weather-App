import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c63fed199135ec0e124f0905652e500b"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)&units=metric"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString:String){
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, responce, error) in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data{
                    let dataString = String(data: safeData, encoding: .utf8)
                    dump(dataString ?? "")
                    
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJSON(weatherData: Data)-> WeatherModel?{
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let wind = decodedData.wind.speed
            let humi = decodedData.main.humidity
            let desc = decodedData.weather[0].weatherDescription
            
            let weather = WeatherModel.init(conditionId: id, cityName: name, temperature: temp,windSpeed: wind,humidity: humi,conditionDescription: desc)
            
            return weather
        }catch{
            print(error)
            return nil
        }
    }
}
