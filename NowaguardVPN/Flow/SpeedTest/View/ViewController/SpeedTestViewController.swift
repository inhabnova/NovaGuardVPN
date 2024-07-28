import UIKit

final class SpeedTestViewController: UIViewController {

    // MARK: - UI Elements
    private let backgroundImageView = UIImageView(image: I.SpeedTest.backgroundSpeedTest)
    private let titleLabel = TitleLabel(whiteText: SpeedTestLocalization.speed.localized + " ", greenText: SpeedTestLocalization.test.localized)
    
    private let openMainButton = UIButton()
    private let openSettingsButton = UIButton()
    
    // MARK: - Public Properties
    
    var presenter: SpeedTestPresenter!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setupConstraints()
    }
}

// MARK: - SpeedTestView

extension SpeedTestViewController: SpeedTestView {

}

// MARK: - Layout Setup

private extension SpeedTestViewController {
    func layoutSetup() {
        view.addSubviews([backgroundImageView, titleLabel, openMainButton, openSettingsButton])
        
        openMainButton.addTarget(self, action: #selector(openMain), for: .touchUpInside)
        openSettingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
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
}

// MARK: - Setup Constraints

private extension SpeedTestViewController {
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
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


