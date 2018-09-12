//
//  Backbase_ForecastTests.swift
//  Backbase ForecastTests
//
//  Created by Admin on 12.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import XCTest
@testable import Backbase_Forecast

class Backbase_ForecastTests: XCTestCase {
    
    private let service = BaseProvider()
    
    func testParsePlainStringAsJsonForWeatherModel() {
        let data = "plain text data".data(using: String.Encoding.utf8)!
        let json = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String : Any]
        guard WeatherModel(with: json) == nil else {
            XCTFail("malformed JSON response")
            return
        }
    }
    func testParsePlainStringAsJsonForForecastModel() {
        let data = "plain text data".data(using: String.Encoding.utf8)!
        let json = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String : Any]
        guard ForecastModel(with: json) == nil else {
            XCTFail("malformed JSON response")
            return
        }
    }
    func testParseUnexpectedJsonForWeatherModel() {
        let data = "{ \"score\": 10, \"sys\": \"task\" }".data(using: String.Encoding.utf8)!
        let json = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String : Any]
        guard WeatherModel(with: json) == nil else {
            XCTFail("malformed JSON response")
            return
        }
    }
    func testParseUnexpectedJsonForForecastModel() {
        let data = "{ \"score\": 10, \"sys\": \"task\" }".data(using: String.Encoding.utf8)!
        let json = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String : Any]
        guard ForecastModel(with: json) == nil else {
            XCTFail("malformed JSON response")
            return
        }
    }
    func testParseValidJsonFromLiveSampleForWeatherModel() {
        service.createRequest(withUrlString: Keys.SampleUrl) { (json, error) in
            guard let weatherModel = WeatherModel(with: json) else {
                XCTFail("Can not parse valid JSON")
                return
            }
            XCTAssertEqual(100, weatherModel.humidity)
            XCTAssertEqual("broken clouds", weatherModel.desc)
            //'broken clouds' and humidity:100 can be change, because url is live sample for openweathermap.org.
        } 
    }
}
