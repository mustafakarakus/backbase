//
//  SettingsViewController.swift
//  Backbase Forecast
//
//  Created by Admin on 11.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {
    // MARK: IBOutlets
    @IBOutlet weak var segUnits: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISettings()
    }
    
    // MARK: functions
    func UISettings(){
        self.view.dropShadow(offset: -5)
        segUnits.selectedSegmentIndex = ForecastUserDefaults.Unit
    }
    
    // MARK: IBActions
    @IBAction func btnDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onUnitsChanged(_ sender: UISegmentedControl) {
        ForecastUserDefaults.Unit =  WeatherUnit(rawValue: sender.selectedSegmentIndex)!.rawValue
    }
    @IBAction func btnResetBookmarks(_ sender: Any) {
        showConfirm(title: Strings.AreYouSure, message: Strings.ResetBookmarks) { (action) in
            ForecastUserDefaults.Bookmarks = []
        }
    }
    
}
