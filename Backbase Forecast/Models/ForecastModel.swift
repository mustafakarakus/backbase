//
//  ForecastModel.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import Foundation
class ForecastModel:NSObject {
    var code:String?
    var cnt:Int?
    var list = [WeatherModel]()
    var cityName:String?
    
    init(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        code = dictionary["cod"] as? String
        cnt = dictionary["cnt"] as? Int
        if let cityInformation = dictionary["city"] as? [String:Any]{
                cityName = cityInformation["name"] as? String
        }
        if let weatherList = dictionary["list"] as? [[String:Any]]{
            list = []
            for weather in weatherList{
                list.append(WeatherModel(with: weather))
            }
        }
    }
}
