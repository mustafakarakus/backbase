//
//  Extensions.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow(offset: CGFloat, radius:CGFloat = 10){
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.cornerRadius = radius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: offset)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 5
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
extension UITableView{
    func emptyMessage(_ message: String) {
        let padding:CGFloat = 10
        let lblEmptyMessage = UILabel(frame: CGRect(x: padding, y: 0, width: self.bounds.size.width-padding, height: self.bounds.size.height))
        lblEmptyMessage.text = message
        lblEmptyMessage.font = UIFont(name: "Helvetica Neue Light", size: 15)
        lblEmptyMessage.textColor = .gray
        lblEmptyMessage.numberOfLines = 0;
        lblEmptyMessage.textAlignment = .center;
        lblEmptyMessage.sizeToFit()
        self.backgroundView = lblEmptyMessage;
        self.separatorStyle = .none;
    }
    func removeEmptyMessage() {
        self.separatorStyle = .singleLine
        self.backgroundView = nil
    }
}
