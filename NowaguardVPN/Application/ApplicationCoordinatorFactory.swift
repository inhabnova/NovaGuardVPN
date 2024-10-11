import Foundation

protocol ApplicationCoordinatorFactory {
    func createOnboardingCoordinator() -> OnboardingCoordinator
    func createMainCoordinator(fastStart: Bool) -> MainCoordinator
    func createSelectCountryCoordinator(isPremium: Bool) -> SelectCountryCoordinator
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
    
    func createMainCoordinator(fastStart: Bool) -> MainCoordinator {
        MainCoordinatorImpl.init(fastStart: fastStart)
    }
    
    func createSelectCountryCoordinator(isPremium: Bool) -> SelectCountryCoordinator {
        SelectCountryCoordinatorImpl(isPremium: isPremium)
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


