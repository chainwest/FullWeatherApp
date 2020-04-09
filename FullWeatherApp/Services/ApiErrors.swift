//
//  ApiErrors.swift
//  FullWeatherApp
//
//  Created by Evgeniy on 09.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case cityNotFound
    case serverError
    case badCityError
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .cityNotFound:
            return "City not found."
        case .serverError:
            return "There is some error from server."
        case .badCityError:
            return "Couldn't get data for city."
        }
    }
}
