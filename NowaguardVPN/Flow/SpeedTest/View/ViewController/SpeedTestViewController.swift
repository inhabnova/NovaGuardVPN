import UIKit

final class SpeedTestViewController: UIViewController {

    // MARK: - UI Elements

    // MARK: - Public Properties
    
    var presenter: SpeedTestPresenter!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setupConstraints()
    }
}

// MARK: - SpeedTestView

extension SpeedTestViewController: SpeedTestView {

}

// MARK: - Layout Setup

private extension SpeedTestViewController {
    func layoutSetup() {
    
    }
}

// MARK: - Setup Constraints

private extension SpeedTestViewController {
    func setupConstraints() {
    
    }
}


