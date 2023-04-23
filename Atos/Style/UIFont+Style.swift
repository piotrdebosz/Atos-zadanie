import UIKit

extension UIFont {
    static func atosFont(ofSize size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: .body)
        let font = UIFont.systemFont(ofSize: size, weight: weight)

        // Handle dynamic type
        return metrics.scaledFont(for: font)
    }
}
