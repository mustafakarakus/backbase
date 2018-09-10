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
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var data = [BookmarkModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationSettings()
        addBookmarkPinGesture()
    }
    
    // MARK: Settings
    func locationSettings(){
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    func addBookmarkPinGesture(){
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(mapViewLongPressed(_:)))
        gestureRecognizer.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    // MARK: Map Action
    @objc func mapViewLongPressed(_ recognizer : UIGestureRecognizer){
        if recognizer.state != .began { return }
        let touchPoint = recognizer.location(in: mapView)
        let mapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let provider = ForecastProvider()
        provider.getTodaysForecast(latitude: mapCoordinate.latitude, longitute: mapCoordinate.longitude) { (result, error) in
            if let forecastData = result{
                let bookmarkModel = BookmarkModel(latitude: "\(mapCoordinate.latitude)", longitude: "\(mapCoordinate.longitude)", name: forecastData.name)
                ForecastUserDefaults.addBookmark(bookmarkModel)
                let annotation = BookmarkAnnotation(id: 1, model: bookmarkModel)
                annotation.coordinate = mapCoordinate
                self.mapView.addAnnotation(annotation)
            }else{
                self.showError(title: Strings.ErrorTitle, message: Strings.ErrorOccured, handler: nil)
            }
        }
        
        if #available(iOS 10.0, *) {
            let feedback = UIImpactFeedbackGenerator() // haptic
            feedback.impactOccurred()
        } else {
        }
    }
    
    // MARK: IBActions
    @IBAction func btnShowBookmarks(_ sender: UIButton) {
        let bookmarksViewController = self.storyboard?.instantiateViewController(withIdentifier: "BookmarksViewController") as! BookmarksViewController
        bookmarksViewController.modalPresentationStyle = UIModalPresentationStyle.custom
        bookmarksViewController.transitioningDelegate = self
        self.present(bookmarksViewController, animated: true, completion: nil)
    }
    @IBAction func btnShowKnownPlaces(_ sender: UIButton) {
        
    }
    @IBAction func btnShowSettings(_ sender: UIButton) {
        
    }
    @IBAction func btnShowHelp(_ sender: UIButton) {
    }
}
extension ViewController:UIViewControllerTransitioningDelegate{ 
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PartialViewController(presentedViewController: presented, presentingViewController: presenting,size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height / 2))
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
        
    }
}
extension ViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
}
