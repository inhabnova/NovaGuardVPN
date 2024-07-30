import UIKit
import AttributedString

final class PaywallTitleLabel: UILabel {
    
    init(whiteText: String, greenText: String) {
        super.init(frame: .zero)
        
        let a: ASAttributedString = .init(string: whiteText.uppercased() + " ", .font(.systemFont(ofSize: .calc(32), weight: .bold)),
                                                .foreground(.white))

        let b: ASAttributedString = .init(string: greenText.uppercased(), .font(.systemFont(ofSize: .calc(32), weight: .bold)),
                                          .foreground(.appGreen))

        self.attributed.text = a + b
        self.textAlignment = .center
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
