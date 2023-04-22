import UIKit

extension UINavigationBar {
    func applyAtosStyling() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .atosBackgroundColor
        appearance.backButtonAppearance = createAndConfigureBackButtonAppearance(appearance)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        standardAppearance = appearance
        scrollEdgeAppearance = appearance
    }

    private func createAndConfigureBackButtonAppearance(_ navigationBarAppearance: UINavigationBarAppearance) -> UIBarButtonItemAppearance {
        let backBarButtonAppearance = UIBarButtonItemAppearance()
        backBarButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.atosBackButtonColor]

        let image = UIImage(systemName: "chevron.backward")?
            .withTintColor(.atosBackButtonColor, renderingMode: .alwaysOriginal)
        navigationBarAppearance.setBackIndicatorImage(image, transitionMaskImage: image)

        return backBarButtonAppearance
    }
}
