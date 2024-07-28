import Foundation

protocol ApplicationCoordinatorFactory {
    func createOnboardingCoordinator() -> OnboardingCoordinator
    func createMainCoordinator() -> MainCoordinator
    func createSelectCountryCoordinator() -> SelectCountryCoordinator
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
}


