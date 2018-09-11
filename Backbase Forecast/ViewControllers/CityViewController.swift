//
//  CityViewController.swift
//  Backbase Forecast
//
//  Created by Admin on 11.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {

    var weather:WeatherModel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblTemperatureUnit: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var lblMinTemperature: UILabel!
    @IBOutlet weak var lblMaxTemperature: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        UISettings()
    }
    
    func initView(){
        lblName.text = weather.name
        lblDescription.text = weather.desc
        imgWeather.image = UIImage(named: weather.icon!)
        lblTemperature.text = String(format: "%.0f", weather.tempereture!)
        lblTemperatureUnit.text = "C"
        lblWind.text = ": \(weather.windSpeed!) m/s"
        lblMinTemperature.text = String(format: ": %.0f", weather.minTemperature!)
        lblMaxTemperature.text = String(format: ": %.0f", weather.maxTemperature!)
        lblHumidity.text = ": \(weather.humidity!) %"
    }
    
    func UISettings(){
        self.view.dropShadow(offset: -5)
    }
 
    @IBAction func btnDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
