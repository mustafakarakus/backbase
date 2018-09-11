//
//  KnownLocationModel.swift
//  Backbase Forecast
//
//  Created by Admin on 11.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import Foundation
import CoreLocation

class KnownLocationModel{
    var name:String?
    var coordinate:CLLocationCoordinate2D?
    var imageName:String?
    init(name:String, imageName: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.imageName = imageName
        self.coordinate = coordinate
    }
}
