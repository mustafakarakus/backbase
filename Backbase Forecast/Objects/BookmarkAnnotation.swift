//
//  BookmarkAnnotation.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import UIKit
import MapKit

class BookmarkAnnotation:MKPointAnnotation{
    
    let id:Int!
    let model:BookmarkModel
   
    init(id:Int!,model:BookmarkModel){
        self.id = id
        self.model = model
    }
}

