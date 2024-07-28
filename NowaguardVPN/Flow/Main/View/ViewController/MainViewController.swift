import UIKit

final class MainViewController: UIViewController {

    // MARK: - UI Elements

    // MARK: - Public Properties
    
    var presenter: MainPresenter!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setupConstraints()
    }
}

// MARK: - MainView

extension MainViewController: MainView {

}

// MARK: - Layout Setup

private extension MainViewController {
    func layoutSetup() {
        view.backgroundColor = .yellow
    }
}

// MARK: - Setup Constraints

private extension MainViewController {
    func setupConstraints() {
    
    }
}


