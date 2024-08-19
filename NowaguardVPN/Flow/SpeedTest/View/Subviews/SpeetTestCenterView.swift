import UIKit

final class SpeetTestCenterView: UIView {
    
    // MARK: - UI Elements
    
    private let shadow = UIImageView(image: I.SpeedTest.shadowSpeedTest)
    private let separator = UIImageView(image: I.SpeedTest.vSeparator)
    private let downloadImageView = UIImageView(image: I.SpeedTest.download)
    private let uploadImageView = UIImageView(image: I.SpeedTest.upload)
    private let titleLabel1 = UILabel()
    private let titleLabel2 = UILabel()
    private let subTitleLabel1 = UILabel()
    private let subTitleLabel2 = UILabel()
    
    init() {
        
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addShadow() {
        addSubviews([shadow])
        shadow.contentMode = .scaleAspectFit
        shadow.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.top.equalToSuperview()
            $0.height.equalTo(shadow.snp.width)
        }
    }
    func removeShadow() {
        shadow.removeFromSuperview()
    }
    
    func update(download: Int) {
        if download > 0 {
            titleLabel1.text = "\(download) Mbit"
            addSubviews([shadow])
            shadow.contentMode = .scaleAspectFit
            shadow.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(0.5)
                $0.top.equalToSuperview()
                $0.height.equalTo(shadow.snp.width)
            }
        } else {
            shadow.removeFromSuperview()
        }
    }
    
    
    func update(upload: Int) {
        if upload > 0 {
            titleLabel2.text = "\(upload) Mbit"
            addSubviews([shadow])
            shadow.contentMode = .scaleAspectFit
            shadow.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(0.5)
                $0.top.equalToSuperview()
                $0.height.equalTo(shadow.snp.width)
            }
        } else {
            shadow.removeFromSuperview()
        }
    }
}

private extension SpeetTestCenterView {
    func setupUI() {
        backgroundColor = .clear
        
        addSubviews([separator, downloadImageView, uploadImageView, titleLabel1, titleLabel2, subTitleLabel1, subTitleLabel2])
        
        separator.contentMode = .scaleAspectFit
        downloadImageView.contentMode = .scaleAspectFit
        uploadImageView.contentMode = .scaleAspectFit
        
        titleLabel1.font = .systemFont(ofSize: .calc(20), weight: .bold)
        titleLabel2.font = .systemFont(ofSize: .calc(20), weight: .bold)
        subTitleLabel1.font = .systemFont(ofSize: .calc(14), weight: .regular)
        subTitleLabel2.font = .systemFont(ofSize: .calc(14), weight: .regular)
        
        titleLabel1.textColor =  .white
        titleLabel2.textColor = .white
        subTitleLabel1.textColor = .appGlayLabel
        subTitleLabel2.textColor = .appGlayLabel
        
        titleLabel1.textAlignment = .left
        titleLabel2.textAlignment = .right
        subTitleLabel1.textAlignment = .left
        subTitleLabel2.textAlignment = .right
        
        titleLabel1.text = "0 Mbit"
        titleLabel2.text = "0 Mbit"
        subTitleLabel1.text = SpeedTestLocalization.download.localized
        subTitleLabel2.text = SpeedTestLocalization.upload.localized
        
        separator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(CGFloat.calc(30))
            $0.width.equalTo(2)
        }
        
        downloadImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.top.equalTo(separator.snp.top)
            $0.left.equalToSuperview().inset(20)
        }
        uploadImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.top.equalTo(separator.snp.top)
            $0.right.equalToSuperview().inset(20)
        }
        
        titleLabel1.snp.makeConstraints {
            $0.top.equalTo(separator.snp.top)
            $0.left.equalTo(downloadImageView.snp.right).inset(-10)
        }
        titleLabel2.snp.makeConstraints {
            $0.top.equalTo(separator.snp.top)
            $0.right.equalTo(uploadImageView.snp.left).inset(-10)
        }
        subTitleLabel1.snp.makeConstraints {
            $0.top.equalTo(titleLabel1.snp.bottom).inset(-10)
            $0.left.equalTo(titleLabel1.snp.left)
        }
        subTitleLabel2.snp.makeConstraints {
            $0.top.equalTo(titleLabel2.snp.bottom).inset(-10)
            $0.right.equalTo(titleLabel2.snp.right)
        }
    }
}
