import UIKit

protocol SelectCountryCoordinatorDelegate: AnyObject {
    func selectCoordinatorDidFinish(with coordinator: SelectCountryCoordinator)
}

protocol SelectCountryCoordinator: Coordinator {
    var rootViewController: UIViewController { get }
    
    var delegate: SelectCountryCoordinatorDelegate! { get set }
    func close()
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
    weak var delegate: SelectCountryCoordinatorDelegate!
    
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
    func close() {
        delegate.selectCoordinatorDidFinish(with: self)
    }
    

    func start() {
        let module = moduleFactory.createModule(withCoordinator: self)
        viewController = module.view
    }
}
