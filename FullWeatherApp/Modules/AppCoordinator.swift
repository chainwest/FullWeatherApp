//
//  AppCoordinator.swift
//  FullWeatherApp
//
//  Created by Evgeniy on 05.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow?
    
    lazy var rootViewController: UINavigationController = {
        return UINavigationController(rootViewController: UIViewController())
    }()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() {
        guard let window = window else {
            return
        }
        
        let weatherCoordinator = WeatherCoordinator(rootViewController: rootViewController)
        self.addChildCoordinator(weatherCoordinator)
        weatherCoordinator.start()
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    override func finish() {}
}
