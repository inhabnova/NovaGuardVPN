import UIKit

final class SettingsDetailViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let titleLabel: TitleLabel
    private let contentText = UITextView()
    private let backButton = UIButton()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appGray
        view.addSubviews([titleLabel, backButton, contentText])
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        backButton.setImage(I.SelectCountry.backButton, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.width.height.equalTo(24)
            $0.left.equalToSuperview().inset(20)
        }
        
        contentText.backgroundColor = .appGray
        contentText.font = .systemFont(ofSize: .calc(16), weight: .regular)
        contentText.textColor = .white
        contentText.isEditable = false
        
        contentText.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview().inset(30)
            $0.top.equalTo(titleLabel.snp.bottom).inset(-30)
        }
        
    }
    
    @objc func backButtonAction() {
        self.dismiss(animated: false)
    }
    
    init(whiteText: String, greenText: String, contentText: String) {
        self.titleLabel = .init(whiteText: whiteText, greenText: greenText)
        super.init(nibName: nil, bundle: nil)
        self.contentText.text = contentText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
