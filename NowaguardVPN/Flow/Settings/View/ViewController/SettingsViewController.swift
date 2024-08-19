import UIKit
import MessageUI

final class SettingsViewController: UIViewController {

    // MARK: - UI Elements
    
    private let backgroundImageView = UIImageView(image: I.Settings.backgroundSettings)
    private let titleLabel = TitleLabel(whiteText: SettingsLocalization.app.localized + " ", greenText: SettingsLocalization.settings.localized)
    
    private let button1 = SettingButton(image: I.Settings.Button1Image, title: SettingsLocalization.button1.localized)
    private let button2 = SettingButton(image: I.Settings.Button2Image, title: SettingsLocalization.button2.localized)
    private let button3 = SettingButton(image: I.Settings.Button3Image, title: SettingsLocalization.button3.localized)
    private let button4 = SettingButton(image: I.Settings.Button4Image, title: SettingsLocalization.button4.localized)
    private let button5 = SettingButton(image: I.Settings.Button5Image, title: SettingsLocalization.button5.localized)
    
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
    func showVC(_ vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
}

// MARK: - Layout Setup

private extension SettingsViewController {
    func layoutSetup() {
        view.addSubviews([backgroundImageView, titleLabel, openSpeedTestButton, openMainButton, button1, button2, button3, button4, button5 ])
        
        openSpeedTestButton.addTarget(self, action: #selector(openSpeedTest), for: .touchUpInside)
        openMainButton.addTarget(self, action: #selector(openMain), for: .touchUpInside)
        
        
        button1.addTarget(self, action: #selector(button1Action), for: .touchUpInside)
        button2.addTarget(self, action: #selector(button2Action), for: .touchUpInside)
        button3.addTarget(self, action: #selector(button3Action), for: .touchUpInside)
        button4.addTarget(self, action: #selector(button4Action), for: .touchUpInside)
        button5.addTarget(self, action: #selector(button5Action), for: .touchUpInside)
        
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
    
    @objc func button1Action() {
        presenter.didTapSettingsButton1()
    }
    
    @objc func button2Action() {
        presenter.didTapSettingsButton2()
    }
    
    @objc func button3Action() {
        presenter.didTapSettingsButton3()
    }
    
    @objc func button4Action() {
        presenter.didTapSettingsButton4()
    }
    
    @objc func button5Action() {
        presenter.didTapSettingsButton5()
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
        
        button1.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalToSuperview().multipliedBy(0.075)
            $0.top.equalTo(titleLabel.snp.bottom).inset(-30)
        }
        
        button2.snp.makeConstraints {
            $0.width.height.horizontalEdges.equalTo(button1)
            $0.top.equalTo(button1.snp.bottom)
        }
        
        button3.snp.makeConstraints {
            $0.width.height.horizontalEdges.equalTo(button1)
            $0.top.equalTo(button2.snp.bottom)
        }
        
        button4.snp.makeConstraints {
            $0.width.height.horizontalEdges.equalTo(button1)
            $0.top.equalTo(button3.snp.bottom)
        }
        
        button5.snp.makeConstraints {
            $0.width.height.horizontalEdges.equalTo(button1)
            $0.top.equalTo(button4.snp.bottom)
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



//MARK: - MFMailComposeViewControllerDelegate

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
