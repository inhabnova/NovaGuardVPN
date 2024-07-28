import UIKit

protocol Paywall1SubsCoordinator: Coordinator {
    var rootViewController: UIViewController { get }
}

final class Paywall1SubsCoordinatorImpl {

    // MARK: - Public Properties

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        viewController
    }
    
    // MARK: - Private

    var viewController: UIViewController!
    
    // MARK: - Dependency

    private let moduleFactory: Paywall1SubsModuleFactory
    
    // MARK: - Init

    init(moduleFactory: Paywall1SubsModuleFactory) {
        self.moduleFactory = moduleFactory
    }
    
    convenience init() {
        self.init(moduleFactory: Paywall1SubsModuleFactory())
    }
}

// MARK: - Paywall1SubsCoordinator

extension Paywall1SubsCoordinatorImpl: Paywall1SubsCoordinator {

    func start() {
        let module = moduleFactory.createModule(withCoordinator: self)
        viewController = module.view
    }
}
