//
//  FeedTableViewDelegate.swift
//  Atos
//
//  Created by Piotr Debosz on 21/04/2023.
//

import UIKit

protocol FeedUITableViewDelegateDelegate: AnyObject {
    func userDidScrollToBottom()
    func userPressedCell(at indexPath: IndexPath)
}

class FeedUITableViewDelegate: NSObject, UITableViewDelegate {
    weak var delegate: FeedUITableViewDelegateDelegate?

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
