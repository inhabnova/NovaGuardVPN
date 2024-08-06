import UIKit
import StoreKit

final class Voronka1_3VC: UIViewController {
    
    var presenter: VorPresenter
    
    private let textTitle = "Checking your iPhone..."
    private let textTitle2 =  "Your iPhone is at high risk"
    private let textTitle3 = "What will be closed when using VPN"
    private let subtitle = "Do not close this window."
    private let subtitle1 = "To stay safe, don't delete the app and keep it running."
    
    private let contentTitle = "Available online "
    private let subtitles = ["PUF.Mach.Cache.Crashlyst", "PUF.Mach.Cache.Crashlyst21231231", "PUF.Mach.Cache.Crashlystasdfasfasf", "PUF.Mach.Cache.Crashlyst 176g8huwdjnkvbsfkhgiuhfjvmnbsfghufjapmvknbjfo", "PUF.Mach.Cache.Crashlyst", "PUF.Mach.Cache.Crashlyst21231231", "PUF.Mach.Cache.Crashlystasdfasfasf", "PUF.Mach.Cache.Crashlyst 176g8huwdjnkvbsfkhgiuhfjvmnbsfghufjapmvknbjfo", "PUF.Mach.Cache.Crashlyst", "PUF.Mach.Cache.Crashlyst21231231", "PUF.Mach.Cache.Crashlystasdfasfasf", "PUF.Mach.Cache.Crashlyst 176g8huwdjnkvbsfkhgiuhfjvmnbsfghufjapmvknbjfo", "PUF.Mach.Cache.Crashlyst", "PUF.Mach.Cache.Crashlyst21231231", "PUF.Mach.Cache.Crashlystasdfasfasf", "PUF.Mach.Cache.Crashlyst 176g8huwdjnkvbsfkhgiuhfjvmnbsfghufjapmvknbjfo"]
    private let subtitles1 = ["PUF.Mach.Cache.Crashlyst", "PUF.Mach.Cache.Crashlyst21231231", "PUF.Mach.Cache.Crashlystasdfasfasf", "PUF.Mach.Cache.Crashlyst 176g8huwdjnkvbsfkhgiuhfjvmnbsfghufjapmvknbjfo", "PUF.Mach.Cache.Crashlyst", "PUF.Mach.Cache.Crashlyst21231231", "PUF.Mach.Cache.Crashlystasdfasfasf", "PUF.Mach.Cache.Crashlyst 176g8huwdjnkvbsfkhgiuhfjvmnbsfghufjapmvknbjfo", "PUF.Mach.Cache.Crashlyst", "PUF.Mach.Cache.Crashlyst21231231", "PUF.Mach.Cache.Crashlystasdfasfasf", "PUF.Mach.Cache.Crashlyst 176g8huwdjnkvbsfkhgiuhfjvmnbsfghufjapmvknbjfo", "PUF.Mach.Cache.Crashlyst", "PUF.Mach.Cache.Crashlyst21231231", "PUF.Mach.Cache.Crashlystasdfasfasf", "PUF.Mach.Cache.Crashlyst 176g8huwdjnkvbsfkhgiuhfjvmnbsfghufjapmvknbjfo"]
    private let buttonTGitle = "Clean my iPhone"
    private let buttonTGitle1 = "Done"
    private let alertTitle = "Attention!"
    private let alertContent = "Subscription failed, please try again."
    private let alertButton = "Try again"
    
    
    //3
    private let activity = UIActivityIndicatorView(style: .large)
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private lazy var content = Content_vor1(image: I.Vor.v1_31, title: contentTitle, subtitles: subtitles)
    private lazy var content1 = Content_vor1(image: I.Vor.v1_32, title: contentTitle, subtitles: subtitles1)
    
    //4
    private let image = UIImageView(image: I.Vor.v1_4)
    private let button = UIButton()
    
    private var isFinishFirst = false
    private var isFinishFirst1 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubviews([activity, titleLabel, subtitleLabel, content, content1])
        
        content.delegate = self
        content1.delegate = self
        
        activity.color = .white
        activity.startAnimating()
        activity.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().inset(20)
        }
        
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: .calc(34), weight: .bold)
        titleLabel.text = textTitle
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(activity.snp.bottom).inset(-20)
        }
        
        content.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).inset(-40)
        }
        
        content1.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(content.snp.bottom).inset(-20)
        }
        
        subtitleLabel.textColor = .white
        subtitleLabel.font = .systemFont(ofSize: .calc(17), weight: .medium)
        subtitleLabel.text = subtitle
        subtitleLabel.numberOfLines = 0
        subtitleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(view.frame.height / 14.5)
        }
    }
     
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.layer.cornerRadius = button.bounds.height / 4
    }
    
    init(presenter: VorPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonAction() {
        Task {
            await asd()
        }
    }
    
    func asd() async {
        let productId = ["123"]
        do {
            if let product = try await Product.products(for: productId).first {
                
                let result = try await product.purchase()
                switch result {
                case .success(let verificationResult):
                    activity.isHidden = false
                    activity.startAnimating()
                    
                    titleLabel.text = textTitle3
                    
                    subtitleLabel.isHidden = false
                    
                    image.isHidden = true
                    button.isHidden = true
                    
                    content.toGreen()
                    content1.toGreen()
                default :
                    showErrorAlert()
                }
                
            } else {
                showErrorAlert()
            }
        } catch {
            showErrorAlert()
        }
    }
}

extension Voronka1_3VC: Content_vor1Delegate {
    func finish() {
        if isFinishFirst {
            show4VC()
        } else {
            isFinishFirst.toggle()
            return
        }
    }
    
    func finish1() {
        if isFinishFirst1 {
            show5VC()
        } else {
            isFinishFirst1.toggle()
            return
        }
    }
    
    private func show4VC() {
        activity.isHidden = true
        activity.stopAnimating()
        
        subtitleLabel.isHidden = true
        
        view.addSubviews([image, button])
        
        image.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalToSuperview().inset(20)
        }
        
        titleLabel.text = textTitle2
        titleLabel.snp.removeConstraints()
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(image.snp.bottom).inset(-20)
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
    
    private func show5VC() {
        activity.isHidden = true
        activity.stopAnimating()
        
        content.updateImage(I.Vor.v1_31gr)
        content1.updateImage(I.Vor.v1_32gr)
        
        image.isHidden = false
        image.image = I.Vor.v1_5
        
        subtitleLabel.text = subtitle1
        subtitleLabel.textColor = .appGrayVor
        subtitleLabel.snp.removeConstraints()
        subtitleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.top.equalTo(content1.snp.bottom).inset(-30)
            $0.height.equalTo(view.frame.height / 14.5)
        }
        
        button.isHidden = false
        button.setTitle(buttonTGitle1, for: .normal)
        button.addTarget(self, action: #selector(buttonActionToLast), for: .touchUpInside)
    }
    
    @objc func buttonActionToLast() {
        let vc = Voronka1_last(presenter: presenter)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: alertTitle, message: alertContent, preferredStyle: .alert)
        let alertBtn = UIAlertAction(title: alertButton, style: .default) {_ in 
            alert.dismiss(animated: true)
        }
        
        alert.addAction(alertBtn)
        self.present(alert, animated: true)
    }
}
