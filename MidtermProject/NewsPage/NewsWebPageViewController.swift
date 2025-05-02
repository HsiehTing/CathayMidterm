//
//  NewWebPageViewCOontroller.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/5/2.
//

import UIKit
import WebKit

class NewsWebPageViewController: UIViewController, WKUIDelegate {

    public var urlString: String?

    private var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWebView() 
        
        guard let string = urlString,
              let url = URL(string: string) else { return }

        let request = URLRequest(url: url)
        webView.load(request)
    }

    private func loadWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
