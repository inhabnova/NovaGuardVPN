import Foundation

protocol ApplicationCoordinatorFactory {
    func createOnboardingCoordinator() -> OnboardingCoordinator
    func createMainCoordinator() -> MainCoordinator
    func createSelectCountryCoordinator() -> SelectCountryCoordinator
    func createSpeedTestCoordinator() -> SpeedTestCoordinator
    func createSettingsCoordinator() -> SettingsCoordinator
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
}


