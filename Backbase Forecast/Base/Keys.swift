//
//  Keys.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import Foundation

struct Keys {
    static let BaseUrl = "http://api.openweathermap.org/data/2.5"
    static let ApiKey = "c6e381d8c7ff98f0fee43775817cf6ad"
    static let TodaysForecastUrl = "\(Keys.BaseUrl)/weather?appid=\(Keys.ApiKey)"
    static let FiveDaysForecastUrl = "\(Keys.BaseUrl)/forecast?appid=\(Keys.ApiKey)"

    
    //    static let TodaysForecastUrl = "\(Keys.BaseUrl)/weather?lat=0&lon=0&appid=\(Keys.ApiKey)&units=metric"

    
} 
