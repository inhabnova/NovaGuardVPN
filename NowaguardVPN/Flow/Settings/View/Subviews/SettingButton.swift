import UIKit

final class SettingButton: UIButton {
    
    private let leftImageView = UIImageView()
    private let label = UILabel()
    private let botImageView = UIImageView(image: I.Settings.separator)
    
    init(image: UIImage, title: String, _ rightText: String? = nil) {
        super.init(frame: .zero)
        
        leftImageView.image = image
        leftImageView.contentMode = .scaleAspectFit
        
        label.text = title
        label.textColor = .white
        label.font = .systemFont(ofSize: .calc(16), weight: .semibold)
        
        botImageView.contentMode = .scaleAspectFit
        
        backgroundColor = .clear
        
        addSubviews([leftImageView, label, botImageView])
        
        leftImageView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.6)
            $0.centerY.equalToSuperview()
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
        
        if let rightText {
            
            if rightText == "" {
                //на пейволах 
                label.textColor = .white
            } else {
                label.textColor = .appGlayLabel
            }
            
            let label2 = UILabel()
            label2.text = rightText
            label2.textColor = .white
            label2.textAlignment = .right
            label2.font = .systemFont(ofSize: .calc(16), weight: .bold)
            
            addSubview(label2)
            
            label2.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.right.equalToSuperview()
            }
            
            leftImageView.snp.makeConstraints {
                $0.left.equalToSuperview()
            }
            
        } else {
            label.textColor = .appGlayLabel
            
            let countryButtonRightImage = UIImageView(image: I.Main.countryButtonRightArrow)
            countryButtonRightImage.contentMode = .scaleAspectFit
            addSubview(countryButtonRightImage)
            
            countryButtonRightImage.snp.makeConstraints {
                $0.height.equalToSuperview().multipliedBy(0.3)
                $0.centerY.equalToSuperview()
                $0.right.equalToSuperview().inset(20)
            }
            
            leftImageView.snp.makeConstraints {
                $0.left.equalToSuperview().inset(20)
            }
        }
    }
    
    func removeSeparator() {
        botImageView.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }
}
