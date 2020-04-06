//
//  CitiesView.swift
//  FullWeatherApp
//
//  Created by Evgeniy on 05.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

protocol CitiesViewDelegate {
    func selectButtonDidPressed()
    func closeButtonDidPressed()
}

class CitiesView: UIView {
    
    var delegate: CitiesViewDelegate?
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.masksToBounds = true
            containerView.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.layer.masksToBounds = true
            closeButton.layer.cornerRadius = 15
        }
    }
    
    @IBOutlet weak var selectButton: UIButton! {
        didSet {
            selectButton.layer.masksToBounds = true
            selectButton.layer.cornerRadius = 15
        }
    }
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.layer.masksToBounds = true
            textField.layer.cornerRadius = 10
        }
    }
    
    @IBAction func selectButtonDidPressed(_ sender: Any) {
        delegate?.selectButtonDidPressed()
    }
    
    @IBAction func closeButtonDidPressed(_ sender: Any) {
        delegate?.closeButtonDidPressed()
    }

}
