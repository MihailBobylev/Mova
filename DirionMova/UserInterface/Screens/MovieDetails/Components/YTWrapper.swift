//
//  YTWrapper.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/25/22.
//

import SwiftUI
import WebKit

struct YTWrapper: UIViewRepresentable {
    var videoID: String?
    let webView = WKWebView()
    
    func makeUIView(context: Context) -> WKWebView {
        guard let key = videoID else { return WKWebView() }
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(key)") else { return WKWebView() }
        webView.load(URLRequest(url: youtubeURL))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
