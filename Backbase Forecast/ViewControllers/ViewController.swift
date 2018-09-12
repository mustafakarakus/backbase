//
//  ViewController.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import UIKit
import MapKit

class ViewController: BaseViewController {
    // MARK: variables
    let provider = ForecastProvider()
    var locationManager = CLLocationManager()
    var data = [BookmarkModel]()
    var partialViewHeight = UIScreen.main.bounds.height / 2
    
    // MARK: IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationSettings()
        addBookmarkPinGesture()
        refreshExistingBookmarkPins()
    }
    
    // MARK: functions
    func locationSettings(){
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
        if let userLocation = locationManager.location{
            self.getForecastAndShow(coordinate: userLocation.coordinate,removeButtonIsHidden:true)
        }
    }
    func setMapRegion(_ coordinate:CLLocationCoordinate2D,span: MKCoordinateSpan){
        let newRegion = MKCoordinateRegionMake(coordinate,span)
        self.mapView.setRegion(newRegion, animated: true)
    }
    func addBookmarkPinGesture(){
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(mapViewLongPressed(_:)))
        gestureRecognizer.minimumPressDuration = 1
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    func refreshExistingBookmarkPins(){
        self.mapView.removeAnnotations(self.mapView.annotations)
        for bookmarkModel in ForecastUserDefaults.Bookmarks{
            if let strLatitude = bookmarkModel.latitude, let strLongitude = bookmarkModel.longitude{
                if let latitude = Double(strLatitude), let longitude = Double(strLongitude){
                    let annotation = BookmarkAnnotation(id: bookmarkModel.id, model: bookmarkModel)
                    annotation.coordinate = CLLocationCoordinate2D(latitude: latitude , longitude: longitude)
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    func fitBookmarkPins(){
        Utils.delay(0.5) {
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
            self.setMapRegion(self.mapView.region.center,span: self.mapView.region.span)
        }
    }
    func getForecastAndShow(coordinate:CLLocationCoordinate2D, title:String="", removeButtonIsHidden:Bool = false, completion:((WeatherModel)->())? = nil){
        provider.getTodaysForecast(latitude: coordinate.latitude, longitute: coordinate.longitude) { (weather, error) in
            if let weather = weather {
                if let _ = weather.id, let _ = weather.name{
                    DispatchQueue.main.async {
                        self.showWeatherDetail(weather: weather, coordinate: coordinate,title: title,removeButtonIsHidden:  removeButtonIsHidden)
                        self.setMapRegion(coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                        if let completion = completion{
                            completion(weather)
                        }
                    }
                }
            }
        }
    }
    func showWeatherDetail(weather: WeatherModel, coordinate:CLLocationCoordinate2D, title:String = "", removeButtonIsHidden:Bool = false){
        self.partialViewHeight = 200
        let cityViewController = self.storyboard?.instantiateViewController(withIdentifier: "CityViewController") as! CityViewController
        cityViewController.weather = weather
        cityViewController.coordinate = coordinate
        cityViewController.delegate = self
        cityViewController.removeButtonIsHidden = removeButtonIsHidden
        cityViewController.cityTitle = title
        self.showBottomView(viewController: cityViewController)
    }
    
    // MARK: Map Action
    @objc func mapViewLongPressed(_ recognizer : UIGestureRecognizer){
        if recognizer.state != .began { return }
        let touchPoint = recognizer.location(in: mapView)
        let mapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        self.getForecastAndShow(coordinate: mapCoordinate) { (weatherModel) in
            if let id = weatherModel.id, let name = weatherModel.name{
                let bookmarkModel = BookmarkModel(id:id,latitude: "\(mapCoordinate.latitude)", longitude: "\(mapCoordinate.longitude)", name: name)
                ForecastUserDefaults.addBookmark(bookmarkModel)
                let annotation = BookmarkAnnotation(id: 1, model: bookmarkModel)
                annotation.coordinate = mapCoordinate
                DispatchQueue.main.async {
                    self.mapView.addAnnotation(annotation)
                }
            }else{
                self.showError(title: Strings.ErrorTitle, message: Strings.ErrorOccured, handler: nil)
            }
        }
        if #available(iOS 10.0, *) {
            let feedback = UIImpactFeedbackGenerator() // haptic
            feedback.impactOccurred()
        }
    }
    
    // MARK: IBActions
    func showBottomView(viewController:UIViewController){
        viewController.modalPresentationStyle = UIModalPresentationStyle.custom
        viewController.transitioningDelegate = self
        self.present(viewController, animated: true, completion: nil)
    }
    @IBAction func btnShowBookmarks(_ sender: UIButton) {
        fitBookmarkPins()
        self.partialViewHeight = UIScreen.main.bounds.height / 2
        DispatchQueue.main.async { //Fit pins and open viewcontroller sametime
            let bookmarksViewController = self.storyboard?.instantiateViewController(withIdentifier: "BookmarksViewController") as! BookmarksViewController
            bookmarksViewController.delegate = self
            self.showBottomView(viewController: bookmarksViewController)
        }
    }
    @IBAction func btnShowKnownPlaces(_ sender: UIButton) {
        self.partialViewHeight = 180
        let knownLocationViewController = self.storyboard?.instantiateViewController(withIdentifier: "KnownLocationViewController") as! KnownLocationViewController
        knownLocationViewController.delegate = self
        self.showBottomView(viewController: knownLocationViewController)
    }
    @IBAction func btnShowSettings(_ sender: UIButton) {
        self.partialViewHeight = 180
        let settingsViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.showBottomView(viewController: settingsViewController)
    }
    @IBAction func btnShowHelp(_ sender: UIButton) {
        self.partialViewHeight = UIScreen.main.bounds.height * 0.75
        let helpViewController = self.storyboard?.instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
        self.showBottomView(viewController: helpViewController)
    }
}

