import UIKit

protocol ApplicationCoordinator: Coordinator, OnboardingCoordinatorDelegate, MainCoordinatorDelegate, SpeedTestCoordinatorDelegate, SettingsCoordinatorDelegate, VorDelegate {
    
    var isFirstLaunch: Bool { get }
    
    var delayCross: Int? { get set }
    
    func showVor1()
    func showVor2()
}

final class ApplicationCoordinatorImpl {
    
    // MARK: - Public Properties
    
    var childCoordinators: [Coordinator] = []
    
    var isFirstLaunch: Bool = true
    var delayCross: Int? = nil
    
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
        
        showOnboardingCoordinator()
//        showMainCoordinator()
//        showPaywallCoordinator()
        
//        } else {
//            showOnboardingCoordinator()
//        }
    }
    
    func showVor1() {
        applicationPresenter.presentViewController(Voronka1_1VC(presenter: VorPresenter(delegate: self)), withAnimations: false)
    }
    
    func showVor2() {
        applicationPresenter.presentViewController(Voronka2_1VC(presenter: VorPresenter(delegate: self)), withAnimations: false)
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
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        applicationPresenter.presentViewController(coordinator.rootViewController, withAnimations: true)
    }

    func showSelectCountryCoordinator() {
        let coordinator = coordinatorsFactory.createSelectCountryCoordinator()
        coordinator.start()
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        applicationPresenter.presentViewController(coordinator.rootViewController, withAnimations: true)
    }
    
    func showSpeedTestCoordinator() {
        let coordinator = coordinatorsFactory.createSpeedTestCoordinator()
        coordinator.start()
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        applicationPresenter.presentViewController(coordinator.rootViewController, withAnimations: true)
    }
    
    func showSettingsCoordinator() {
        let coordinator = coordinatorsFactory.createSettingsCoordinator()
        coordinator.start()
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        applicationPresenter.presentViewController(coordinator.rootViewController, withAnimations: true)
    }
    
    func showPaywallCoordinator_1() {
        let coordinator = coordinatorsFactory.createPaywallCoordinator_1()
        coordinator.start()
        coordinator.delayCross = delayCross
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        applicationPresenter.presentViewController(coordinator.rootViewController, withAnimations: true)
    }
    
    func showPaywallCoordinator_3() {
        let coordinator = coordinatorsFactory.createPaywallCoordinator_3()
        coordinator.start()
        coordinator.delayCross = delayCross
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        applicationPresenter.presentViewController(coordinator.rootViewController, withAnimations: true)
    }
}

// MARK: - OnboardingCoordinatorDelegate

extension ApplicationCoordinatorImpl: OnboardingCoordinatorDelegate {
    func onboardingCoordinatorDidFinish(with coordinator: OnboardingCoordinator) {
        removeCoordinator(coordinator)
        showMainCoordinator()
        showPaywallCoordinator_1()
    }
}

// MARK: - MainCoordinatorDelegate

extension ApplicationCoordinatorImpl: MainCoordinatorDelegate {
    
    func showSelectCountry() {
        showSelectCountryCoordinator()
    }
    
    func showSpeedTest() {
        showSpeedTestCoordinator()
    }
    
    func showSettings() {
        showSettingsCoordinator()
    }
}

// MARK: - SelectCountryCoordinatorDelegate

extension ApplicationCoordinatorImpl: SelectCountryCoordinatorDelegate {
    func selectCoordinatorDidFinish(with coordinator: any SelectCountryCoordinator) {
        removeCoordinator(coordinator)
        showMainCoordinator()
    }
}

// MARK: - SpeedTestCoordinatorDelegate, SettingsCoordinatorDelegate

extension ApplicationCoordinatorImpl: SpeedTestCoordinatorDelegate, SettingsCoordinatorDelegate {
    func toPaywall() {
        showPaywallCoordinator_3()
    }
    
    func showMain() {
        showMainCoordinator()
    }
}

//MARK: - VorDelegate

extension ApplicationCoordinatorImpl: VorDelegate {
    func removeAll() {
        self.window.removeFromSuperview()
    }
    
    func didFinish() {
        showMainCoordinator()
    }
}

//MARK: - PaywallCoordinatorDelegate

extension ApplicationCoordinatorImpl: PaywallCoordinatorDelegate {
    func paywallCoordinatorDidFinish(with coordinator: any PaywallCoordinator) {
        removeCoordinator(coordinator)
        if let coordinator = childCoordinators.last as? SettingsCoordinator {
            coordinator.start()
            coordinator.delegate = self
            addChildCoordinator(coordinator)
            applicationPresenter.presentViewController(coordinator.rootViewController, withAnimations: true)
        } else if let coordinator = childCoordinators.last as? MainCoordinator {
            coordinator.start()
            coordinator.delegate = self
            addChildCoordinator(coordinator)
            applicationPresenter.presentViewController(coordinator.rootViewController, withAnimations: true)
            
            let privacy = SettingsDetailViewController(whiteText: SettingsLocalization.button2.localized, greenText: SettingsLocalization.policy.localized, contentText: SettingsLocalization.contentTextPrivacy.localized)
            privacy.modalPresentationStyle = .fullScreen
            coordinator.rootViewController.present(privacy, animated: true)
        }
    }
}
