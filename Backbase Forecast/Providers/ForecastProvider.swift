//
//  ForecastProvider.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import Foundation

class ForecastProvider:BaseProvider{
    func getTodaysForecast(latitude:Double, longitute:Double, units:String="metric",result completion:@escaping ((WeatherModel?,Error?)->())){
        let url = "\(Keys.TodaysForecastUrl)&lat=\(latitude)&lon=\(longitute)&units=\(units)"
        createRequest(withUrlString: url) { (result, error) in
            if let result = result{
                completion(WeatherModel(with: result), nil)
            }else{
                completion(nil, error)
            }
        }
    }
    func getFiveDaysForecast(latitude:Double, longitute:Double, units:String="metric",result completion:@escaping (([String : Any]?,Error?)->())){
        let url = "\(Keys.FiveDaysForecastUrl)&lat=\(latitude)&lon=\(longitute)&units=\(units)"
        createRequest(withUrlString: url) { (result, error) in
            completion(result,error)
        }
    }
}
