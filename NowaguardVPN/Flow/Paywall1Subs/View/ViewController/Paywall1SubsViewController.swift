import UIKit

final class Paywall1SubsViewController: UIViewController {

    // MARK: - UI Elements

    // MARK: - Public Properties
    
    var presenter: Paywall1SubsPresenter!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setupConstraints()
    }
}

// MARK: - Paywall1SubsView

extension Paywall1SubsViewController: Paywall1SubsView {

}

// MARK: - Layout Setup

private extension Paywall1SubsViewController {
    func layoutSetup() {
    
    }
}

// MARK: - Setup Constraints

private extension Paywall1SubsViewController {
    func setupConstraints() {
    
    }
}


