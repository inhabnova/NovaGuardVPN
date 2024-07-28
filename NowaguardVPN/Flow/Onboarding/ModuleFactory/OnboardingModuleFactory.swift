import Foundation

struct OnboardingModuleFactory {}

// MARK: - ModuleFactory

extension OnboardingModuleFactory: ModuleFactory {
    
    func createModule(withCoordinator coordinator: OnboardingCoordinator) -> Module<OnboardingPresenter> {
        let viewController = OnboardingViewController()
        viewController.presenter = OnboardingPresenterImpl()
        viewController.presenter.coordinator = coordinator
        viewController.presenter.view = viewController
        return Module(view: viewController, presenter: viewController.presenter)
    }
}

