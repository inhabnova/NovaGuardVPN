import UIKit

protocol SelectCountryCoordinatorDelegate: AnyObject {
    func selectCoordinatorDidFinish(with coordinator: SelectCountryCoordinator, server: Server)
    func selectCountryWithoutPremuim(with coordinator: SelectCountryCoordinator)
}

protocol SelectCountryCoordinator: Coordinator {
    var rootViewController: UIViewController { get }
    
    var delegate: SelectCountryCoordinatorDelegate! { get set }
    var isPremium: Bool { get set }
    
    func close(server: Server)
    func showPaywall()
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
    var isPremium: Bool
    
    // MARK: - Dependency

    private let moduleFactory: SelectCountryModuleFactory
    
    // MARK: - Init

    init(moduleFactory: SelectCountryModuleFactory, isPremium: Bool) {
        self.isPremium = isPremium
        self.moduleFactory = moduleFactory
    }
    
    convenience init(isPremium: Bool) {
        self.init(moduleFactory: SelectCountryModuleFactory(), isPremium: isPremium)
    }
}

// MARK: - SelectCountryCoordinator

extension SelectCountryCoordinatorImpl: SelectCountryCoordinator {
    
    func close(server: Server) {
        delegate.selectCoordinatorDidFinish(with: self, server: server)
    }
    
    func showPaywall() {
        delegate.selectCountryWithoutPremuim(with: self)
    }

    func start() {
        let module = moduleFactory.createModule(withCoordinator: self)
        viewController = module.view
    }
}
