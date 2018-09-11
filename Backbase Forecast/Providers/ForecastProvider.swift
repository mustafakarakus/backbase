//
//  ForecastProvider.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import Foundation

class ForecastProvider:BaseProvider{
    func getTodaysForecast(latitude:Double, longitute:Double,result completion:@escaping ((WeatherModel?,Error?)->())){
        let unit = WeatherUnit(rawValue: ForecastUserDefaults.Unit)!
        let url = "\(Keys.TodaysForecastUrl)&lat=\(latitude)&lon=\(longitute)&units=\(unit)"
        createRequest(withUrlString: url) { (result, error) in
            if let result = result{
                completion(WeatherModel(with: result), nil)
            }else{
                completion(nil, error)
            }
        }
    }
    func getFiveDaysForecast(latitude:Double, longitute:Double,result completion:@escaping ((ForecastModel?,Error?)->())){
        let unit = WeatherUnit(rawValue: ForecastUserDefaults.Unit)!
        let url = "\(Keys.FiveDaysForecastUrl)&lat=\(latitude)&lon=\(longitute)&units=\(unit)"
        createRequest(withUrlString: url) { (result, error) in
            if let result = result{
                completion(ForecastModel(with: result), nil)
            }else{
                completion(nil, error)
            }
        }
    }
}
