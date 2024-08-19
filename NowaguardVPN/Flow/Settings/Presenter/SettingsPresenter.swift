import UIKit
import MessageUI

protocol SettingsPresenter {
    var view: SettingsView! { get set }
    var coordinator: SettingsCoordinator! { get set }
    
    func showSpeedTest()
    func showMain()
    
    func didTapSettingsButton1()
    func didTapSettingsButton2()
    func didTapSettingsButton3()
    func didTapSettingsButton4()
    func didTapSettingsButton5()
}

final class SettingsPresenterImpl {
    
    // MARK: - Public Properties
    
    weak var view: SettingsView!
    weak var coordinator: SettingsCoordinator!
}

// MARK: - SettingsPresenter

extension SettingsPresenterImpl: SettingsPresenter {
    
    func showSpeedTest() {
        coordinator.showSpeedTest()
    }
    func showMain() {
        coordinator.showMain()
    }
    
    func didTapSettingsButton1() {
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = view
        mailComposer.setToRecipients(["info@inhabitrlimited.digital"])
        view.showVC(mailComposer)
    }
    func didTapSettingsButton2() {
        UIApplication.shared.open(URL(string: "https://inhabitrlimited.digital/Privacy.html")!, options: [:], completionHandler: nil)
    }
    func didTapSettingsButton3() {
        UIApplication.shared.open(URL(string: "https://inhabitrlimited.digital/terms.html")!, options: [:], completionHandler: nil)
    }
    func didTapSettingsButton4() {
        
    }
    func didTapSettingsButton5() {
        coordinator.toPaywall()
    }
}

