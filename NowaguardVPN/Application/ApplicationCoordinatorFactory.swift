import Foundation

protocol ApplicationCoordinatorFactory {
    func createOnboardingCoordinator() -> OnboardingCoordinator
    func createMainCoordinator() -> MainCoordinator
    func createSelectCountryCoordinator() -> SelectCountryCoordinator
    func createSpeedTestCoordinator() -> SpeedTestCoordinator
    func createSettingsCoordinator() -> SettingsCoordinator
    func createPaywallCoordinator_3() -> PaywallCoordinator
    func createPaywallCoordinator_1() -> PaywallCoordinator
}

struct ApplicationCoordinatorFactoryImpl {}

// MARK: - ApplicationCoordinatorFactory

extension ApplicationCoordinatorFactoryImpl: ApplicationCoordinatorFactory {
    func createOnboardingCoordinator() -> OnboardingCoordinator {
        OnboardingCoordinatorImpl()
    }
    
    func createMainCoordinator() -> MainCoordinator {
        MainCoordinatorImpl()
    }
    
    func createSelectCountryCoordinator() -> SelectCountryCoordinator {
        SelectCountryCoordinatorImpl()
    }
    
    func createSpeedTestCoordinator() -> SpeedTestCoordinator {
        SpeedTestCoordinatorImpl()
    }
    
    func createSettingsCoordinator() -> SettingsCoordinator {
        SettingsCoordinatorImpl()
    }
    
    func createPaywallCoordinator_3() -> PaywallCoordinator {
        PaywallCoordinatorImpl(setOwnPurchase: false)
    }
    func createPaywallCoordinator_1() -> PaywallCoordinator {
        PaywallCoordinatorImpl(setOwnPurchase: true)
    }
}


