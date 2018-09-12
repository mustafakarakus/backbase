//
//  WeatherModel.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import Foundation
class WeatherModel:NSObject {
    var id: Int?
    var name : String?
    var desc:String?
    var icon:String?
    var main:String?
    var humidity:Int?
    var tempereture:Double?
    var minTemperature:Double?
    var maxTemperature:Double?
    var windSpeed:Double?
    var windDegree:Double?
    var rainChange:Double?
    var dateDescription:String?
    var dateUTC:TimeInterval?

    init?(with dictionary: [String: Any]?) {
        
        guard let dictionary = dictionary,
            let weatherInformation = dictionary["weather"] as? [[String:Any]],
            let desc = weatherInformation[0]["description"] as? String,
            let icon = weatherInformation[0]["icon"] as? String,
            let main = weatherInformation[0]["main"] as? String,
            let mainInformation = dictionary["main"] as? [String:Any],
            let humidity = mainInformation["humidity"] as? Int,
            let tempereture = mainInformation["temp"] as? Double,
            let minTemperature = mainInformation["temp_min"] as? Double,
            let maxTemperature = mainInformation["temp_max"] as? Double,
            let windInformation = dictionary["wind"] as? [String:Any],
            let windSpeed = windInformation["speed"] as? Double
            else 
        {
            return nil
        }
        
        self.desc = desc
        self.icon = icon
        self.main = main
        self.humidity = humidity
        self.tempereture = tempereture
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.windSpeed = windSpeed
        
        //Optional, for forecast model
        self.dateUTC = dictionary["dt"] as? TimeInterval 
        self.dateDescription = dictionary["dt_txt"] as? String
        if let rainInformation = dictionary["rain"] as? [String:Any]{
            self.rainChange = rainInformation["3h"] as? Double
        }
        self.name = dictionary["name"] as? String
        self.id = dictionary["id"] as? Int
    }
}
