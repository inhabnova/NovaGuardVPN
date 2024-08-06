import UIKit
import ALProgressView

final class SpeedTestViewController: UIViewController {

    // MARK: - UI Elements
    private let backgroundImageView = UIImageView(image: I.SpeedTest.backgroundSpeedTest)
    private let titleLabel = TitleLabel(whiteText: SpeedTestLocalization.speed.localized + " ", greenText: SpeedTestLocalization.test.localized)
    
    private lazy var topView = SpeetTestTopView(ip: "presenter.selectedServer.hostname", network: "presenter.selectedServer.hostname", location: "presenter.selectedServer.location")
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
    
    var progress: Float = 0.7
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setupConstraints()
        
        progressView.setProgress(progress, animated: true)
    }
}

// MARK: - SpeedTestView

extension SpeedTestViewController: SpeedTestView {
    func updateView(state: SpeedTestState) {
        switch state {
        case .notTest:
            label1.text = "00.00"
            progressView.setProgress(0.0, animated: false)
            button = GreenButton(title: SpeedTestLocalization.button.localized)
        case .inProgress(let download, let upload):
            button.setGrayBackground(title: SpeedTestLocalization.buttonStop.localized)
            label1.text = "20.00"
            speedTestCenterView.update(download: 30)
            speedTestCenterView.update(upload: 20)
            progressView.setProgress(0.5, animated: true)
        case .finishTest(let download, let upload):
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
