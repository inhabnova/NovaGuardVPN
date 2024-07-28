import UIKit

final class SettingsViewController: UIViewController {

    // MARK: - UI Elements
    private let backgroundImageView = UIImageView(image: I.Settings.backgroundSettings)
    private let titleLabel = TitleLabel(whiteText: SettingsLocalization.app.localized + " ", greenText: SettingsLocalization.settings.localized)
    
    private let openSpeedTestButton = UIButton()
    private let openMainButton = UIButton()

    // MARK: - Public Properties
    
    var presenter: SettingsPresenter!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setupConstraints()
    }
}

// MARK: - SettingsView

extension SettingsViewController: SettingsView {

}

// MARK: - Layout Setup

private extension SettingsViewController {
    func layoutSetup() {
        view.addSubviews([backgroundImageView, titleLabel, openSpeedTestButton, openMainButton])
        
        openSpeedTestButton.addTarget(self, action: #selector(openSpeedTest), for: .touchUpInside)
        openMainButton.addTarget(self, action: #selector(openMain), for: .touchUpInside)
    }
}

// MARK: - Actions

private extension SettingsViewController {
    
    @objc func openSpeedTest() {
        presenter.showSpeedTest()
    }
    
    @objc func openMain() {
        presenter.showMain()
    }
}

// MARK: - Setup Constraints

private extension SettingsViewController {
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        
        openSpeedTestButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.frame.width / 3)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            $0.height.equalTo(view.frame.height / 15)
        }
        openMainButton.snp.makeConstraints {
            $0.width.height.centerY.equalTo(openSpeedTestButton)
            $0.left.equalToSuperview()
        }
    }
}


