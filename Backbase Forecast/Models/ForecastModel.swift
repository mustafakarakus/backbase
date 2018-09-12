//
//  ForecastModel.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import Foundation
class ForecastModel:NSObject {
    
    var list = [WeatherModel]()
    var cityName:String?
    
    init?(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary,
            let cityInformation = dictionary["city"] as? [String:Any],
            let cityName = cityInformation["name"] as? String,
            let weatherList = dictionary["list"] as? [[String:Any]]
            else
        {
            return nil
        }
        self.cityName = cityName
        list = []
        for weather in weatherList{
            if let weatherModel = WeatherModel(with: weather){
                list.append(weatherModel)
            }
        }
    }
}
