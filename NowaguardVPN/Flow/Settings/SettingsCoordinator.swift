import UIKit

protocol SettingsCoordinatorDelegate: AnyObject {
    func showMain()
    func showSpeedTest()
}

protocol SettingsCoordinator: Coordinator {
    var rootViewController: UIViewController { get }
    
    var delegate: SettingsCoordinatorDelegate! { get set }
    
    func showSpeedTest()
    func showMain()
}

final class SettingsCoordinatorImpl {

    // MARK: - Public Properties

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        viewController
    }
    
    // MARK: - Private

    var viewController: UIViewController!
    weak var delegate: SettingsCoordinatorDelegate!
    
    // MARK: - Dependency

    private let moduleFactory: SettingsModuleFactory
    
    // MARK: - Init

    init(moduleFactory: SettingsModuleFactory) {
        self.moduleFactory = moduleFactory
    }
    
    convenience init() {
        self.init(moduleFactory: SettingsModuleFactory())
    }
}

// MARK: - SettingsCoordinator

extension SettingsCoordinatorImpl: SettingsCoordinator {

    func start() {
        let module = moduleFactory.createModule(withCoordinator: self)
        viewController = module.view
    }
    
    func showSpeedTest(){
        delegate.showSpeedTest()
    }
    
    func showMain(){
        delegate.showMain()
    }
}
