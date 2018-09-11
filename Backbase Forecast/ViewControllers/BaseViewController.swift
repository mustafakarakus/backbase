//
//  BaseViewController.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad() 
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: Messages
    func showError(title:String, message:String,handler: (((UIAlertAction) -> Swift.Void)?)){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Okay", style: .default, handler: handler)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    func showConfirm(title:String, message:String,handler: (((UIAlertAction) -> Swift.Void)?)){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let actionYes = UIAlertAction(title: "Yes", style: .destructive, handler: handler)
        let actionNo = UIAlertAction(title: "No", style: .default)
        alert.addAction(actionYes)
        alert.addAction(actionNo)
        self.present(alert, animated: true, completion: nil)
    }

}
