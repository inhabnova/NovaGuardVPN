import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func showSelectCountry()
    func showSpeedTest()
    func showSettings()
}

protocol MainCoordinator: Coordinator {
    var rootViewController: UIViewController { get }
    
    var delegate: MainCoordinatorDelegate! { get set }
    
    func showSelectCountry()
    func showSpeedTest()
    func showSettings()
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
    weak var delegate: MainCoordinatorDelegate!
    
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
    
    func showSelectCountry() {
        delegate.showSelectCountry()
    }
    
    func showSpeedTest() {
        delegate.showSpeedTest()
    }
    
    func showSettings() {
        delegate.showSettings()
    }
}
