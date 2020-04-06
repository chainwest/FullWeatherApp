//
//  WeatherViewModel.swift
//  FullWeatherApp
//
//  Created by Evgeniy on 04.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit
import Alamofire

protocol WeatherViewModelDelegate: class {
    func weatherViewModel(_ viewModel: WeatherViewModel)
}

class WeatherViewModel {
    weak var delegate: WeatherViewModelDelegate?
    
    var onDidUpdate: (() -> Void)?
    
    private let apiService: ApiService
    
    private(set) var temperature: String?
    private(set) var wind_speed: String?
    private(set) var precip: String?
    private(set) var humidity: String?
    private(set) var feelslike: String?
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getWeather() {
        apiService.getWeatherByCity { response in
            switch response {
            case .success(let data):
                self.temperature = String(data.current.temperature)
                self.wind_speed = String(data.current.wind_speed)
                self.precip = String(data.current.precip)
                self.humidity = String(data.current.humidity)
                self.feelslike = String(data.current.feelslike)
                self.onDidUpdate?()
            case .failure(let error):
                print(error)
            }
        }
    }
}
