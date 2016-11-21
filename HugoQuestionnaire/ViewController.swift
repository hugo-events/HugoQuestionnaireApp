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
    var request: URLRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.allowsInlineMediaPlayback = true
        self.webView.isUserInteractionEnabled = true
        self.webView.scrollView.isScrollEnabled = true
        self.webView.scalesPageToFit = true
        self.registerSettingsBundle()
        self.updateDisplayFromDefaults()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
//    }
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
            self.request = URLRequest(url: url!, timeoutInterval: 0.5)
            self.webView.loadRequest(self.request!)
        }
    }
    
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
        UserDefaults.standard.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        self.webView = webView
        if self.request!.url?.absoluteString == request.url?.absoluteString{
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval.init(floatLiteral: 10.0), target: self, selector: #selector(ViewController.checkStatus), userInfo: nil, repeats: true)
        }
        return true
    }
    

    func webViewDidStartLoad(_ webView: UIWebView) {
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        return;
     }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
    }
    
    func checkStatus() {
        print ("checking status")
        self.timer?.invalidate()
        let js = "DATA != undefined && document.getElementById('waitAnim') == undefined"
        let result = self.webView.stringByEvaluatingJavaScript(from: js)
        if result != "true" {
            print("reloading due to an error")
            self.webView.loadRequest(self.request!)
        } else {
            print("loaded ok")
        }
    }

}

