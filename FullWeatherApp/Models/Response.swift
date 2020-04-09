//
//  Response.swift
//  FullWeatherApp
//
//  Created by Evgeniy on 04.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Foundation

struct Properties: Decodable {
    var temperature: Double
    var windSpeed: Double
    var precip: Double
    var humidity: Double
    var feelslike: Double
    var weatherDescription: [String]
    
    enum CodingKeys: String, CodingKey {
        case temperature
        case windSpeed = "wind_speed"
        case precip
        case humidity
        case feelslike
        case weatherDescription = "weather_descriptions"
    }
}

struct Response: Decodable {
    var current: Properties
}
