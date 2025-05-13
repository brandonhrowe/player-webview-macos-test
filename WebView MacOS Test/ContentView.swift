//
//  ContentView.swift
//  WebView MacOS Test
//
//  Created by Brandon Rowe on 1/22/25.
//

import SwiftUI
import WebKit

typealias WebViewRepresentable = NSViewRepresentable

public struct WebView: WebViewRepresentable {
    public init(url: URL) {
        self.url = url
        self.configuration = { _ in }
    }

    public init(
        url: URL? = nil,
        configuration: @escaping (WKWebView) -> Void = { _ in }) {
        self.url = url
        self.configuration = configuration
    }

    private let url: URL?
    private let configuration: (WKWebView) -> Void
    
    public func makeNSView(context: Context) -> WKWebView {
        makeView()
    }

    public func updateNSView(_ view: WKWebView, context: Context) {}
}

private extension WebView {
    
    func makeView() -> WKWebView {
        let view = WKWebView()
        configuration(view)
        tryLoad(url, into: view)
        return view
    }

    func tryLoad(_ url: URL?, into view: WKWebView) {
        guard let url = url else { return }
        view.load(URLRequest(url: url))
    }
}

struct ContentView: View {
    func signIn() {
        print("Signing in...")
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button(action: signIn) {
                Text("Sign in")
            }
            Text("Hello, world!")
        }
        .padding()
        WebView(url: URL(string: "https://player.vimeo.com/video/691922309")!)
            .padding()
            .frame(width: nil)
            
    }
}

#Preview {
    ContentView()
}
