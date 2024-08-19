import Foundation
import WebKit

protocol SpeedTestView: AnyObject {
    var webView: WKWebView! { get set }
    func updateView(state: SpeedTestState)
}

