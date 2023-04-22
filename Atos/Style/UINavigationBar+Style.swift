import UIKit

extension UINavigationBar {
    func applyAtosStyling() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .backgroundColor
        
        let backBarButtonAppearance = UIBarButtonItemAppearance()
        backBarButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.backButtonColor]
        
        
        let image = UIImage(systemName: "chevron.backward")?.withTintColor(.backButtonColor, renderingMode: .alwaysOriginal)
        appearance.setBackIndicatorImage(image, transitionMaskImage: image)
        
        appearance.backButtonAppearance = backBarButtonAppearance
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
    }
}
