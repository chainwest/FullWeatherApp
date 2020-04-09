//
//  WeatherViewController.swift
//  FullWeatherApp
//
//  Created by Evgeniy on 04.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    let viewModel: WeatherViewModel
    
    let visualEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blur)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @IBOutlet weak var greyView: UIView! {
        didSet {
            greyView.layer.masksToBounds = true
            greyView.layer.cornerRadius = 25
        }
    }

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var precipLabel: UILabel!
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupVisualEffectView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupVisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    
    private func setupAlert() {
        let alert = UIAlertController(title: "", message: "Введите название города", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Название города"
            textField.autocapitalizationType = .sentences
        }
        
        let action = UIAlertAction(title: "ОК", style: .default) { [weak alert] (_) in
            let textField = alert?.textFields![0]
            
            if let cityName = textField?.text {
                Constants.city = cityName
                self.viewModel.getWeather()
            }
            
            self.animateOut()
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func animateIn() {
        UIView.animate(withDuration: 0.2) {
            self.visualEffectView.alpha = 1
        }
    }
    
    private func animateOut() {
        UIView.animate(withDuration: 0.2) {
            self.visualEffectView.alpha = 0
        }
    }
    
    private func baseWeatherState(_ background: String, _ stateImageName: String, _ stateName: String) {
        backgroundImage.image = UIImage(named: background)
        stateImage.image = UIImage(named: stateImageName)
        stateLabel.text = stateName
    }
    
    private func updateWeatherState(state: String) {
        switch state {
        case "Sunny":
            baseWeatherState("Sunny", "SunnyIcon", "Солнечно")
        case "Clear":
            baseWeatherState("Clear", "ClearIcon", "Ясно")
        case "Patchy rain possible":
            baseWeatherState("Rain", "RainIcon", "Пасмурно")
        case "Partly cloudy":
            baseWeatherState("LowCloudyDay", "LowCloudyDayIcon", "Облачно")
        case "Rain":
            baseWeatherState("Rain", "RainIcon", "Дождь")
        case "Overcast":
            baseWeatherState("Cloudy", "CloudyIcon", "Пасмурно")
        case "Light Drizzle":
            baseWeatherState("Rain", "RainIcon", "Мелкий дождь")
        case "Light Rain":
            baseWeatherState("Rain", "RainIcon", "Слабый дождь")
        default:
            print("Weather state is unavailable")
        }
    }
    
    private func dataBinding() {
        viewModel.onDidUpdate = { [weak self] in
            self?.cityLabel.text = Constants.city
            self?.temperatureLabel.text = self?.viewModel.temperature
            self?.feelsLikeLabel.text = self?.viewModel.feelslike
            self?.humidityLabel.text = self?.viewModel.humidity
            self?.precipLabel.text = self?.viewModel.precip
            self?.windLabel.text = self?.viewModel.wind_speed
            self?.updateWeatherState(state: (self?.viewModel.weatherDescription!)!)
        }
    }
    
    @IBAction func cityButtonDidPressed(_ sender: Any) {
        setupAlert()
        animateIn()
        dataBinding()
    }
}
