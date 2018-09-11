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
            provider.getTodaysForecast(latitude: userLocation.coordinate.latitude, longitute: userLocation.coordinate.longitude) { (weather, error) in
                if let weather = weather{
                    if let _ = weather.id, let _ = weather.name{
                        DispatchQueue.main.async {
                            self.showWeatherDetail(weather: weather, coordinate: userLocation.coordinate, removeButtonIsHidden: true)
                            let newRegion = MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                            self.mapView.setRegion(newRegion, animated: true)
                        }
                    }
                }
            }
        }
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
            let newRegion = MKCoordinateRegionMake(self.mapView.region.center, self.mapView.region.span)
            self.mapView.setRegion(newRegion, animated: true)
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
        cityViewController.modalPresentationStyle = UIModalPresentationStyle.custom
        cityViewController.transitioningDelegate = self
        self.present(cityViewController, animated: true, completion: nil)
    }
    
    // MARK: Map Action
    @objc func mapViewLongPressed(_ recognizer : UIGestureRecognizer){
        if recognizer.state != .began { return }
        let touchPoint = recognizer.location(in: mapView)
        let mapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        provider.getTodaysForecast(latitude: mapCoordinate.latitude, longitute: mapCoordinate.longitude) { (result, error) in
            if let forecastData = result{
                if let id = forecastData.id, let name = forecastData.name{
                    let bookmarkModel = BookmarkModel(id:id,latitude: "\(mapCoordinate.latitude)", longitude: "\(mapCoordinate.longitude)", name: name)
                    ForecastUserDefaults.addBookmark(bookmarkModel)
                    let annotation = BookmarkAnnotation(id: 1, model: bookmarkModel)
                    annotation.coordinate = mapCoordinate
                    DispatchQueue.main.async {
                        self.mapView.addAnnotation(annotation)
                        self.mapView.selectAnnotation(annotation, animated: true)
                    }
                }else{
                    self.showError(title: Strings.ErrorTitle, message: Strings.ErrorOccured, handler: nil)
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
    @IBAction func btnShowBookmarks(_ sender: UIButton) {
        fitBookmarkPins()
        self.partialViewHeight = UIScreen.main.bounds.height / 2
        DispatchQueue.main.async { //Fit pins and open viewcontroller sametime
            let bookmarksViewController = self.storyboard?.instantiateViewController(withIdentifier: "BookmarksViewController") as! BookmarksViewController
            bookmarksViewController.delegate = self
            bookmarksViewController.modalPresentationStyle = UIModalPresentationStyle.custom
            bookmarksViewController.transitioningDelegate = self
            self.present(bookmarksViewController, animated: true, completion: nil)
        }
    }
    @IBAction func btnShowKnownPlaces(_ sender: UIButton) {
        self.partialViewHeight = 180
        let KnownLocationViewController = self.storyboard?.instantiateViewController(withIdentifier: "KnownLocationViewController") as! KnownLocationViewController
        KnownLocationViewController.modalPresentationStyle = UIModalPresentationStyle.custom
        KnownLocationViewController.transitioningDelegate = self
        KnownLocationViewController.delegate = self
        self.present(KnownLocationViewController, animated: true, completion: nil)
    }
    @IBAction func btnShowSettings(_ sender: UIButton) {
        self.partialViewHeight = 180
        let settingsViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        settingsViewController.modalPresentationStyle = UIModalPresentationStyle.custom
        settingsViewController.transitioningDelegate = self
        self.present(settingsViewController, animated: true, completion: nil)
    }
    @IBAction func btnShowHelp(_ sender: UIButton) {
        self.partialViewHeight = UIScreen.main.bounds.height * 0.75
        let helpViewController = self.storyboard?.instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
        helpViewController.modalPresentationStyle = UIModalPresentationStyle.custom
        helpViewController.transitioningDelegate = self
        self.present(helpViewController, animated: true, completion: nil)
    }
}
extension ViewController:UIViewControllerTransitioningDelegate{ 
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PartialViewController(presentedViewController: presented, presentingViewController: presenting,size: CGSize(width: self.view.frame.size.width, height: partialViewHeight))
    }
}
 
extension ViewController : MKMapViewDelegate{
    // MARK: Mapview Delegates
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        let identifier = "BookmarkPin"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        if let annotationView = annotationView {
            annotationView.image = UIImage(named: "pin")
            annotationView.centerOffset = CGPoint(x:0, y: -annotationView.frame.size.height)
        }
        return annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let newRegion = MKCoordinateRegionMake(view.annotation!.coordinate, span)
        self.mapView.setRegion(newRegion, animated: true)
        if #available(iOS 10.0, *) {
            let feedback = UIImpactFeedbackGenerator() // haptic
            feedback.impactOccurred()
        }
        if let annotation = view.annotation as? BookmarkAnnotation{
            provider.getTodaysForecast(latitude: annotation.coordinate.latitude, longitute: annotation.coordinate.longitude) { (weather, error) in
                if let weather = weather{
                    if let _ = weather.id, let _ = weather.name{
                        DispatchQueue.main.async { 
                            self.showWeatherDetail(weather: weather, coordinate: annotation.coordinate)
                        }
                    }
                }
            }
        }
    }
    
}
extension ViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
}
extension ViewController:BookmarkDelegate{
    func didSelectBookmark(_ bookmark: BookmarkModel) { 
        if let selectedAnnotation = self.mapView.annotations.first(where: { ($0 as? BookmarkAnnotation)?.id == bookmark.id }){
            Utils.delay(0.5, closure: {
                self.mapView.selectAnnotation(selectedAnnotation, animated: true)
            })
        }
    }
}
extension ViewController:CityViewControllerDelegate{
    func didDismissed() {
        self.fitBookmarkPins()
    }
    func didBookmarkRemoved(_ weatherId: Int) {
        self.refreshExistingBookmarkPins()
        self.fitBookmarkPins()
    }
}
extension ViewController:KnownLocationDelegate{
    func didSelectKnownLocation(_ location: KnownLocationModel) {
        provider.getTodaysForecast(latitude: location.coordinate!.latitude, longitute: location.coordinate!.longitude) { (weather, error) in
            if let weather = weather{
                if let _ = weather.id, let _ = weather.name{
                    DispatchQueue.main.async {
                        self.showWeatherDetail(weather: weather, coordinate: location.coordinate!, title: location.name! ,removeButtonIsHidden: true)
                        
                        let newRegion = MKCoordinateRegionMake(location.coordinate!, MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                        self.mapView.setRegion(newRegion, animated: true)
                    }
                }
            }
        }
    }
}
