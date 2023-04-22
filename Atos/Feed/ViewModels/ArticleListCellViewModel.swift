//
//  ArticleListCellViewModel.swift
//  Atos
//
//  Created by Piotr Debosz on 21/04/2023.
//

import Foundation

protocol ArticleListCellViewModelType {
    var author: String { get }
    var title: String { get }
}

struct ArticleListCellViewModel: ArticleListCellViewModelType {
    private let tempAuthor: String?
    let title: String

    init(author: String?, title: String) {
        tempAuthor = author
        self.title = title
    }

    // TODO: refactor
    var author: String {
        if let author = tempAuthor, !author.isEmpty {
            return author
        }

        return "Anonim"
    }
}
