import UIKit

final class Voronka2_Last: UIViewController {
    
    var presenter: VorPresenter
    
    private let textTitle = "Attention!"
    private let subtitle = "To keep your connection safe and secure do not delete the app from your iphone!"
    private let buttonTGitle = "OK"
    
    private let image = UIImageView(image: I.Vor.v2_s)
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private lazy var button = Vor2_btn(leftColor: UIColor(hex: "#009EFD"), rightColor: UIColor(hex: "#2AF598"), title: buttonTGitle)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubviews([image, titleLabel, subtitleLabel, button])
        
        image.contentMode = .scaleAspectFit
        image.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.35)
        }
        
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: .calc(24), weight: .regular)
        titleLabel.text = textTitle
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(40)
            $0.top.equalTo(image.snp.bottom).inset(-20)
        }
        
        subtitleLabel.textColor = .white
        subtitleLabel.font = .systemFont(ofSize: .calc(18), weight: .regular)
        subtitleLabel.text = subtitle
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        subtitleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(40)
            $0.top.equalTo(titleLabel.snp.bottom).inset(-40)
        }
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(view.frame.height / 14.5)
        }
    }
    
    @objc func buttonAction() {
        presenter.delegate.didFinish()
    }
    
    init(presenter: VorPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

