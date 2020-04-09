//
//  WeatherCoordinator.swift
//  FullWeatherApp
//
//  Created by Evgeniy on 05.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

class WeatherCoordinator: Coordinator {
    private let rootViewController: UINavigationController
    
    var viewModel: WeatherViewModel = {
        let apiService = ApiService()
        let viewModel = WeatherViewModel(apiService: apiService)
        return viewModel
    }()
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    override func start() {
        viewModel.coordinatorDelegate = self as? WeatherViewModelDelegate
        let weatherVC = WeatherViewController(viewModel: viewModel)
        rootViewController.setViewControllers([weatherVC], animated: false)
    }
}
