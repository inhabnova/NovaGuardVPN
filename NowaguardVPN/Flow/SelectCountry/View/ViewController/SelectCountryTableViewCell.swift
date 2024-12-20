import UIKit

final class SelectCountryTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    static let identifier = "SelectCountryTableViewCell"
    static let flugImageViewSize: Double = 40
    
    // MARK: - UI Elements
    
    private let flugImageView = UIImageView()
    private let label = UILabel()
    private let premiumServerImageView = UIImageView()
    private let isSelectedImageView = UIImageView()
    
    var server: Server!
    
    // MARK: - Configure
    
    func configure(with server: Server, isSelected: Bool) {
        
        self.server = server
        
        flugImageView.image = I.getFlug(name: server.country)
        flugImageView.contentMode = .scaleAspectFill
        label.text = server.name
        premiumServerImageView.image = !server.premium ? nil : I.SelectCountry.isPremiumServer
        isSelectedImageView.image = isSelected ? I.SelectCountry.selectedCountry : I.SelectCountry.deselectedCountry
        
        backgroundColor = .appGray
        selectionStyle = .none
        
        addSubviews([flugImageView, label, premiumServerImageView, isSelectedImageView])
        
        flugImageView.contentMode = .scaleAspectFit
        premiumServerImageView.contentMode = .scaleAspectFit
        isSelectedImageView.contentMode = .scaleAspectFit
        label.font = .systemFont(ofSize: .calc(16), weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        
        
        flugImageView.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.height.width.equalTo(SelectCountryTableViewCell.flugImageViewSize)
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalTo(flugImageView.snp.centerY)
            $0.left.equalTo(flugImageView.snp.right).inset(-20)
        }
        
        premiumServerImageView.snp.makeConstraints {
            $0.centerY.equalTo(flugImageView.snp.centerY)
            $0.width.height.equalTo(SelectCountryTableViewCell.flugImageViewSize / 1.6)
            $0.right.equalTo(isSelectedImageView.snp.left).inset(-20)
        }
        
        isSelectedImageView.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.centerY.equalTo(flugImageView.snp.centerY)
            $0.width.height.equalTo(SelectCountryTableViewCell.flugImageViewSize / 1.6)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flugImageView.layer.cornerRadius = flugImageView.frame.height / 2
        flugImageView.layer.masksToBounds = true
    }
    
}
