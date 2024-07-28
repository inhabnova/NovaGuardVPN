import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {

    // MARK: - UI Elements
    
    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let labelsStack = UIStackView()
    private let pageControlImageView = UIImageView()
    private let continueButton = GreenButton(title: locale(.button))

    // MARK: - Public Properties
    
    var presenter: OnboardingPresenter!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        setupConstraints()
        presenter?.onViewDidLoad()
    }
}

// MARK: - OnboardingView

extension OnboardingViewController: OnboardingView {
    func updateView(title: String, subtitle: String, backgroundImageView: UIImage, pageControlImageView: UIImage) {
        UIView.animate(withDuration: 0.5) {
            self.titleLabel.text = title
            self.subtitleLabel.text = subtitle
            self.backgroundImageView.image = backgroundImageView
            self.pageControlImageView.image = pageControlImageView
        }
    }
    
}

// MARK: - Layout Setup

private extension OnboardingViewController {
    func layoutSetup() {
        view.backgroundColor = .appGray
        view.addSubviews([backgroundImageView, labelsStack, pageControlImageView, continueButton])
        
        backgroundImageView.contentMode = .scaleToFill

        labelsStack.addArrangedSubviews([titleLabel, subtitleLabel])
        labelsStack.axis = .vertical
        labelsStack.distribution = .fillEqually
        
        titleLabel.textColor = .appGreen
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        
        subtitleLabel.textColor = .white
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        
        backgroundImageView.contentMode = .scaleAspectFit
        
        continueButton.addTarget(self, action: #selector(continueButtonAction), for: .touchUpInside)
    }
    
    @objc func continueButtonAction() {
        presenter?.buttonAction()
    }
}

// MARK: - Setup Constraints

private extension OnboardingViewController {
    func setupConstraints() {
    
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        labelsStack.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        pageControlImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(continueButton.snp.top).inset(-30)
            $0.top.equalTo(labelsStack.snp.bottom).inset(-30)
            $0.height.equalTo(view.frame.height / 153)
            $0.width.equalTo(view.frame.width / 5.4)
        }
        
        continueButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(view.frame.height / 14.5)
        }
    }
}


