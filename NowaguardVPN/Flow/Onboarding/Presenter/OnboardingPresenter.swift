import UIKit
protocol OnboardingPresenter {
    var view: OnboardingView! { get set }
    var coordinator: OnboardingCoordinator! { get set }
    var page: Int { get set }
    
    func onViewDidLoad()
    func buttonAction()
}

final class OnboardingPresenterImpl {
    
    // MARK: - Public Properties
    
    weak var view: OnboardingView!
    weak var coordinator: OnboardingCoordinator!
    
    var page: Int = 1
}

// MARK: - OnboardingPresenter

extension OnboardingPresenterImpl: OnboardingPresenter {
    
    func onViewDidLoad() {
        view.updateView(title: OnboardingLocalization.title1.localized,
                        subtitle: OnboardingLocalization.subtitle1.localized,
                        backgroundImageView: I.Onboarding.OnboardingBackbround1,
                        pageControlImageView: I.Onboarding.OnboardingPageControl1)
    }

    func buttonAction() {
        guard page < 3 else {
            coordinator.showMain()
            return
        }
        
        page += 1
        
        if page == 1 {
            view.updateView(title: OnboardingLocalization.title1.localized,
                            subtitle: OnboardingLocalization.subtitle1.localized,
                            backgroundImageView: I.Onboarding.OnboardingBackbround1,
                            pageControlImageView: I.Onboarding.OnboardingPageControl1)
        } else if page == 2 {
            view.updateView(title: OnboardingLocalization.title2.localized,
                            subtitle: OnboardingLocalization.subtitle2.localized,
                            backgroundImageView: I.Onboarding.OnboardingBackbround2,
                            pageControlImageView: I.Onboarding.OnboardingPageControl2)
        } else if page == 3 {
            view.updateView(title: OnboardingLocalization.title3.localized,
                            subtitle: OnboardingLocalization.subtitle3.localized,
                            backgroundImageView: I.Onboarding.OnboardingBackbround3,
                            pageControlImageView: I.Onboarding.OnboardingPageControl3)
        }
    }
}

