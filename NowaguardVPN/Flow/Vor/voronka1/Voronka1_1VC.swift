import UIKit

final class Voronka1_1VC: UIViewController {
    
    var presenter: VorPresenter
    
    private let activity = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(activity)
        
        activity.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activity.startAnimating()
        activity.color = .white
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(screenCaptureDidChange),
                                               name: UIScreen.capturedDidChangeNotification,
                                               object: nil)
        // Подписываемся на уведомление о скриншоте
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userDidTakeScreenshot),
                                               name: UIApplication.userDidTakeScreenshotNotification,
                                               object: nil)
        Task {
            await loaded()
        }
    }
    
    func loaded() async {
        
        await presenter.load1()
        
        self.activity.stopAnimating()
        let vc = Voronka1_2VC(presenter: self.presenter)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.dismiss(animated: true)
        self.present(vc, animated: true)
        
    }
    
    init(presenter: VorPresenter) {
        self.presenter = presenter
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
}
