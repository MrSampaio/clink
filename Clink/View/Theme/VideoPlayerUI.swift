//
//  GifImage.swift
//  Clink
//
//  Created by Julio Sampaio on 28/07/26.
//

import Foundation
import SwiftUI
import WebKit

struct GIFImage: UIViewRepresentable {
    let name: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false

        if let path = Bundle.main.path(forResource: name, ofType: "gif") {
            let url = URL(fileURLWithPath: path)
            let data = try? Data(contentsOf: url)
            webView.load(
                data!,
                mimeType: "image/gif",
                characterEncodingName: "UTF-8",
                baseURL: url.deletingPathExtension()
            )
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
