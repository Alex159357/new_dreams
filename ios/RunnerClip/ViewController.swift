//
//  ViewController.swift
//  RunnerClip
//
//  Created by OK on 04.05.2022.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let request = URLRequest(url: URL(string:"https://savyonview.dreams.bmby.com/?appclip=1")!)
        webView.load(request)
    }
}

