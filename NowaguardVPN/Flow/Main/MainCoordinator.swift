import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func showSelectCountry()
    func showSpeedTest()
    func showSettings()
}

protocol MainCoordinator: Coordinator {
    var rootViewController: UIViewController { get }
    
    var delegate: MainCoordinatorDelegate! { get set }
    var fastStart: Bool? { get set }
    
    func showSelectCountry()
    func showSpeedTest()
    func showSettings()
    func changeCountry(server: Server?)
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
    var presenter: MainPresenter?
    
    weak var delegate: MainCoordinatorDelegate!
    var fastStart: Bool?
    
    // MARK: - Dependency

    private let moduleFactory: MainModuleFactory
    
    // MARK: - Init

    init(moduleFactory: MainModuleFactory, fastStart: Bool) {
        self.fastStart = fastStart
        self.moduleFactory = moduleFactory
    }
    
    convenience init(fastStart: Bool) {
        self.init(moduleFactory: MainModuleFactory(), fastStart: fastStart)
    }
}

// MARK: - MainCoordinator

extension MainCoordinatorImpl: MainCoordinator {

    func start() {
        let module = moduleFactory.createModule(withCoordinator: self)
        viewController = module.view
        presenter = module.presenter
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
    
    func changeCountry(server: Server?) {
        self.presenter?.changeCountry(country: server)
    }
}
