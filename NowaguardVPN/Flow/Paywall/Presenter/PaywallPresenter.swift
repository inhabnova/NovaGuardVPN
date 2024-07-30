protocol PaywallPresenter {
    var view: PaywallView! { get set }
    var coordinator: PaywallCoordinator! { get set }
    
    func restore()
    func close()
    func openToU()
    func openPP()
    func subscription()
}

final class PaywallPresenterImpl {
    
    // MARK: - Public Properties
    
    weak var view: PaywallView!
    weak var coordinator: PaywallCoordinator!
}

// MARK: - PaywallPresenter

extension PaywallPresenterImpl: PaywallPresenter {
    func restore() {
        
    }
    
    func close() {
        
    }
    
    func openToU() {
        
    }
    
    func openPP() {
        
    }
    
    func subscription() {
        
    }
}

