protocol SpeedTestPresenter {
    var view: SpeedTestView! { get set }
    var coordinator: SpeedTestCoordinator! { get set }
}

final class SpeedTestPresenterImpl {
    
    // MARK: - Public Properties
    
    weak var view: SpeedTestView!
    weak var coordinator: SpeedTestCoordinator!
}

// MARK: - SpeedTestPresenter

extension SpeedTestPresenterImpl: SpeedTestPresenter {

    
}

