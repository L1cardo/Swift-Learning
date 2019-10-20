//
//  SearchPageController.swift
//  Weather
//
//  Created by Licardo on 2019/10/20.
//  Copyright © 2019 Licardo. All rights reserved.
//

import UIKit

protocol SearchPageDelegate {
    func didChangeCity(city: String)
}

class SearchPageController: UIViewController {
    var delegate: SearchPageDelegate?
    var currentCity = ""

    @IBOutlet var currentCityLabel: UILabel!
    @IBOutlet var cityInput: UITextField!

    @IBAction func changeCity(_ sender: UIButton) {
        delegate?.didChangeCity(city: cityInput.text!)
        if cityInput.text!.isEmpty {
            let alert = UIAlertController(title: "错误！", message: "城市名不能为空！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "重新输入", style: .default, handler: { _ in
            }))
            present(alert, animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currentCityLabel.text = currentCity

        // Do any additional setup after loading the view.
    }

    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
