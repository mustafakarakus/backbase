//
//  BookmarkModel.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import Foundation
class BookmarkModel:NSObject,NSCoding {
    var latitude:String?
    var longitude:String?
    var name:String?
    
    init(latitude: String, longitude: String, name: String?) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.latitude = aDecoder.decodeObject(forKey: "latitude") as? String ?? ""
        self.longitude = aDecoder.decodeObject(forKey: "longitude") as? String ?? ""
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(longitude, forKey: "longitude")
        aCoder.encode(name, forKey: "name")
    }
}
