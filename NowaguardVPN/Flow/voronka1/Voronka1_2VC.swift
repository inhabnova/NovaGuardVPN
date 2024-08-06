import UIKit

final class Voronka1_2VC: UIViewController {
    
    var presenter: VorPresenter
    
    private let textTitle = "Check your iPhone"
    private let subtitle = "Check your device. The check will not take much time. After passing the test, you will see what you can protect by using a VPN."
    private let buttonTGitle = "Check my iPhone"
    
    private let image = UIImageView(image: I.Vor.v1_2)
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubviews([image, titleLabel, subtitleLabel, button])
        
        image.contentMode = .scaleAspectFit
        image.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().inset(20)
        }
        
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: .calc(34), weight: .bold)
        titleLabel.text = textTitle
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(image.snp.bottom).inset(-20)
        }
        
        subtitleLabel.textColor = .appGrayVor
        subtitleLabel.font = .systemFont(ofSize: .calc(17), weight: .regular)
        subtitleLabel.text = subtitle
        subtitleLabel.numberOfLines = 0
        subtitleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).inset(-40)
        }
        
        button.backgroundColor = .systemBlue
        button.setTitle(buttonTGitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: .calc(17), weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(view.frame.height / 14.5)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.layer.cornerRadius = button.bounds.height / 4
    }
    
    @objc func buttonAction() {
        let vc = Voronka1_3VC(presenter: presenter)
        vc.modalPresentationStyle = .fullScreen
//        self.dismiss(animated: false)
        self.present(vc, animated: false)
    }
    
    init(presenter: VorPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
