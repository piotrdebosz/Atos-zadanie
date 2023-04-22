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

        navigationItem.title = viewModel.userName

        updateView()
    }

    private func updateView() {
        castView.avatarImageView.image = UIImage(named: viewModel.avatarName)
        castView.usernameLabel.text = viewModel.userName
        castView.lastLoginLabel.text = viewModel.lastLogin
    }

    private func configureTabBarItem() {
        // TODO: change image
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular, scale: .small)

        let accountTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "person", withConfiguration: imageConfiguration),
            tag: 1
        )

        tabBarItem = accountTabBarItem
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
