//
//  CityViewController.swift
//  Backbase Forecast
//
//  Created by Admin on 11.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import UIKit
import CoreLocation
protocol CityViewControllerDelegate {
    func didDismissed()
    func didBookmarkRemoved(_ weatherId:Int)
}
class CityViewController: BaseViewController {

    var weather:WeatherModel!
    var forecast:ForecastModel!
    var coordinate:CLLocationCoordinate2D!
    var delegate:CityViewControllerDelegate?
    var removeButtonIsHidden:Bool!
    @IBOutlet weak var btnRemoveBookmark: UIButton!
    @IBOutlet weak var tblForecast: UICollectionView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblTemperatureUnit: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var lblMinTemperature: UILabel!
    @IBOutlet weak var lblMaxTemperature: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!

    let provider = ForecastProvider()
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        UISettings()
        loadForecastData()
    }
    
    func initView(){
        lblName.text = weather.name
        lblDescription.text = weather.desc
        imgWeather.image = UIImage(named: weather.icon!)
        lblTemperature.text = String(format: "%.0f", weather.tempereture!)
        lblTemperatureUnit.text = ForecastUserDefaults.Unit == WeatherUnit.metric.rawValue ? "C" : "F"
        let windUnit = ForecastUserDefaults.Unit == WeatherUnit.metric.rawValue ? "m/s" : "mi/h"
        lblWind.text = ": \(weather.windSpeed!) \(windUnit)"
        lblMinTemperature.text = String(format: ": %.0f", weather.minTemperature!)
        lblMaxTemperature.text = String(format: ": %.0f", weather.maxTemperature!)
        lblHumidity.text = ": \(weather.humidity!) %"
    }
    
    func UISettings(){
        self.view.dropShadow(offset: -5)
        self.btnRemoveBookmark.isHidden = removeButtonIsHidden
    }
    func loadForecastData(){
        provider.getFiveDaysForecast(latitude: coordinate.latitude, longitute: coordinate.longitude) { (forecast, error) in
            if let forecast = forecast{
                self.forecast = forecast
                DispatchQueue.main.async {
                    self.tblForecast.reloadData()
                    self.loading.stopAnimating()
                }
            }else{
                
            }
        }
    }
    @IBAction func btnDismiss(_ sender: Any) {
        self.delegate?.didDismissed()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnRemoveBookmark(_ sender: Any) {
        showConfirm(title: Strings.AreYouSure, message: Strings.AreYouSureDescription) { (action) in
            if let weatherId = self.weather.id{
                ForecastUserDefaults.removeBookmark(weatherId)
                self.delegate?.didBookmarkRemoved(weatherId)
                self.dismiss(animated: true, completion: nil)
            }else{
                self.showError(title: Strings.ErrorTitle, message: Strings.ErrorTitle, handler: nil)
            }
        }
    }
    
}
extension CityViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if forecast != nil{
            return forecast.list.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ForecastCollectionViewCell
        let weather = forecast.list[indexPath.row]
        let date = Date(timeIntervalSince1970: weather.dateUTC!)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEE HH:mm"
        cell.lblDateDescription.text = dateFormatter.string(from: date)
        cell.imgWeather.image = UIImage(named: weather.icon!)
        cell.lblTemperature.text = String(format: "%.0f", weather.tempereture!)
        cell.lblTemperatureUnit.text = ForecastUserDefaults.Unit == WeatherUnit.metric.rawValue ? "C" : "F"
        cell.lblDescription.text = weather.desc
        let windUnit = ForecastUserDefaults.Unit == WeatherUnit.metric.rawValue ? "m/s" : "mi/h"
        cell.lblInformation.text = "w: \(weather.windSpeed!) \(windUnit), h: \(weather.humidity!)%"
        return cell
    }
}
