import UIKit

class ArticleDetailViewController: UIViewController, CastView, Alertable {
    typealias CastView = ArticleDetailView

    private let viewModel: ArticleDetailViewModelType

    weak var delegate: ArticleDetailViewControllerDelegate?

    init(viewModel: ArticleDetailViewModelType) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        self.viewModel.delegate = self
    }

    override func loadView() {
        view = ArticleDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = viewModel.author

        updateUI()

        viewModel.viewDidLoad()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        delegate?.viewDidDisappear()
    }

    private func updateUI() {
        castView.authorLabel.text = viewModel.author
        castView.authorLabel.accessibilityLabel = "Author: \(viewModel.author)"

        castView.titleLabel.text = viewModel.title
        castView.titleLabel.accessibilityLabel = "Title: \(viewModel.title)"

        castView.descriptionLabel.text = viewModel.description
        castView.descriptionLabel.accessibilityLabel = "Description: \(viewModel.description)"

        castView.publishedAtLabel.text = viewModel.publishedAt
        castView.publishedAtLabel.accessibilityLabel = "Published at: \(viewModel.publishedAt)"
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ArticleDetailViewController: ArticleDetailViewModelDelegate {
    func didChangeImageLoadingState() {
        castView.imageView.setLoading(isLoading: viewModel.isImageLoading)
    }

    func didLoadImage() {
        if let imageData = viewModel.imageData {
            castView.imageView.image = UIImage(data: imageData)
        } else {
            castView.imageView.image = nil
        }
    }
}
