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
    
    private lazy var alertView: CitiesView = {
        let alertView = (Bundle.main.loadNibNamed("CitiesView", owner: self, options: nil)?.first as! CitiesView)
        alertView.delegate = self
        return alertView
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
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
        view.addSubview(alertView)
        alertView.center = view.center
    }
    
    private func animateIn() {
        alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        alertView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.visualEffectView.alpha = 1
            self.alertView.alpha = 1
            self.alertView.transform = CGAffineTransform.identity
        }
    }
    
    private func animateOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.visualEffectView.alpha = 0
            self.alertView.alpha = 0
            self.alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)

        }) { (_) in
            self.alertView.removeFromSuperview()
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
        }
    }
    
    @IBAction func cityButtonDidPressed(_ sender: Any) {
        setupAlert()
        animateIn()
        dataBinding()
    }
}

extension WeatherViewController: CitiesViewDelegate {
    func selectButtonDidPressed() {
        if !alertView.textField.text!.isEmpty {
            Constants.city = alertView.textField.text!
            alertView.textField.text! = ""
            viewModel.getWeather()
        }
        animateOut()
    }
    
    func closeButtonDidPressed() {
        animateOut()
    }
}
