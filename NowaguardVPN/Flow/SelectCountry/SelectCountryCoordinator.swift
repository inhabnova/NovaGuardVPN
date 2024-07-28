import UIKit

protocol SelectCountryCoordinator: Coordinator {
    var rootViewController: UIViewController { get }
}

final class SelectCountryCoordinatorImpl {

    // MARK: - Public Properties

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        viewController
    }
    
    // MARK: - Private

    var viewController: UIViewController!
    
    // MARK: - Dependency

    private let moduleFactory: SelectCountryModuleFactory
    
    // MARK: - Init

    init(moduleFactory: SelectCountryModuleFactory) {
        self.moduleFactory = moduleFactory
    }
    
    convenience init() {
        self.init(moduleFactory: SelectCountryModuleFactory())
    }
}

// MARK: - SelectCountryCoordinator

extension SelectCountryCoordinatorImpl: SelectCountryCoordinator {

    func start() {
        let module = moduleFactory.createModule(withCoordinator: self)
        viewController = module.view
    }
}
