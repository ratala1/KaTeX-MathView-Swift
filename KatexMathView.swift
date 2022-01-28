//
//  KatexMathView.swift
//
//  Created by rajeswari on 5/7/19.
//  Copyright © 2019 Rajeswari Ratala. All rights reserved.
//

import UIKit
import WebKit

public class KatexMathView: WKWebView {
    public var onLoaded: (CGFloat)-> Void = { _ in }

    func loadLatex(_ content: String ) {
#if SPM_PACKAGE
        guard let path = Bundle.module.url(forResource: "katex/index", withExtension: "html")?.path else {
            fatalError()
        }
#else
        guard let path = Bundle.main.path(forResource: "katex/index", ofType: "html") else {
            fatalError()
        }
#endif
        self.configuration.preferences.javaScriptEnabled = true
        self.navigationDelegate = self

        self.isOpaque = false
        self.backgroundColor = UIColor.clear
        self.scrollView.backgroundColor = UIColor.clear

        let htmlContent = getHtml(content, path)

        self.loadHTMLString(htmlContent, baseURL: URL(fileURLWithPath: path))
    }

    func getHtml(_ htmlContent: String, _ path: String) -> String {

        var htmlString = try! String(contentsOfFile: path, encoding: .utf8)

        var content = htmlContent
        let delimitter = "$"
        let startTexTag = "<span class=\"tex\">"
        let endTexTag = "</span>"

        var first = true

        while content.contains(delimitter) {
            let tag: String = first ? startTexTag : endTexTag
            if let range =  content.range(of: delimitter) {
                content = content.replacingOccurrences(of: delimitter, with: tag, options: NSString.CompareOptions.literal, range: range)
            }
            first = !first
        }
        htmlString = htmlString.replacingOccurrences(of: "$LATEX$", with: content)
        return htmlString
    }



}

extension KatexMathView : WKNavigationDelegate {

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
            if complete != nil {
                self.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
                    self.frame.size.height = height as! CGFloat
                    self.layoutIfNeeded()
                    self.onLoaded(self.frame.size.height)
                })
            }

        })
    }

}
