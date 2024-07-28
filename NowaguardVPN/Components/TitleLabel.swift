import UIKit
import AttributedString

final class TitleLabel: UILabel {
    
    init(whiteText: String, greenText: String) {
        super.init(frame: .zero)
        
        let a: ASAttributedString = .init(string: whiteText.uppercased() + " ", .font(.BebasNeue(.calc(22))),
                                                .foreground(.white))

        let b: ASAttributedString = .init(string: greenText.uppercased(), .font(.BebasNeue(.calc(22))),
                                          .foreground(.appGreen))

        self.attributed.text = a + b
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
