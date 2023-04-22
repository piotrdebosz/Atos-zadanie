import UIKit

extension UITabBar {
    func applyAtosStyling() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .backgroundColor
        
        updateTabBarItemAppearance(appearance: tabBarAppearance.compactInlineLayoutAppearance)
        updateTabBarItemAppearance(appearance: tabBarAppearance.inlineLayoutAppearance)
        updateTabBarItemAppearance(appearance: tabBarAppearance.stackedLayoutAppearance)
        
        standardAppearance = tabBarAppearance
        scrollEdgeAppearance = tabBarAppearance
    }
    
    private func updateTabBarItemAppearance(appearance: UITabBarItemAppearance) {
        appearance.selected.iconColor = .white
        appearance.normal.iconColor = .black
    }

}
