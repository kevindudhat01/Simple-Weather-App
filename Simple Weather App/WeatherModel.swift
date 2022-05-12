import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let windSpeed: Double
    let humidity: Int
    let conditionDescription: String
    
    var temperatureString:String{
        return String(format: "%.0f", temperature)
    }
    
    var conditionName: String{
        switch conditionId {
        case 200...232:
            return "cloud"
        case 300...321:
            return "cloudDrizzle"
        case 500...531:
            return "cloudRain"
        case 600...622:
            return "cloudSnow"
        case 701...781:
            return "cloudFog"
        case 800:
            return "sunMax"
        case 801...804:
            return "cloudBold"
        default:
            return "cloud"
        }
    }
}
