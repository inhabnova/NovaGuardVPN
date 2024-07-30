import UIKit

final class GreenButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        backgroundColor = .appGreen
        setTitle(title.uppercased(), for: .normal)
        setTitleColor(.appGray, for: .normal)
        titleLabel?.font = .Gilroy(.bold, .calc(18))
    }
    
    func setGrayBackground(title: String) {
        backgroundColor = .appGrayProgress
        setTitle(title.uppercased(), for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .Gilroy(.bold, .calc(18))
    }
    
    func updateTitle(title: String) {
        backgroundColor = .appGreen
        setTitle(title.uppercased(), for: .normal)
        setTitleColor(.appGray, for: .normal)
        titleLabel?.font = .Gilroy(.bold, .calc(18))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }
}
