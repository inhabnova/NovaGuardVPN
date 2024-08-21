import Foundation
import NetworkExtension
enum SpeedTestState {
    case notTest
    case inProgress//(download: String, upload: String)
    case finishTest(download: String, upload: String)
}

protocol SpeedTestPresenter {
    var view: SpeedTestView! { get set }
    var coordinator: SpeedTestCoordinator! { get set }
    
    var selectedServer: Server? { get set }
//    var state: SpeedTestState { get set }
    
/// функция, чтобы обработать ошибку при попытке запуска теста, который срабатывает при загрузке "нашего сайта" после завершения теста
    func handleError(url: URL?)
    func showMain()
    func showSettings()
    func buttonAction()
    func getServerInfo() -> [String]
}

final class SpeedTestPresenterImpl {
    
    // MARK: - Public Properties
    
    weak var view: SpeedTestView!
    weak var coordinator: SpeedTestCoordinator!
    
    var selectedServer: Server? = UserDefaultsService.shared.getCurrentServer()
    
    private var state: SpeedTestState = .notTest
    private var vpnService = VPNService.shared
    private var vpnIsOn: Bool = false
    
    init() {
        vpnService.delegate = self
    }
}

// MARK: - SpeedTestPresenter

extension SpeedTestPresenterImpl: SpeedTestPresenter {
    
    func getServerInfo() -> [String] {
        if vpnIsOn {
            return [selectedServer?.ip ?? "-", selectedServer?.ip ?? "-", selectedServer?.name ?? "-"]
        } else {
            return ["-","-","-"]
        }
    }

    func showMain() {
        coordinator.showMain()
    }
    
    func showSettings() {
        coordinator.showSettings()
    }
    
    func buttonAction() {
        switch self.state {
        case .notTest:
            state = .inProgress
            view.updateView(state: state)
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                self.checkIsFinalTest()
            }
        case .inProgress:
            self.view.webView.removeFromSuperview()
            view.webView = nil
            self.state = .notTest
            view.updateView(state: state)
        case .finishTest(download: _, upload: _):
            state = .inProgress
            view.updateView(state: state)
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.checkIsFinalTest()
            }
        }
    }
    
    func handleError(url: URL?) {
        guard let url = self.view.webView?.url else { return }
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems
        if let download = queryItems?.first( where: { $0.name == "download_speed" } )?.value,
           let upload = queryItems?.first( where: { $0.name == "upload_speed" } )?.value {
            
            self.state = .finishTest(download: download, upload: upload)
            self.view.webView.removeFromSuperview()
            self.view.webView = nil
            view.updateView(state: state)
            return
        } else {
            self.state = .inProgress
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.checkIsFinalTest()
            }
        }
    }
    
    private func checkIsFinalTest() {
        let jsCode = """
            var showMore = document.getElementById('show-more-details-link');
            if (showMore) showMore.click();
            var downloadElement = document.getElementById('speed-value');
            var downloadSpeed = downloadElement.innerText;
            if (downloadSpeed > 0 && !isSucceeded(downloadElement)) {
                window.webkit.messageHandlers.currentDownload.postMessage({downloadSpeed});
            }
            var uploadElement = document.getElementById('upload-value');
            var uploadSpeed = uploadElement.innerText;
            if (uploadSpeed > 0 && !isSucceeded(uploadElement)) {
                window.webkit.messageHandlers.currentUpload.postMessage({uploadSpeed});
            }
            if (isSucceeded(downloadElement) && isSucceeded(uploadElement)) {
                window.webkit.messageHandlers.testCompleted.postMessage({downloadSpeed, uploadSpeed});
            }

            function isSucceeded(element)
            {
                return element.classList.contains('succeeded');
            }
            """
        view.webView?.evaluateJavaScript(jsCode) { (result, error) in
            if let error = error {
                print("Ошибка при выполнении JavaScript: \(error)")
                self.handleError(url: self.view.webView?.url)
            } else {
                print("JS: redirect")
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    self.checkIsFinalTest()
                }
            }
        }
    }
}

// MARK: - VPNServiceDelegate

extension SpeedTestPresenterImpl: VPNServiceDelegate {
    
    func didObserveVPNStatus(status: NEVPNStatus) {
        switch status {
        case .connected:
            vpnIsOn = true
        default:
            vpnIsOn = false
        }
    }
    
    func didGetError(error: (any Error)?) {
        vpnIsOn = false
        print("speedDidGetError: " + "\(error)")
    }
}
