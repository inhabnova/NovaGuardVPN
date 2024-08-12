import UIKit

class Vor2_btn: UIButton {
    
    private let label = UILabel()
    
    init(leftColor: UIColor, rightColor: UIColor, title: String) {
        super.init(frame: .zero)
        setupGradient(startColor: leftColor, endColor: rightColor)
        
        addTarget(self, action: #selector(bunceAnimatiion), for: .touchUpInside)
        
        label.text = title
        label.textColor = .white
        label.font = .systemFont(ofSize: .calc(18), weight: .medium)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Обновляем фрейм градиента при изменении размера кнопки
        if let gradientLayer = self.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = self.layer.cornerRadius
        }
//        self.layer.cornerRadius = self.bounds.height / 3.75
    }
}

// MARK: - Private

private extension Vor2_btn {
    private func setupGradient(startColor: UIColor, endColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [endColor.cgColor, startColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.masksToBounds = true
        
        // Добавляем градиент на кнопку
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        // Чтобы градиент обновлялся при изменении размера кнопки
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
    
    @objc func bunceAnimatiion() {
        
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
    
}
