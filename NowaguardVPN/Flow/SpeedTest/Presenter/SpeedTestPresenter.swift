import Foundation
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
}

final class SpeedTestPresenterImpl {
    
    // MARK: - Public Properties
    
    weak var view: SpeedTestView!
    weak var coordinator: SpeedTestCoordinator!
    
    var selectedServer: Server? = UserDefaultsService.shared.getCurrentServer()
    
    private var state: SpeedTestState = .notTest
    
    deinit {
        
    }
}

// MARK: - SpeedTestPresenter

extension SpeedTestPresenterImpl: SpeedTestPresenter {

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
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
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
            var resultsDiv = document.getElementsByClassName('result-container-data')[0];
            if (resultsDiv) {
                var downloadSpeed = resultsDiv.getElementsByClassName('result-data-value download-speed')[0].innerText;
                var uploadSpeed = resultsDiv.getElementsByClassName('result-data-value upload-speed')[0].innerText;
                if (downloadSpeed > -1 && uploadSpeed > -1) {
                    window.location.replace("https://inhabitrlimited.digital/api/vpn/results.php?download_speed=" + downloadSpeed + "&upload_speed=" + uploadSpeed);
                }
            }
            """
        view.webView?.evaluateJavaScript(jsCode) { (result, error) in
            if let error = error {
                print("Ошибка при выполнении JavaScript: \(error)")
                self.handleError(url: self.view.webView?.url)
            } else {
                guard let url = self.view.webView.url else { return }
                let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                let queryItems = components?.queryItems
                if let download = queryItems?.first( where: { $0.name == "download_speed" } )?.value,
                   let upload = queryItems?.first( where: { $0.name == "upload_speed" } )?.value {
                    
                    self.state = .finishTest(download: download, upload: upload)
                    self.view.updateView(state: self.state)
                    self.view.webView.removeFromSuperview()
                    self.view.webView = nil
                    return
                } else {
                    self.state = .inProgress
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                        self.checkIsFinalTest()
                    }
                }
                print("JS: redirect")
            }
        }
    }
}

