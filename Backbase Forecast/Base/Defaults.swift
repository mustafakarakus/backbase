//
//  Defaults.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import Foundation
class ForecastUserDefaults: NSObject {
    static let defaults = UserDefaults.standard
    static var Bookmarks:[BookmarkModel]{
        get{
            guard let placesData = defaults.object(forKey: Keys.UserBookmarks) as? Data else {
                return []
            }
            guard let placesArray = NSKeyedUnarchiver.unarchiveObject(with: placesData) as? [BookmarkModel] else {
                return []
            }
            return placesArray
        }
        set{
            //cannot append directly: need to archive.
            let bookmarks = NSKeyedArchiver.archivedData(withRootObject: newValue)
            defaults.set(bookmarks, forKey: Keys.UserBookmarks)
            defaults.synchronize()
        }
    }
    static var Unit:Int{
        get{
            guard let unit = defaults.object(forKey: Keys.Unit) as? Int else {
                return WeatherUnit.metric.rawValue
            }
            return unit
        }
        set{
            defaults.set(newValue, forKey: Keys.Unit)
            defaults.synchronize()
        }
    }
    static func addBookmark(_ bookmark: BookmarkModel){
        var bookmarks = ForecastUserDefaults.Bookmarks
        bookmarks.append(bookmark)
        ForecastUserDefaults.Bookmarks = bookmarks
        defaults.synchronize()
    }
    static func removeBookmark(_ id: Int){
        if let bookmarkIndex =  ForecastUserDefaults.Bookmarks.index(where: {$0.id == id}){
            var bookmarks = ForecastUserDefaults.Bookmarks
            bookmarks.remove(at: bookmarkIndex)
            ForecastUserDefaults.Bookmarks = bookmarks
            defaults.synchronize()
        }
    }
    static func ClearDefaults(){
        //UserDefaults sıfırlamak için kullanılacak.
        ForecastUserDefaults.Bookmarks = []
    }
}
