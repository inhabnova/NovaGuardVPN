import UIKit
import StoreKit

final class Voronka2_4VC: UIViewController {
    
    var presenter: VorPresenter
    
    private let textTitle = "Your iPhone is at high risk"
    private let subtitle = "Data can be seen"
    private let subtitle1 = "They can be encrypted when the VPN is enabled"
    private let subtitle2 = "We need to use encryption"
    private let buttonTGitle = "secure this iPhone".uppercased()
    private let subtitles = ["PUF.Mach.Cache.Crashlyst", "PUF.Mach.Cache.Crashlyst21231231", "PUF.Mach.Cache.Crashlystasdfasfasf", "PUF.Mach.Cache.Crashlyst 176g8huwdjnkvbsfkhgiuhfjvmnbsfghufjapmvknbjfo", "PUF.Mach.Cache.Crashlyst", "PUF.Mach.Cache.Crashlyst21231231", "PUF.Mach.Cache.Crashlystasdfasfasf", "PUF.Mach.Cache.Crashlyst 176g8huwdjnkvbsfkhgiuhfjvmnbsfghufjapmvknbjfo", "PUF.Mach.Cache.Crashlyst", "PUF.Mach.Cache.Crashlyst21231231", "PUF.Mach.Cache.Crashlystasdfasfasf", "PUF.Mach.Cache.Crashlyst 176g8huwdjnkvbsfkhgiuhfjvmnbsfghufjapmvknbjfo", "PUF.Mach.Cache.Crashlyst", "PUF.Mach.Cache.Crashlyst21231231", "PUF.Mach.Cache.Crashlystasdfasfasf", "PUF.Mach.Cache.Crashlyst 176g8huwdjnkvbsfkhgiuhfjvmnbsfghufjapmvknbjfo"]
    
    private let image = UIImageView(image: I.Vor.v2_41)
    private let image1 = UIImageView(image: I.Vor.v2_42)
    private let image2 = UIImageView(image: I.Vor.v2_43)
    
    private let label = UILabel()
    private let label1 = UILabel()
    private let label2 = UILabel()
    private let label3 = UILabel()
    private let label4 = UILabel()

    private lazy var button = Vor2_btn(leftColor: UIColor(hex: "#009EFD"), rightColor: UIColor(hex: "#2AF598"), title: buttonTGitle)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubviews([image, image1, image2, label, label1, label2, label3, label4, button])
        
        image.contentMode = .scaleAspectFit
        image.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.123)
            make.width.equalToSuperview()//.multipliedBy(0.133)
        }
        
        label.textColor = .red
        label.font = .systemFont(ofSize: .calc(24), weight: .bold)
        label.text = textTitle
        label.numberOfLines = 0
        label.textAlignment = .center
        label.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(image.snp.bottom).inset(-20)
        }
        
        label1.font = .systemFont(ofSize: .calc(24), weight: .regular)
        label1.textColor = .red
        label1.numberOfLines = 1
        label1.text = "\(subtitles.count)"
        label1.snp.makeConstraints {
            $0.left.equalToSuperview().inset(40)
            $0.top.equalTo(label.snp.bottom).inset(-40)
        }
        
        image1.contentMode = .scaleAspectFit
        image1.snp.makeConstraints {
            $0.left.equalTo(label1.snp.left)
            $0.top.equalTo(label1.snp.bottom).inset(-30)
            $0.width.height.equalTo(34)
        }
        
        image2.contentMode = .scaleAspectFit
        image2.snp.makeConstraints {
            $0.left.equalTo(image1.snp.left)
            $0.top.equalTo(image1.snp.bottom).inset(-30)
            $0.width.height.equalTo(34)
        }
        
        label2.text = subtitle
        label2.font = .systemFont(ofSize: .calc(16), weight: .regular)
        label2.textColor = .white
        label2.numberOfLines = 0
        label2.snp.makeConstraints {
            $0.left.equalTo(label1.snp.right).inset(-30)
            $0.right.equalToSuperview().inset(40)
            $0.top.equalTo(label1.snp.top)
        }
        
        label3.text = subtitle1
        label3.font = .systemFont(ofSize: .calc(16), weight: .regular)
        label3.textColor = .white
        label3.numberOfLines = 0
        label3.snp.makeConstraints {
            $0.left.equalTo(label2.snp.left)
            $0.right.equalToSuperview().inset(40)
            $0.top.equalTo(image1.snp.top)
        }
        
        label4.text = subtitle2
        label4.font = .systemFont(ofSize: .calc(16), weight: .regular)
        label4.textColor = .white
        label4.numberOfLines = 0
        label4.snp.makeConstraints {
            $0.left.equalTo(label2.snp.left)
            $0.right.equalToSuperview().inset(40)
            $0.top.equalTo(image2.snp.top)
        }
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(view.frame.height / 14.5)
        }
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
                    let vc = Voronka2_Last(presenter: presenter)
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: false)
                default :
                    let vc = Voronka2_Fail(presenter: presenter)
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: false)
                }
                
            } else {
                let vc = Voronka2_Fail(presenter: presenter)
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            }
        } catch {
            let vc = Voronka2_Fail(presenter: presenter)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
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
