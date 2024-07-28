import UIKit

protocol ApplicationCoordinator: Coordinator, OnboardingCoordinatorDelegate {
    
}

final class ApplicationCoordinatorImpl {
    
    // MARK: - Public Properties
    
    var childCoordinators: [Coordinator] = []
    
    // MARK: - Private Properties
    
    private var window: UIWindow!
    private let applicationPresenter: ApplicationPresenter
    private let coordinatorsFactory: ApplicationCoordinatorFactory
    
    // MARK: - Init
    
    init(
        window: UIWindow?,
        applicationPresenter: ApplicationPresenter,
        coordinatorsFactory: ApplicationCoordinatorFactory
    ) {
        self.applicationPresenter = applicationPresenter
        self.coordinatorsFactory = coordinatorsFactory
    }
    
    convenience init(window: UIWindow?) {
        let applicationPresenter = ApplicationPresenterImpl(window: window)
        
        self.init(
            window: window,
            applicationPresenter: applicationPresenter,
            coordinatorsFactory: ApplicationCoordinatorFactoryImpl()
        )
    }
}

// MARK: - ApplicationCoordinator

extension ApplicationCoordinatorImpl: ApplicationCoordinator {
    
    func start() {
        
//        TokenStorageImpl.shared.set("fake_account",
//                                    refreshToken: "fake_account")
//        if applicationPresenter.isLoggedIn() {
        
        showSelectCountryCoordinator()
        
//        } else {
//            showOnboardingCoordinator()
//        }
    }
}

// MARK: - Private

private extension ApplicationCoordinatorImpl {
    
    func showOnboardingCoordinator() {
        let coordinator = coordinatorsFactory.createOnboardingCoordinator()
        coordinator.start()
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        applicationPresenter.presentViewController(coordinator.rootViewController, withAnimations: false)
    }
    
    func showMainCoordinator() {
        let coordinator = coordinatorsFactory.createMainCoordinator()
        coordinator.start()
//        coordinator.delegate = self
        addChildCoordinator(coordinator)
        applicationPresenter.presentViewController(coordinator.rootViewController, withAnimations: true)
    }

    func showSelectCountryCoordinator() {
        let coordinator = coordinatorsFactory.createSelectCountryCoordinator()
        coordinator.start()
//        coordinator.delegate = self
        addChildCoordinator(coordinator)
        applicationPresenter.presentViewController(coordinator.rootViewController, withAnimations: true)
    }
}
//
// MARK: - OnboardingCoordinatorDelegate

extension ApplicationCoordinatorImpl: OnboardingCoordinatorDelegate {
    func onboardingCoordinatorDidFinish(with coordinator: OnboardingCoordinator) {
        removeCoordinator(coordinator)
        showMainCoordinator()
    }
}
//// MARK: - OnboardingCoordinatorDelegate
//
//extension ApplicationCoordinatorImpl: OnboardingCoordinatorDelegate {
//    
//    func onboardingCoordinatorDidFinish(with coordinator: OnboardingCoordinator) {
//        removeCoordinator(coordinator)
//        showLoginCoordinator()
//    }
//}

