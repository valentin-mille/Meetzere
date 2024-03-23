//
//  WebView.swift
//  SharedViews
//
//  Created by Valentin Mille on 2/26/23.
//

import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {

    let URLString: String

    public init(URLString: String) {
        self.URLString = URLString
    }

    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.uiDelegate = nil
        webView.allowsLinkPreview = true
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }

    public func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let URL = URL(string: URLString) else { return }
        let request = URLRequest(url: URL)
        uiView.load(request)
    }

}

#Preview {
    WebView(URLString: "https://www.apple.com")
}
