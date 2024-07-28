import UIKit

protocol Paywall3SubsCoordinator: Coordinator {
    var rootViewController: UIViewController { get }
}

final class Paywall3SubsCoordinatorImpl {

    // MARK: - Public Properties

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        viewController
    }
    
    // MARK: - Private

    var viewController: UIViewController!
    
    // MARK: - Dependency

    private let moduleFactory: Paywall3SubsModuleFactory
    
    // MARK: - Init

    init(moduleFactory: Paywall3SubsModuleFactory) {
        self.moduleFactory = moduleFactory
    }
    
    convenience init() {
        self.init(moduleFactory: Paywall3SubsModuleFactory())
    }
}

// MARK: - Paywall3SubsCoordinator

extension Paywall3SubsCoordinatorImpl: Paywall3SubsCoordinator {

    func start() {
        let module = moduleFactory.createModule(withCoordinator: self)
        viewController = module.view
    }
}
