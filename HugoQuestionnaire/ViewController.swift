//
//  ViewController.swift
//  FestivApp
//
//  Created by Eugene Braginets on 20/11/2016.
//  Copyright © 2016 Eugene Braginets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.allowsInlineMediaPlayback = true
        self.webView.isUserInteractionEnabled = true
        self.webView.scrollView.isScrollEnabled = true
        self.webView.scalesPageToFit = true
        self.registerSettingsBundle()
        self.updateDisplayFromDefaults()
        NotificationCenter.default.addObserver(self,
                                                         selector: Selector("defaultsChanged"),
                                                         name: UserDefaults.didChangeNotification,
                                                         object: nil)
    }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func defaultsChanged(){
        self.updateDisplayFromDefaults()
    }
    
    func updateDisplayFromDefaults(){
        //Get the defaults
        let defaults = UserDefaults.standard
        
        //Set the controls to the default values.
        if let url = defaults.string(forKey: "qre_url"){
            let url = URL(string: url)
            let request = URLRequest(url: url!)
            self.webView.loadRequest(request)
        }
    }
    
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UIWebViewDelegate {
    
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    

    func webViewDidStartLoad(_ webView: UIWebView) {
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
     }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
    }


}

