//
//  ViewController.swift
//  Weather
//
//  Created by Licardo on 2019/10/18.
//  Copyright © 2019 Licardo. All rights reserved.
//

import Alamofire
import CoreLocation
import SwiftyJSON
import UIKit

class ViewController: UIViewController {
    @IBOutlet var tempText: UILabel!
    @IBOutlet var condText: UILabel!
    @IBOutlet var condImage: UIImageView!
    @IBOutlet var location: UILabel!
    
    let locationManager = CLLocationManager()
    let weather = Weather()
    let key = "7a1f3fa88b1a4f6dac2e04c54c835398"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters // 设置位置精度
        locationManager.requestLocation() // 请求用户位置信息--只请求一次
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.requestWhenInUseAuthorization() // 请求授权获取当前位置
    }
    
    @IBAction func locationButton(_ sender: UIButton) {
        viewDidLoad()
    }
    
    @IBAction func weatherService(_ sender: UIButton) {
        guard let url = URL(string: "https://www.heweather.com/") else { return }
        UIApplication.shared.open(url)
    }
    
    // 当请求用户位置信息的时候立即调用这个方法--系统调用
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lat = locations[0].coordinate.latitude
        let lon = locations[0].coordinate.longitude
        
        let paras = ["location": "\(lat),\(lon)", "key": key]
        getWeatherDate(paras: paras)
    }
    
    // 导航之前做的准备--一般是传参操作
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "searchPage" {
            let searchPage = segue.destination as! SearchPageController
            searchPage.currentCity = location.text!
            searchPage.delegate = self
        }
    }
}

extension ViewController: CLLocationManagerDelegate, SearchPageDelegate {
    func didChangeCity(city: String) {
        let paras = ["location": city, "key": key]
        getWeatherDate(paras: paras)
    }
    
    // 请求API获取数据
    func getWeatherDate(paras: [String: String]) {
        Alamofire.request("https://free-api.heweather.net/s6/weather/now", parameters: paras).responseJSON { response in
            // iflet对可选类型的数据进行判断
            if let json = response.result.value {
                let weather = JSON(json)
                self.creatWeatherDate(weatherJSON: weather)
                self.updateUI()
            }
        }
    }
    
    // 给weather对象复制
    func creatWeatherDate(weatherJSON: JSON) {
        weather.temp = weatherJSON["HeWeather6", 0, "now", "tmp"].stringValue
        weather.location = weatherJSON["HeWeather6", 0, "basic", "location"].stringValue
        weather.parentCity = weatherJSON["HeWeather6", 0, "basic", "parent_city"].stringValue
        weather.condCode = weatherJSON["HeWeather6", 0, "now", "cond_code"].stringValue
        weather.condText = weatherJSON["HeWeather6", 0, "now", "cond_txt"].stringValue
        weather.status = weatherJSON["HeWeather6", 0, "status"].stringValue
    }
    
    // 更新界面
    func updateUI() {
        switch weather.status {
        case "ok":
            tempText.text = "\(weather.temp)˚"
            condText.text = weather.condText
            condImage.image = UIImage(named: weather.condCode)
            if weather.location != weather.parentCity {
                location.text = "\(weather.location), \(weather.parentCity)"
            } else {
                location.text = "\(weather.location)"
            }
        case "unknown location":
            tempText.text = ""
            location.text = ""
            condText.text = "没有您查询的这个地区，或者地区名称错误!"
            condImage.image = UIImage(named: "999")
        default:
            tempText.text = ""
            location.text = ""
            condText.text = "查询异常，重新查询!"
            condImage.image = UIImage(named: "999")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        location.text = "位置信息获取失败！"
    }
}
