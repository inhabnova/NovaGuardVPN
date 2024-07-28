import UIKit

final class Paywall3SubsViewController: UIViewController {

    // MARK: - UI Elements

    // MARK: - Public Properties
    
    var presenter: Paywall3SubsPresenter!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setupConstraints()
    }
}

// MARK: - Paywall3SubsView

extension Paywall3SubsViewController: Paywall3SubsView {

}

// MARK: - Layout Setup

private extension Paywall3SubsViewController {
    func layoutSetup() {
    
    }
}

// MARK: - Setup Constraints

private extension Paywall3SubsViewController {
    func setupConstraints() {
    
    }
}


