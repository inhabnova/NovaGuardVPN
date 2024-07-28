protocol Paywall1SubsPresenter {
    var view: Paywall1SubsView! { get set }
    var coordinator: Paywall1SubsCoordinator! { get set }
}

final class Paywall1SubsPresenterImpl {
    
    // MARK: - Public Properties
    
    weak var view: Paywall1SubsView!
    weak var coordinator: Paywall1SubsCoordinator!
}

// MARK: - Paywall1SubsPresenter

extension Paywall1SubsPresenterImpl: Paywall1SubsPresenter {

    
}

