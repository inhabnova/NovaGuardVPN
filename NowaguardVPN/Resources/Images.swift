import UIKit

typealias I = Images

enum Images {
    
    /// name - название картинки с флагом! 
    static func getFlug(name: String) -> UIImage? {
        UIImage(named: name)
    }
    
    enum Onboarding {
        
        static let OnboardingBackbround1 = UIImage(named: "OnboardingBackbround1")!
        static let OnboardingBackbround2 = UIImage(named: "OnboardingBackbround2")!
        static let OnboardingBackbround3 = UIImage(named: "OnboardingBackbround3")!
        
        static let OnboardingPageControl1 = UIImage(named: "OnboardingPageControl1")!
        static let OnboardingPageControl2 = UIImage(named: "OnboardingPageControl2")!
        static let OnboardingPageControl3 = UIImage(named: "OnboardingPageControl3")!
        
    }
    
    enum SelectCountry {
        
        static let backButton = UIImage(named: "backButton")!
        static let selectedCountry = UIImage(named: "selectedCountry")!
        static let deselectedCountry = UIImage(named: "deselectedCountry")!
        static let isPremiumServer = UIImage(named: "isPremiumServer")!
        
    }
}
