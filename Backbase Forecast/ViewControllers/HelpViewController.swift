//
//  HelpViewController.swift
//  Backbase Forecast
//
//  Created by Admin on 11.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var webView: UIWebView! //we can't use webkitWebView, because we want to support iOS8+
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webView.loadRequest(URLRequest(url: URL(string: Keys.HelpUrl)!))
    }
    
    @IBAction func btnDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension HelpViewController : UIWebViewDelegate{
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let script = String(format: "window.scrollBy(0,%d)",100)
        webView.stringByEvaluatingJavaScript(from: script)
    }
}
