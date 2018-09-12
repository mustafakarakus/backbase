//
//  ViewController+Extensions.swift
//  Backbase Forecast
//
//  Created by Admin on 12.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//
import UIKit
import MapKit

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
        self.setMapRegion(view.annotation!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        if #available(iOS 10.0, *) {
            let feedback = UIImpactFeedbackGenerator() // haptic
            feedback.impactOccurred()
        }
        if let annotation = view.annotation as? BookmarkAnnotation{
            getForecastAndShow(coordinate: annotation.coordinate)
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
        self.getForecastAndShow(coordinate: location.coordinate!,title: location.name!, removeButtonIsHidden:true)
    }
}  
