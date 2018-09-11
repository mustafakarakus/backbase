//
//  BookmarkModel.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import Foundation
class BookmarkModel:NSObject,NSCoding {
    var id:Int?
    var latitude:String?  //NSCoding floating point issue, whats why string
    var longitude:String? //NSCoding floating point issue, whats why string
    var name:String?
    
    init(id:Int ,latitude: String, longitude: String, name: String?) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as? Int ?? 0
        self.latitude = aDecoder.decodeObject(forKey: "latitude") as? String ?? ""
        self.longitude = aDecoder.decodeObject(forKey: "longitude") as? String ?? ""
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(longitude, forKey: "longitude")
        aCoder.encode(name, forKey: "name")
    }
}
