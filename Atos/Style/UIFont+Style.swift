import UIKit

// TODO: make better fonts + dynamic type
extension UIFont {
    static func atosFont(ofSize size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
}
