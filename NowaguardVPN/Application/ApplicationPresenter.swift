import UIKit

protocol ApplicationPresenter {
    func presentViewController(_ viewController: UIViewController, withAnimations: Bool)
}

final class ApplicationPresenterImpl: ApplicationPresenter {
    
    // MARK: - Private Properties
    
    private let window: UIWindow?
    
    // MARK: - Init
    
    init(window: UIWindow?) {
        self.window = window
    }
    
//    convenience init(window: UIWindow?) {
//        self.init(window: window)
//    }
    
    // MARK: - RootViewControllerPresenter
    
    func presentViewController(_ viewController: UIViewController, withAnimations: Bool = true) {
        guard let window = window else { return }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        if withAnimations {
            UIView.transition(
                with: window,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: nil)
        }
    }
}
