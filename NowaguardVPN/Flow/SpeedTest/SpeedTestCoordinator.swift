import UIKit

protocol SpeedTestCoordinatorDelegate: AnyObject {
    func showMain()
    func showSettings()
}

protocol SpeedTestCoordinator: Coordinator {
    var rootViewController: UIViewController { get }
    
    var delegate: SpeedTestCoordinatorDelegate! { get set }
    
    func showMain()
    func showSettings()
}

final class SpeedTestCoordinatorImpl {

    // MARK: - Public Properties

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        viewController
    }
    
    // MARK: - Private

    var viewController: UIViewController!
    weak var delegate: SpeedTestCoordinatorDelegate! 
    
    // MARK: - Dependency

    private let moduleFactory: SpeedTestModuleFactory
    
    // MARK: - Init

    init(moduleFactory: SpeedTestModuleFactory) {
        self.moduleFactory = moduleFactory
    }
    
    convenience init() {
        self.init(moduleFactory: SpeedTestModuleFactory())
    }
}

// MARK: - SpeedTestCoordinator

extension SpeedTestCoordinatorImpl: SpeedTestCoordinator {

    func start() {
        let module = moduleFactory.createModule(withCoordinator: self)
        viewController = module.view
    }
    
    func showMain() {
        delegate.showMain()
    }
    
    func showSettings() {
        delegate.showSettings()
    }
}
