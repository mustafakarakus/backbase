//
//  ViewController.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var data = [BookmarkModel]() 
    override func viewDidLoad() {
        super.viewDidLoad()
        addBookmarkPinGesture()
    }
    func addBookmarkPinGesture(){
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(mapViewLongPressed(_:)))
        gestureRecognizer.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    @objc func mapViewLongPressed(_ recognizer : UIGestureRecognizer){
        if recognizer.state != .began { return }
        let touchPoint = recognizer.location(in: mapView)
        let mapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = BookmarkAnnotation(id: 1, model: BookmarkModel())
        annotation.coordinate = mapCoordinate
        mapView.addAnnotation(annotation)
    }
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
