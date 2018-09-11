//
//  KnownLocationViewController.swift
//  Backbase Forecast
//
//  Created by Admin on 11.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import UIKit
import CoreLocation

protocol KnownLocationDelegate {
    func didSelectKnownLocation(_ location:KnownLocationModel)
}
class KnownLocationViewController: BaseViewController {
    
    var locations = [KnownLocationModel]()
    let provider = KnownLocationProvider()
    var delegate:KnownLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISettings()
        provider.getKnownLocations { (locations, error) in
            self.locations = locations
        }
    }
    func UISettings(){
        self.view.dropShadow(offset: -5)
    }
    @IBAction func btnDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension KnownLocationViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! KnownLocationCollectionViewCell
        let location = locations[indexPath.row]
        cell.imgLocation.image = UIImage(named: location.imageName!)
        cell.lblName.text = location.name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        self.delegate?.didSelectKnownLocation(location)
        self.dismiss(animated: true, completion: nil)
    }
}
