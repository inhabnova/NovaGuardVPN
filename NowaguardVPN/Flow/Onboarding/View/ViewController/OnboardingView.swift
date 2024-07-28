import UIKit

protocol OnboardingView: AnyObject {
    func updateView(title: String, subtitle: String, backgroundImageView: UIImage, pageControlImageView: UIImage)
}

