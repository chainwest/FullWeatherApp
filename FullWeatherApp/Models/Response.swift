//
//  Response.swift
//  FullWeatherApp
//
//  Created by Evgeniy on 04.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Foundation

struct Current: Decodable {
    var temperature: Double
    var wind_speed: Double
    var precip: Double
    var humidity: Double
    var feelslike: Double
}

struct Response: Decodable {
    var current: Current
}
