protocol Paywall3SubsPresenter {
    var view: Paywall3SubsView! { get set }
    var coordinator: Paywall3SubsCoordinator! { get set }
}

final class Paywall3SubsPresenterImpl {
    
    // MARK: - Public Properties
    
    weak var view: Paywall3SubsView!
    weak var coordinator: Paywall3SubsCoordinator!
}

// MARK: - Paywall3SubsPresenter

extension Paywall3SubsPresenterImpl: Paywall3SubsPresenter {

    
}

