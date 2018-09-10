//
//  ForecastModel.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import Foundation
class ForecastModel:NSObject {
    var id: Int?
    var code:Int?
    var name : String?
    var desc:String?
    var icon:String?
    var main:String?
    var humidity:Int?
    var tempereture:Double?
    var windSpeed:Double?
    var windDegree:Double?
    var rainChange:Double?
    init(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        name = dictionary["name"] as? String
        id = dictionary["id"] as? Int
        code = dictionary["cod"] as? Int
        if let weatherInformation = dictionary["weather"] as? [[String:Any]]{
            if let weather = weatherInformation.first{
                desc = weather["description"] as? String
                icon = weather["icon"] as? String
                main = weather["main"] as? String
            }
        }
        if let mainInformation = dictionary["main"] as? [String:Any]{
            humidity = mainInformation["humidity"] as? Int
            tempereture = mainInformation["temp"] as? Double
        }
        if let windInformation = dictionary["wind"] as? [String:Any]{
            windSpeed = windInformation["speed"] as? Double
            windDegree = windInformation["deg"] as? Double
        }
        if let rainInformation = dictionary["rain"] as? [String:Any]{
            rainChange = rainInformation["3h"] as? Double
        }
    }
}
