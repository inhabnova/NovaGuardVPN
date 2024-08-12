import UIKit
import AttributedString

protocol Content_vor1Delegate: AnyObject {
    func finish()
    func finish1()
}

final class Content_vor1: UIView {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private var count = 1
    private var period: Int!
    
    weak var delegate: Content_vor1Delegate?
    private let subtitles: [String]
    
    init(image: UIImage, title: String, subtitles: [String]) {
        self.subtitles = subtitles
        super.init(frame: .zero)
        
        addSubviews([imageView, titleLabel, subtitleLabel])
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.width.height.equalTo(CGFloat.calc(32))
        }
        
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: .calc(17), weight: .medium)
        titleLabel.numberOfLines  = 0
        titleLabel.snp.makeConstraints {
            $0.top.right.equalToSuperview()
            $0.left.equalTo(imageView.snp.right).inset(-20)
        }
        
        subtitleLabel.text = subtitles[0]
        subtitleLabel.textColor = .red
        subtitleLabel.font = .systemFont(ofSize: .calc(15), weight: .regular)
        subtitleLabel.numberOfLines  = 0
        subtitleLabel.textAlignment = .left
        subtitleLabel.snp.makeConstraints {
            $0.bottom.right.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.left.equalTo(imageView.snp.right).inset(-20)
        }
        
        update()
        
        func update() {
            guard count < subtitles.count else { 
                delegate?.finish()
                count = 0
                return
            }
            period = Int.random(in: 0...1500)
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(period)) { [weak self] in
                guard let self else { return }
                if count > 4 {
                    var newTest = self.subtitleLabel.text?.components(separatedBy: "\n")
                    newTest?.remove(at: 0)
                    self.subtitleLabel.text? = newTest?.reduce("") { result, string in
                        result + string
                    } ?? ""
                    self.subtitleLabel.text? += "\n" + subtitles[count]
                    self.subtitleLabel.text? += "\n" + "\(count - 2) " + "More"
                } else {
                    self.subtitleLabel.text? += "\n" + subtitles[count]
                }
                self.count += 1
                self.titleLabel.text = title + "(\(self.count))"
                update()
            }
        }
    }
    
    func toGreen() {
        guard count < subtitles.count else {
            self.subtitleLabel.textColor = .green
            delegate?.finish1()
            return
        }
        
        period = Int.random(in: 0...1500)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(period)) { [weak self] in
            guard let self else { return }
            
            switch count {
            case 0:
                let greenText: ASAttributedString = .init(string: subtitles[count], .foreground(.green))
                let redTexts: String = "\n" + subtitles[1] + "\n" + subtitles[2] + "\n" + subtitles[3] + "\n" + "\(count - 2) " + "More"
                let redText: ASAttributedString = .init(string: redTexts, .foreground(.red))
                self.subtitleLabel.attributed.text = greenText + redText
            case 1:
                let greenTexts: String = subtitles[0] + "\n" + subtitles[1]
                let greenText: ASAttributedString = .init(string: greenTexts, .foreground(.green))
                let redTexts: String = "\n" + subtitles[2] + "\n" + subtitles[3] + "\n" + "\(count - 2) " + "More"
                let redText: ASAttributedString = .init(string: redTexts, .foreground(.red))
                self.subtitleLabel.attributed.text = greenText + redText
            case 2:
                let greenTexts: String = subtitles[0] + "\n" + subtitles[1] + "\n" + subtitles[2]
                let greenText: ASAttributedString = .init(string: greenTexts, .foreground(.green))
                let redTexts: String = "\n" + subtitles[3] + "\n" + "\(count - 2) " + "More"
                let redText: ASAttributedString = .init(string: redTexts, .foreground(.red))
                self.subtitleLabel.attributed.text = greenText + redText
            case 4:
                let greenTexts: String = subtitles[0] + "\n" + subtitles[1] + "\n" + subtitles[2] + "\n" + subtitles[3]
                let greenText: ASAttributedString = .init(string: greenTexts, .foreground(.green))
                let redTexts: String = "\n" + "\(count - 2) " + "More"
                let redText: ASAttributedString = .init(string: redTexts, .foreground(.red))
                self.subtitleLabel.attributed.text = greenText + redText
            default:
                let greenTexts: String = subtitles[0] + "\n" + subtitles[1] + "\n" + subtitles[2] + "\n" + subtitles[3] + "\n" + "\(count - 2) "
                let greenText: ASAttributedString = .init(string: greenTexts, .foreground(.green))
                let redTexts: String = "More"
                let redText: ASAttributedString = .init(string: redTexts, .foreground(.red))
                self.subtitleLabel.attributed.text = greenText + redText
            }
            count += 1
            toGreen()
        }
    }
    
    func updateImage(_ newImage: UIImage) {
        self.imageView.image = newImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
