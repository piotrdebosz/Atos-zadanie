import UIKit

class AccountViewController: UIViewController, CastView {
    typealias CastView = AccountView

    private let viewModel: AccountViewModelType

    init(viewModel: AccountViewModelType) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        configureTabBarItem()
    }

    override func loadView() {
        view = AccountView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureView()
    }

    private func configureNavigationBar() {
        navigationItem.title = viewModel.userName
        navigationController?.navigationBar.applyAtosStyling()
    }

    private func configureView() {
        castView.avatarImageView.image = UIImage(named: viewModel.avatarName)
        castView.usernameLabel.text = viewModel.userName
        castView.lastLoginLabel.text = viewModel.lastLogin

        castView.usernameLabel.accessibilityLabel = "Name: \(viewModel.userName)"
        castView.lastLoginLabel.accessibilityLabel = "Last login: \(viewModel.lastLogin)"
    }

    private func configureTabBarItem() {
        tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tab_user"), selectedImage: nil)
        tabBarItem.accessibilityLabel = "User Profile"
        tabBarItem.accessibilityIdentifier = "tabBarItem_account"
        tabBarItem.isAccessibilityElement = true
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
