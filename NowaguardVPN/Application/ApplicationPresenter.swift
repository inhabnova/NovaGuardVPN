import UIKit

protocol ApplicationPresenter {
    func presentViewController(_ viewController: UIViewController, withAnimations: Bool)
    func present(_ viewController: UIViewController)
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
        
//        let navController = UINavigationController(rootViewController: viewController)
//        navController.setNavigationBarHidden(true, animated: false)
//        
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
    
    func present(_ viewController: UIViewController) {
        guard let window = window else { return }
        window.rootViewController?.present(viewController, animated: true)
    }
}
