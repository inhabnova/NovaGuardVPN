import UIKit

protocol OnboardingCoordinatorDelegate: AnyObject {
    func onboardingCoordinatorDidFinish(with coordinator: OnboardingCoordinator)
}

protocol OnboardingCoordinator: Coordinator {
    var rootViewController: UIViewController { get }
    var delegate: OnboardingCoordinatorDelegate? { get set }
    
    func showPaywall()
}

final class OnboardingCoordinatorImpl {

    // MARK: - Public Properties

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        viewController
    }
    
    // MARK: - Private

    var viewController: UIViewController!
    weak var delegate: OnboardingCoordinatorDelegate?
    
    // MARK: - Dependency

    private let moduleFactory: OnboardingModuleFactory
    
    // MARK: - Init

    init(moduleFactory: OnboardingModuleFactory) {
        self.moduleFactory = moduleFactory
    }
    
    convenience init() {
        self.init(moduleFactory: OnboardingModuleFactory())
    }
}

// MARK: - OnboardingCoordinator

extension OnboardingCoordinatorImpl: OnboardingCoordinator {

    func start() {
        let module = moduleFactory.createModule(withCoordinator: self)
        viewController = module.view
    }
    
    func showPaywall() {
        delegate?.onboardingCoordinatorDidFinish(with: self)
    }
}
