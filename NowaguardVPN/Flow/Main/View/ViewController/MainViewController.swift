import UIKit

final class MainViewController: UIViewController {

    // MARK: - UI Elements
    
    private let backgroundImageView = UIImageView()
    private let titleLabel = TitleLabel(whiteText: "NovaGuard ", greenText: "VPN")
    private let countryButton = UIButton()
    private let countryButtonRightImage = UIImageView(image: I.Main.countryButtonRightArrow)
    private let label1 = UILabel()
    private let label2 = UILabel()
    private let label3 = UILabel()
    private let label4 = UILabel()
    
    private let onOffVPNButton = UIButton()
    private let openSpeedTestButton = UIButton()
    private let openSettingsButton = UIButton()

    // MARK: - Public Properties
    
    var presenter: MainPresenter!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setupConstraints()
        
        presenter.onViewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        countryButton.layer.cornerRadius = countryButton.frame.height / 2
    }
}

// MARK: - MainView

extension MainViewController: MainView {

    func setupOnVPN(ip: String, coyntry: String) {
        backgroundImageView.image = I.Main.mainBackbroundOn
        
        label1.text = MainLocalization.label1on.localized
        label2.text = MainLocalization.label2.localized + " " + ip + " " + "(\(coyntry))"
        label2.alpha = 1
        label3.text = MainLocalization.label3on.localized
        label4.text = MainLocalization.label4on.localized
        
        label1.textColor = .appGreen
        label3.textColor = .white
        label4.textColor = .appGreen
    }
    
    func setupOffVPN(ip: String, coyntry: String) {
        backgroundImageView.image = I.Main.mainBackbroundOff
        
        label1.text = MainLocalization.label1off.localized
        label2.text = MainLocalization.label2.localized + " " + ip + " " + "(\(coyntry))"
        label2.alpha = 0
        label3.text = MainLocalization.label3off.localized
        label4.text = MainLocalization.label4off.localized
        
        label1.textColor = .white
        label3.textColor = .appGlayLabel
        label4.textColor = .appGlayLabel
        
    }
    
    func updateTimer(value: String) {
        label3.text = MainLocalization.label3on.localized + " " + value
    }
    
}

// MARK: - Layout Setup

private extension MainViewController {
    func layoutSetup() {
        view.addSubviews([backgroundImageView, titleLabel, label1, label2, label3, label4, countryButton, onOffVPNButton, openSpeedTestButton, openSettingsButton])
        
        label1.font = .systemFont(ofSize: .calc(18), weight: .bold)
        label2.font = .systemFont(ofSize: .calc(16), weight: .medium)
        label2.textColor = .appGlayLabel
        label3.font = .systemFont(ofSize: .calc(16), weight: .medium)
        label4.font = .systemFont(ofSize: .calc(18), weight: .bold)
        
        countryButton.setTitle(presenter.selectedServer.name, for: .normal)
        countryButton.setImage(I.getFlug(name: presenter.selectedServer.name), for: .normal)
        countryButton.setTitleColor(.white, for: .normal)
        countryButton.backgroundColor = .appGray
        countryButton.titleLabel?.font = .systemFont(ofSize: .calc(16), weight: .semibold)
        countryButton.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 20)
        
        countryButtonRightImage.contentMode = .scaleAspectFit
        countryButton.addSubview(countryButtonRightImage)
        countryButton.addTarget(self, action: #selector(countryButtonAction), for: .touchUpInside)
        
        onOffVPNButton.addTarget(self, action: #selector(onOffVPN), for: .touchUpInside)
        openSpeedTestButton.addTarget(self, action: #selector(openSpeedTest), for: .touchUpInside)
        openSettingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
    }

}

// MARK: - Actions

private extension MainViewController {
    
    @objc func countryButtonAction() {
        presenter.showSelectCountry()
    }
    
    @objc func onOffVPN() {
        presenter.buttonAction()
    }
    
    @objc func openSpeedTest() {
        presenter.showSpeedTest()
    }
    
    @objc func openSettings() {
        presenter.showSettings()
    }
}

// MARK: - Setup Constraints

private extension MainViewController {
    func setupConstraints() {
    
        backgroundImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        countryButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.3)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(view.frame.height / 13.5)
        }
        
        countryButtonRightImage.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(20)
        }
        
        countryButton.imageView?.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.6)
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
        }
        
        countryButton.titleLabel?.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.6)
            $0.centerY.equalToSuperview()
            if let rightAncor = countryButton.imageView?.snp.right {
                $0.left.equalTo(rightAncor).inset(-40)
            }
        }
        
        label1.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(countryButton.snp.bottom).inset(-30)
        }
        
        label2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(label1.snp.bottom).inset(-15)
        }
        
        label3.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.55)
        }
        
        label4.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(label3.snp.bottom).inset(-15)
        }
        
        onOffVPNButton.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.27)
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.15)
        }
        openSpeedTestButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.frame.width / 3)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            $0.height.equalTo(view.frame.height / 15)
        }
        openSettingsButton.snp.makeConstraints {
            $0.width.height.centerY.equalTo(openSpeedTestButton)
            $0.right.equalToSuperview()
        }
        
    }
}
