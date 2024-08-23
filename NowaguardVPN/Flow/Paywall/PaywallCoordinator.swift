import UIKit

protocol PaywallCoordinatorDelegate: AnyObject {
    func paywallCoordinatorDidFinish(with coordinator: any PaywallCoordinator, isPurshased: Bool)
}

protocol PaywallCoordinator: Coordinator {
    var rootViewController: UIViewController { get }
    var delegate: PaywallCoordinatorDelegate? { get set }
    
    ///true - 1 подписка, false - 3 подписки
    var setOwnPurchase: Bool { get }
    var idPurchaseAfterOnboarding: String? { get set }
    var allIdPuechase: [String]? { get set }
    var delayCross: Int? { get set }
    func close()
    func didFinishTransaction()
}

final class PaywallCoordinatorImpl {

    // MARK: - Public Properties

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        viewController
    }
    
    // MARK: - Private

    var viewController: UIViewController!
    weak var delegate: PaywallCoordinatorDelegate?
    var delayCross: Int?
    var setOwnPurchase: Bool
    var idPurchaseAfterOnboarding: String?
    var allIdPuechase: [String]?
    
    // MARK: - Dependency

    private let moduleFactory: PaywallModuleFactory
    
    // MARK: - Init

    init(moduleFactory: PaywallModuleFactory, setOwnPurchase: Bool) {
        self.moduleFactory = moduleFactory
        self.setOwnPurchase = setOwnPurchase
    }
    
    convenience init(setOwnPurchase: Bool) {
        self.init(moduleFactory: PaywallModuleFactory(), setOwnPurchase: setOwnPurchase)
    }
}

// MARK: - PaywallCoordinator

extension PaywallCoordinatorImpl: PaywallCoordinator {

    func start() {
        let module = moduleFactory.createModule(withCoordinator: self)
        viewController = module.view
    }
    
    func close() {
        delegate?.paywallCoordinatorDidFinish(with: self, isPurshased: false)
    }
    
    func didFinishTransaction() {
        DispatchQueue.main.async {
            self.delegate?.paywallCoordinatorDidFinish(with: self, isPurshased: true)            
        }
    }
}
