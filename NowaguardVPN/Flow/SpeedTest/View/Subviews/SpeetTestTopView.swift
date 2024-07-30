import UIKit

final class SpeetTestTopView: UIView {
    
    // MARK: - UI Elements
    
    private let button1: SettingButton
    private let button2: SettingButton
    private let button3: SettingButton
    
    init(ip: String, network: String, location: String) {
        
        button1 = SettingButton(image: I.SpeedTest.button1, title: SpeedTestLocalization.button1.localized, ip)
        button2 = SettingButton(image: I.SpeedTest.button2, title: SpeedTestLocalization.button2.localized, network)
        button3 = SettingButton(image: I.SpeedTest.button3, title: SpeedTestLocalization.button3.localized, location)
        
        super.init(frame: .zero)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SpeetTestTopView {
    func setupUI() {
        backgroundColor = .appGraySpeedTestBack
        addSubviews([button1, button2, button3])
        
        button1.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(button2.snp.top)
        }
        button2.snp.makeConstraints {
            $0.horizontalEdges.height.equalTo(button1)
            $0.bottom.equalTo(button3.snp.top)
        }
        button3.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.225)
            $0.horizontalEdges.height.equalTo(button1)
            $0.bottom.equalToSuperview()
        }
        button1.isUserInteractionEnabled = false
        button2.isUserInteractionEnabled = false
        button3.isUserInteractionEnabled = false
        button3.removeSeparator()
    }
}
