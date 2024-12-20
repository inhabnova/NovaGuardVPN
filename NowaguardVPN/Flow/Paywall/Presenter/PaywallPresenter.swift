import UIKit
import StoreKit

protocol PaywallPresenter {
    var view: PaywallView! { get set }
    var coordinator: PaywallCoordinator! { get set }
    
    var indexSelectedPurchase: Int { get set }
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
    
    private var subscriptions: [Product] = []
    var indexSelectedPurchase: Int = 0
}

// MARK: - PaywallPresenter

extension PaywallPresenterImpl: PaywallPresenter {
    @MainActor
    func onViewDidload() {
        if coordinator.setOwnPurchase {
            Task {
                subscriptions = try await Product.products(for: [coordinator.idPurchaseAfterOnboarding ?? ""])
                
                let product = subscriptions.first
                
                let price = product?.displayPrice
                let period = product?.subscription?.subscriptionPeriod.unit ?? .year
                let trial = product?.subscription?.introductoryOffer?.period.value
                
                view.setOwnPurcshase(trialCount: trial ?? 0, price: price ?? "100", period: "\(period)")
            }
            if let delay = coordinator.delayCross {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
                    self.view.showBackButton()
                }
            } else {
                self.view.showBackButton()
            }
        } else {
            
            Task {
                subscriptions = try await Product.products(for: coordinator.allIdPuechase ?? [])
                
                var dataPurchases: [(Int, String)] = []
                
                for subscription in self.subscriptions {
                    let product = subscription
                    
                    let price = product.displayPrice
                    let trial = product.subscription?.introductoryOffer?.period.value ?? 0
                    
                    dataPurchases.append((trial, price))
                }
                
                view.setThreePurcshase(dataPurchase: dataPurchases)
            }
            view.showBackButton()
        }
    }
    
    func restore() {
        Task {
            do {
                try await AppStore.sync()
            } catch {
                view.showErrorAlert()
            }
        }
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
        //подписка на пейволе с 1 или с 3 подписками 
        if coordinator.setOwnPurchase {
            if let id = coordinator.idPurchaseAfterOnboarding {
                Task {
                    await purchase(id: id)
                }
            } else {
                view.showErrorAlert()
            }
        } else {
            if let ids = coordinator.allIdPuechase {
                Task {
                    await purchase(id: ids[indexSelectedPurchase])
                }
            } else {
                view.showErrorAlert()
            }
        }
    }
    
    private func purchase(id: String) async {
        let productId = [id]
        do {
            if let product = try await Product.products(for: productId).first {
                
                let result = try await product.purchase()
                switch result {
                case .success(let verificationResult):
                    coordinator.didFinishTransaction()
                default :
                    break
                }
                
            }
        } catch {
            print("error purchase \(id)")
        }
    }
}

