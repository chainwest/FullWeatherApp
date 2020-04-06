//
//  WeatherCoordinator.swift
//  FullWeatherApp
//
//  Created by Evgeniy on 05.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

class WeatherCoordinator: Coordinator {
    let rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    override func start() {
        let apiService = ApiService()
        let viewModel = WeatherViewModel(apiService: apiService)
        viewModel.delegate = self as? WeatherViewModelDelegate
        let weatherVC = WeatherViewController(viewModel: viewModel)
        rootViewController.setViewControllers([weatherVC], animated: false)
    }
}
