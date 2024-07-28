protocol SpeedTestPresenter {
    var view: SpeedTestView! { get set }
    var coordinator: SpeedTestCoordinator! { get set }
    
    func showMain()
    func showSettings()
}

final class SpeedTestPresenterImpl {
    
    // MARK: - Public Properties
    
    weak var view: SpeedTestView!
    weak var coordinator: SpeedTestCoordinator!
}

// MARK: - SpeedTestPresenter

extension SpeedTestPresenterImpl: SpeedTestPresenter {

    func showMain() {
        coordinator.showMain()
    }
    
    func showSettings() {
        coordinator.showSettings()
    }
}

