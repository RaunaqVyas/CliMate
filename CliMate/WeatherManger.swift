//
//  WeatherManger.swift
//  CliMate
//
//  Created by Raunaq Vyas on 2021-12-27.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager,weather:WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric"
    let apiKey = MyOpenWeatherApiKey
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)&appid=\(apiKey)"
        perfromRequest(with: urlString)
        print(urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        perfromRequest(with: urlString)
        print(urlString)
    }
    func perfromRequest(with urlString: String){
        //1. create Url
        if let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? " ") {
            //2. Create URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        delegate?.didUpdateWeather(self, weather:weather)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?  {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let description = decodedData.weather[0].description
            let weather = WeatherModel(conditionId: id, cityName: name, temprature: temp,description: description)
            return weather
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
    
}
