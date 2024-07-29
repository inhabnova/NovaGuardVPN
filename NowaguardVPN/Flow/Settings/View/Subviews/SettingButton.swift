import UIKit

final class SettingButton: UIButton {
    
    private let countryButtonRightImage = UIImageView(image: I.Main.countryButtonRightArrow)
    private let leftImageView = UIImageView()
    private let label = UILabel()
    private let botImageView = UIImageView(image: I.Settings.separator)
    
    init(image: UIImage, title: String) {
        super.init(frame: .zero)
        
        leftImageView.image = image
        leftImageView.contentMode = .scaleAspectFit
        
        label.text = title
        label.textColor = .white
        label.font = .systemFont(ofSize: .calc(16), weight: .semibold)
        
        botImageView.contentMode = .scaleAspectFit
        
        backgroundColor = .appGray
        
        countryButtonRightImage.contentMode = .scaleAspectFit
        addSubviews([countryButtonRightImage, leftImageView, label, botImageView])
        
        countryButtonRightImage.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(20)
        }
        
        leftImageView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.6)
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
        }
        
        label.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.6)
            $0.centerY.equalToSuperview()
            $0.left.equalTo(leftImageView.snp.right).inset(-20)
        }
        
        botImageView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }
}
