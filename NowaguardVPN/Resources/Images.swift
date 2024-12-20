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
    
    enum Main {
        
        static let mainBackbroundOff = UIImage(named: "mainBackbroundOff")!
        static let mainBackbroundOn = UIImage(named: "mainBackbroundOn")!
        static let countryButtonRightArrow = UIImage(named: "countryButtonRightArrow")!
        
    }
    
    enum SpeedTest {
        static let backgroundSpeedTest = UIImage(named: "backgroundSpeedTest")!
        static let button1 = UIImage(named: "button1SpeedTest")!
        static let button2 = UIImage(named: "button2SpeedTest")!
        static let button3 = UIImage(named: "button3SpeedTest")!
        static let shadowSpeedTest = UIImage(named: "shadowSpeedTest")!
        static let upload = UIImage(named: "upload")!
        static let download = UIImage(named: "download")!
        static let vSeparator = UIImage(named: "vSeparator")!
        
    }
    
    enum Settings {
        static let backgroundSettings = UIImage(named: "backgroundSettings")!
        
        static let Button1Image = UIImage(named: "Button1Image")!
        static let Button2Image = UIImage(named: "Button2Image")!
        static let Button3Image = UIImage(named: "Button3Image")!
        static let Button4Image = UIImage(named: "Button4Image")!
        static let Button5Image = UIImage(named: "Button5Image")!
        static let separator = UIImage(named: "separator")!
        
    }
    
    enum Paywall {
        
        static let refresh = UIImage(named: "refresh")!
        static let close = UIImage(named: "close")!
        static let background = UIImage(named: "background")!
        static let select = UIImage(named: "select")!
        static let deselect = UIImage(named: "deselect")!
        static let checkMark = UIImage(named: "checkMark")!
        
    }
    
    enum Vor {
        
        static let v1_2 = UIImage(named: "v1_2")!
        static let v1_31 = UIImage(named: "v1_31")!
        static let v1_32 = UIImage(named: "v1_32")!
        static let v1_4 = UIImage(named: "v1_4")!
        static let v1_5 = UIImage(named: "v1_5")!
        static let v1_last = UIImage(named: "v1_last")!
        static let v1_31gr = UIImage(named: "v1_31gr")!
        static let v1_32gr = UIImage(named: "v1_32gr")!
        static let v2_2 = UIImage(named: "v2_2")!
        static let v2_21 = UIImage(named: "v2_21")!
        static let v2_41 = UIImage(named: "v2_41")!
        static let v2_43 = UIImage(named: "v2_43")!
        static let v2_42 = UIImage(named: "v2_42")!
        static let v2_f = UIImage(named: "v2_f")!
        static let v2_s = UIImage(named: "v2_s")!
        
    }
}
