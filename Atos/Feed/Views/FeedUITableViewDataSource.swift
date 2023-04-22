//
//  FeedViewControllerDataSource.swift
//  Atos
//
//  Created by Piotr Debosz on 21/04/2023.
//

import UIKit

class FeedUITableViewDataSource: NSObject, UITableViewDataSource {
    private var viewModels: [ArticleListCellViewModelType] = []

    func update(viewModels: [ArticleListCellViewModelType]) {
        self.viewModels = viewModels
    }

    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ArticleCell.self, for: indexPath)

        let viewModel = viewModels[indexPath.row]

        cell.configure(author: viewModel.author, title: viewModel.title)

        return cell
    }
}
