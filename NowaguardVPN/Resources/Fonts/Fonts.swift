import UIKit

extension UIFont {
    enum GilroyStyle {
        case bold
//        case boldItalic
//        case regular
//        case regularItalic
    }
    
    static func Gilroy(_ style: GilroyStyle, _ size: CGFloat) -> UIFont {
        var font: UIFont?
        switch style {
        case .bold: font = UIFont(name: "Gilroy-Bold", size: .calc(size))
//        case .boldItalic: font = UIFont(name: "Gilroy-BoldItalic", size: .calc(size))
//        case .regular: font = UIFont(name: "Gilroy-Regular", size: .calc(size))
//        case .regularItalic: font = UIFont(name: "Gilroy-RegularItalic", size: .calc(size))
        }
        
        guard let font else { return UIFont.systemFont(ofSize: 3, weight: .medium) }
        return font
    }
    
    static func BebasNeue(_ size: CGFloat) -> UIFont {
        UIFont(name: "BebasNeueBold", size: .calc(size))!
    }
}

extension CGFloat {
    ///hieght screen in figma 852
    static func calc(_ sizeInFigma: CGFloat) -> CGFloat {
        let ratio = 852 / sizeInFigma
        return UIScreen.main.bounds.height / ratio
    }
}
