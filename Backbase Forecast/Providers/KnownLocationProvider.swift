//
//  KnownLocationProvider.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import Foundation
import CoreLocation

class KnownLocationProvider:BaseProvider{
    func getKnownLocations(result completion:@escaping (([KnownLocationModel],Error?)->())){
        var locations = [KnownLocationModel]()
        locations.append(KnownLocationModel(name: "Amsterdam", imageName: "amsterdam", coordinate: CLLocationCoordinate2D(latitude: 52.3546274, longitude: 4.8285839)))
        locations.append(KnownLocationModel(name: "İstanbul", imageName: "istanbul", coordinate: CLLocationCoordinate2D(latitude: 41.0087192, longitude: 28.9759469)))
        locations.append(KnownLocationModel(name: "San Francisco", imageName: "sanfrancisco", coordinate: CLLocationCoordinate2D(latitude: 37.7576948, longitude: -122.4726193)))
        locations.append(KnownLocationModel(name: "Barcelona", imageName: "barcelona", coordinate: CLLocationCoordinate2D(latitude: 41.3947688, longitude: 2.0787284)))
        locations.append(KnownLocationModel(name: "Moscow", imageName: "moscow", coordinate: CLLocationCoordinate2D(latitude: 55.5807482, longitude: 36.8251543)))
        locations.append(KnownLocationModel(name: "Paris", imageName: "paris", coordinate: CLLocationCoordinate2D(latitude: 48.8588377, longitude: 2.2770207)))
        locations.append(KnownLocationModel(name: "Hong Kong", imageName: "hongkong", coordinate: CLLocationCoordinate2D(latitude: 22.3526738, longitude: 113.9876165)))
        completion(locations,nil)
    }
}
