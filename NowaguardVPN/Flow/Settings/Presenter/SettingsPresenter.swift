protocol SettingsPresenter {
    var view: SettingsView! { get set }
    var coordinator: SettingsCoordinator! { get set }
    
    func showSpeedTest()
    func showMain()
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
}

