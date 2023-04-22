import UIKit

// TODO: Change name and move to another file
protocol FeedUITableViewDelegateDelegate: AnyObject {
    func userDidScrollToBottom()
    func userPressedCell(at indexPath: IndexPath)
}

class FeedUITableViewDelegate: NSObject, UITableViewDelegate {
    weak var delegate: FeedUITableViewDelegateDelegate?

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // TODO: add more verbose names
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height {
            delegate?.userDidScrollToBottom()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        delegate?.userPressedCell(at: indexPath)
    }
}
