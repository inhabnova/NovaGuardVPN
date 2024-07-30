import UIKit

protocol PaywallCoordinator: Coordinator {
    var rootViewController: UIViewController { get }
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
    
    // MARK: - Dependency

    private let moduleFactory: PaywallModuleFactory
    
    // MARK: - Init

    init(moduleFactory: PaywallModuleFactory) {
        self.moduleFactory = moduleFactory
    }
    
    convenience init() {
        self.init(moduleFactory: PaywallModuleFactory())
    }
}

// MARK: - PaywallCoordinator

extension PaywallCoordinatorImpl: PaywallCoordinator {

    func start() {
        let module = moduleFactory.createModule(withCoordinator: self)
        viewController = module.view
    }
}
