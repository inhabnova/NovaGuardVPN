import UIKit
protocol PaywallPresenter {
    var view: PaywallView! { get set }
    var coordinator: PaywallCoordinator! { get set }
    
    func onViewDidload()
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
    
    func onViewDidload() {
        if coordinator.setOwnPurchase {
            view.setOwnPurcshase()
            if let delay = coordinator.delayCross {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
                    self.view.showBackButton()
                }
            } else {
                self.view.showBackButton()
            }
        } else {
            view.setThreePurcshase()
            view.showBackButton()
        }
    }
    
    func restore() {
        
    }
    
    func close() {
        coordinator.close()
    }
    
    func openToU() {
        UIApplication.shared.open(URL(string: "https://inhabitrlimited.digital/terms.html")!, options: [:], completionHandler: nil)
    }
    
    func openPP() {
        UIApplication.shared.open(URL(string: "https://inhabitrlimited.digital/Privacy.html")!, options: [:], completionHandler: nil)
    }
    
    func subscription() {
        
    }
}

