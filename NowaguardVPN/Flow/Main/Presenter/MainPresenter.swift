protocol MainPresenter {
    var view: MainView! { get set }
    var coordinator: MainCoordinator! { get set }
}

final class MainPresenterImpl {
    
    // MARK: - Public Properties
    
    weak var view: MainView!
    weak var coordinator: MainCoordinator!
}

// MARK: - MainPresenter

extension MainPresenterImpl: MainPresenter {

    
}

