import UIKit

protocol MainCoordinator: Coordinator {
    var rootViewController: UIViewController { get }
}

final class MainCoordinatorImpl {

    // MARK: - Public Properties

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        viewController
    }
    
    // MARK: - Private

    var viewController: UIViewController!
    
    // MARK: - Dependency

    private let moduleFactory: MainModuleFactory
    
    // MARK: - Init

    init(moduleFactory: MainModuleFactory) {
        self.moduleFactory = moduleFactory
    }
    
    convenience init() {
        self.init(moduleFactory: MainModuleFactory())
    }
}

// MARK: - MainCoordinator

extension MainCoordinatorImpl: MainCoordinator {

    func start() {
        let module = moduleFactory.createModule(withCoordinator: self)
        viewController = module.view
    }
}
