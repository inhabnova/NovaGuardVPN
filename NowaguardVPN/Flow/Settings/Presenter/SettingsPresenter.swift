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
        
    }
    func didTapSettingsButton2() {
        view.showVC(SettingsDetailViewController(whiteText: SettingsLocalization.button2.localized,
                                                 greenText: SettingsLocalization.policy.localized, 
                                                 contentText: SettingsLocalization.contentTextPrivacy.localized))
    }
    func didTapSettingsButton3() {
        
    }
    func didTapSettingsButton4() {
        
    }
    func didTapSettingsButton5() {
        
    }
}

