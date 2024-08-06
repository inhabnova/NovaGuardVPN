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
        
        loaded()
    }
    
    func loaded() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) ) {
            
            //load from fb
            
            
            
            self.activity.stopAnimating()
            let vc = Voronka1_2VC(presenter: self.presenter)
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            self.dismiss(animated: true)
            self.present(vc, animated: true)
        }
    }
    
    init(presenter: VorPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
