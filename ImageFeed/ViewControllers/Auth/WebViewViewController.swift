//
//  WebViewViewControlle.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 18.12.2023.
//

import UIKit
import WebKit

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ viewController: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ viewController: WebViewViewController)
}

public protocol WebViewViewControllerProtocol: AnyObject {
    var presenter: WebViewPresenterProtocol? { get set }
    func load(request: URLRequest)
    func setProgressValue(_ newValue: Float)
    func setProgressHidden(_ flag: Bool)
}

final class WebViewViewController: UIViewController {
    
    private var estimatedProgressObservation: NSKeyValueObservation?
    
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var progressView: UIProgressView!
    
    weak var delegate: WebViewViewControllerDelegate?
    var presenter: WebViewPresenterProtocol?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.accessibilityIdentifier = "UnsplashWebView"
        setupProgress()
        setupWebViewObserve()
        presenter?.viewDidLoad()
    }
    
    @IBAction private func didTapBackButton(_ sender: Any?) {
        delegate?.webViewViewControllerDidCancel(self)
    }
}

private extension WebViewViewController {
    
    func setupWebViewObserve() {
        estimatedProgressObservation = webView.observe(\.estimatedProgress, options: []) {
            [weak self ] _, _ in
            guard let self else { return }
            self.presenter?.didUpdateProgressValue(webView.estimatedProgress)
        }
    }
    
    func code(from navigationAction: WKNavigationAction) -> String? {
        if
            let url = navigationAction.request.url {
            return presenter?.code(from: url)
        } else {
            return nil
        }
    }
    
    func setupProgress() {
        progressView.progressTintColor = .ypBlack
        progressView.trackTintColor = .ypGray
        progressView.progressViewStyle = .bar
        progressView.setProgress(0, animated: true)
    }
}

extension WebViewViewController: WebViewViewControllerProtocol {
    func load(request: URLRequest) {
        webView.load(request)
    }
    
    func setProgressValue(_ newValue: Float) {
        progressView.setProgress(newValue, animated: true)
    }
    
    func setProgressHidden(_ flag: Bool) {
        progressView.isHidden = flag
    }
}

extension WebViewViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let code = code(from: navigationAction) {
            delegate?.webViewViewController(self, didAuthenticateWithCode: code)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}

