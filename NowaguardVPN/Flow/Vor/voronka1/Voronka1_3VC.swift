import UIKit
import StoreKit

final class Voronka1_3VC: UIViewController {
    
    var presenter: VorPresenter
    
    private let textTitle: String
    private let textTitle2: String
    private let textTitle3: String
    private let subtitle: String
    private let subtitle1: String
    private let contentTitle: String
    private let subtitles: [String]
    private let subtitles1: [String]
    private let buttonTGitle: String
    private let buttonTGitle1: String
    private let alertTitle: String
    private let alertContent: String
    private let alertButton: String
    
    
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
        titleLabel.adjustsFontSizeToFitWidth = true
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
        subtitleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(view.frame.height / 14.5)
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(screenCaptureDidChange),
                                               name: UIScreen.capturedDidChangeNotification,
                                               object: nil)
        // Подписываемся на уведомление о скриншоте
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userDidTakeScreenshot),
                                               name: UIApplication.userDidTakeScreenshotNotification,
                                               object: nil)
    }
     
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.layer.cornerRadius = button.bounds.height / 4
    }
    
    init(presenter: VorPresenter) {
        self.presenter = presenter
        self.textTitle = presenter.textTitleV1_3
        self.textTitle2 = presenter.textTitle2V1_3
        self.textTitle3 = presenter.textTitle3V1_3
        self.subtitle = presenter.subtitleV1_3
        self.subtitle1 = presenter.subtitle1V1_3
        self.contentTitle = presenter.contentTitleV1_3
        self.subtitles = presenter.subtitlesV1_3
        self.subtitles1 = presenter.subtitles1V1_3
        self.buttonTGitle = presenter.buttonTGitleV1_3
        self.buttonTGitle1 = presenter.buttonTGitle1V1_3
        self.alertTitle = presenter.alertTitleV1_3
        self.alertContent = presenter.alertContentV1_3
        self.alertButton = presenter.alertButtonV1_3
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func screenCaptureDidChange() {
        if UIScreen.main.isCaptured {
            // Запись экрана активна, скрываем конфиденциальный контент
            presenter.delegate.didFinish()
            // Можете скрыть другие элементы интерфейса или показать предупреждение
        }
    }
    @objc func userDidTakeScreenshot() {
        // Действия, которые нужно выполнить после создания скриншота
        view.subviews.forEach {$0.removeFromSuperview()}
        presenter.delegate.didFinish()
        // Вы можете показать пользователю предупреждение, записать это событие или предпринять другие меры.
    }
    deinit {
        // Не забывайте удалять наблюдателя, чтобы избежать утечек памяти
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.userDidTakeScreenshotNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIScreen.capturedDidChangeNotification,
                                                  object: nil)
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
