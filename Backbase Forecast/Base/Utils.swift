//
//  Utils.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import UIKit
class PartialViewController : UIPresentationController {
    var partialViewSize:CGSize!
    init(presentedViewController: UIViewController, presentingViewController: UIViewController?, size:CGSize) {
        partialViewSize = size
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    override var frameOfPresentedViewInContainerView: CGRect{ 
        return CGRect(x: 0, y: UIScreen.main.bounds.height - partialViewSize.height, width: partialViewSize.width, height: partialViewSize.height)
    }
}

class Utils{
    static func delay(_ delay:Double,closure:@escaping ()->()){
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
}
