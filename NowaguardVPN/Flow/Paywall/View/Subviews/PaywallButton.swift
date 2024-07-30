import UIKit
import AttributedString

final class PaywallButton: UIButton {
    
    private let label1 = UILabel()
    private let label2 = UILabel()
    private let image = UIImageView()
    private let labelsStack = UIStackView()
    
    override var isSelected: Bool {didSet { updateUI() }}
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8
        layer.borderColor = UIColor.appGreen.cgColor
    }
    
    init(period: String, priceLabelTextWhite: String, priceLabelTextGreen: String, isSelected: Bool) {
        super.init(frame: .zero)
        self.isSelected = isSelected
        
        backgroundColor = .appGraySpeedTestBack
        
        labelsStack.addArrangedSubviews([label1, label2])
        labelsStack.axis = .vertical
        labelsStack.alignment = .leading
        labelsStack.distribution = .fillEqually
        labelsStack.isUserInteractionEnabled = false
        
        addSubviews([labelsStack, image])
        
        label1.font = .systemFont(ofSize: .calc(16), weight: .bold)
        label1.textColor = .white
        label1.text = period
        
        label2.font = .systemFont(ofSize: .calc(16), weight: .medium)
        label2.textColor = .white
        let a: ASAttributedString = .init(string: priceLabelTextGreen, .font(.systemFont(ofSize: .calc(16), weight: .medium)),
                                                .foreground(.white))

        let b: ASAttributedString = .init(string: priceLabelTextWhite, .font(.systemFont(ofSize: .calc(16), weight: .medium)),
                                          .foreground(.appGreen))

        label2.attributed.text = b + a
        
        labelsStack.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(CGFloat.calc(16))
        }
        
        image.contentMode = .scaleAspectFit
        image.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(20)
        }
        
        
        updateUI()
    }
    
    func updateUI() {
        if isSelected {
            layer.borderWidth = 2
            image.image = I.Paywall.select
        } else {
            layer.borderWidth = 0
            image.image = I.Paywall.deselect
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
