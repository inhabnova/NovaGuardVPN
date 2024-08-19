import UIKit
import ALProgressView
import WebKit

final class SpeedTestViewController: UIViewController, WKNavigationDelegate {

    // MARK: - UI Elements
    private let backgroundImageView = UIImageView(image: I.SpeedTest.backgroundSpeedTest)
    private let titleLabel = TitleLabel(whiteText: SpeedTestLocalization.speed.localized + " ", greenText: SpeedTestLocalization.test.localized)
    
    private lazy var topView = SpeetTestTopView(ip: presenter.selectedServer?.ip ?? "-", network: presenter.selectedServer?.ip ?? "-", location: presenter.selectedServer?.name ?? "-")
    private lazy var speedTestCenterView = SpeetTestCenterView()
    
    private let progressView = ALProgressRing()
    private let zeroLabel = UILabel()
    private let fiftyLabel = UILabel()
    private let oneHundredLabel = UILabel()
    
    private let label1 = UILabel()
    private let label2 = UILabel()
    private var button = GreenButton(title: SpeedTestLocalization.button.localized)
    
    private let openMainButton = UIButton()
    private let openSettingsButton = UIButton()
    
    // MARK: - Public Properties
    
    var presenter: SpeedTestPresenter!
    var webView: WKWebView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setupConstraints()
        
        self.progressView.setProgress(0, animated: true)
    }
    
    // Выполнение JavaScript после завершения загрузки страницы
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            let jsCode = """
        var buttonDiv = document.getElementsByClassName('start-button')[0];
        buttonDiv.getElementsByTagName('a')[0].click();
        """
            webView.evaluateJavaScript(jsCode) { (result, error) in
                if let error = error {
                    self.presenter.handleError(url: webView.url)
                    webView.reload()
                    print("Ошибка при выполнении JavaScript: \(error)")
                } else {
                    print("JS: start test")
                }
            }
        }
    }


}

// MARK: - SpeedTestView

extension SpeedTestViewController: SpeedTestView {
    
    func updateView(state: SpeedTestState) {
        switch state {
        case .notTest:
            speedTestCenterView.removeShadow()
            label1.text = "00.00"
            progressView.setProgress(0.0, animated: false)
            button.updateTitle(title: SpeedTestLocalization.button.localized)
        case .inProgress:
            speedTestCenterView.addShadow()
            // Создаем конфигурацию WebView
            let webConfiguration = WKWebViewConfiguration()
            webConfiguration.preferences.javaScriptEnabled = true
            
            // Создаем WebView и добавляем его на экран
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.navigationDelegate = self
            view.addSubview(webView)
            
            // Задаем размеры WebView
            webView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                webView.topAnchor.constraint(equalTo: view.topAnchor),
                webView.heightAnchor.constraint(equalToConstant: 0),
                webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            
            // Загрузка десктопной версии сайта
            let url = URL(string: "https://www.speedtest.net/")!
            let request = URLRequest(url: url)
            self.webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/601.6.17 (KHTML, like Gecko) Version/9.1.1 Safari/601.6.17"
            webView.load(request)
            
            button.setGrayBackground(title: SpeedTestLocalization.buttonStop.localized)
            label1.text = "00.00"
        case .finishTest(let download, let upload):
            speedTestCenterView.addShadow()
            self.label1.text = upload
            speedTestCenterView.update(download: Int(Double(download) ?? 0))
            speedTestCenterView.update(upload: Int(Double(upload) ?? 0))
            if let uploadInt = Int(upload) {
                if uploadInt > 0 {
                    progressView.setProgress(1, animated: true)
                } else {
                    progressView.setProgress(Float(uploadInt) / 100, animated: true)
                }
            }
            button.updateTitle(title: SpeedTestLocalization.buttonAgain.localized)
        }
    }
}

// MARK: - Layout Setup

private extension SpeedTestViewController {
    func layoutSetup() {
        view.addSubviews([backgroundImageView, topView, speedTestCenterView, titleLabel, openMainButton, openSettingsButton, progressView, zeroLabel, fiftyLabel, oneHundredLabel, label1, label2, button])
        
        openMainButton.addTarget(self, action: #selector(openMain), for: .touchUpInside)
        openSettingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)

        progressView.lineWidth = 40
        progressView.duration = 1
        progressView.endColor = .appGreen
        progressView.startColor = .appGreen
        progressView.grooveColor = .appGrayProgress
        progressView.timingFunction = .easeInQuart
        progressView.startAngle = .pi
        progressView.endAngle = 2 * .pi
        
        zeroLabel.text = "0"
        fiftyLabel.text = "50"
        oneHundredLabel.text = "100"
        zeroLabel.textColor = .white
        fiftyLabel.textColor = .white
        oneHundredLabel.textColor = .white
        zeroLabel.font = .systemFont(ofSize: .calc(16), weight: .semibold)
        fiftyLabel.font = .systemFont(ofSize: .calc(16), weight: .semibold)
        oneHundredLabel.font = .systemFont(ofSize: .calc(16), weight: .semibold)
        
        label1.font = .systemFont(ofSize: .calc(48), weight: .bold)
        label2.font = .systemFont(ofSize: .calc(16), weight: .medium)
        label1.textColor = .white
        label2.textColor = .appGlayLabel
        label1.textAlignment = .center
        label2.textAlignment = .center
        label1.text = "00.00"
        label2.text = SpeedTestLocalization.perSec.localized
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
}

// MARK: - Actions

private extension SpeedTestViewController {
    
    @objc func openMain() {
        presenter.showMain()
    }
    
    @objc func openSettings() {
        presenter.showSettings()
    }
    
    @objc func buttonAction() {
        presenter.buttonAction()
    }
}

// MARK: - Setup Constraints

private extension SpeedTestViewController {
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        topView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
        
        speedTestCenterView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(topView.snp.bottom)
            $0.bottom.equalTo(progressView.snp.top).inset(-40)
        }
        
        progressView.snp.makeConstraints {
            $0.bottom.equalTo(button.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalToSuperview().multipliedBy(0.38)
        }
        
        zeroLabel.snp.makeConstraints {
            $0.centerY.equalTo(progressView.snp.centerY).multipliedBy(1.07)
            $0.left.equalToSuperview().inset(32)
        }
        fiftyLabel.snp.makeConstraints {
            $0.centerX.equalTo(progressView.snp.centerX)
            $0.bottom.equalTo(progressView.snp.top).inset(-20)
        }
        oneHundredLabel.snp.makeConstraints {
            $0.centerY.equalTo(progressView.snp.centerY).multipliedBy(1.07)
            $0.right.equalToSuperview().inset(32)
        }
        
        label1.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(label2.snp.top).inset(-10)
        }
        label2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(oneHundredLabel.snp.top)
        }
        
        button.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.bottom.equalTo(openMainButton.snp.top).inset(-10)
            $0.height.equalTo(view.frame.height / 14.5)
        }
        
        openMainButton.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.width.equalTo(view.frame.width / 3)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            $0.height.equalTo(view.frame.height / 15)
        }
        openSettingsButton.snp.makeConstraints {
            $0.width.height.centerY.equalTo(openMainButton)
            $0.right.equalToSuperview()
        }
    }
}
