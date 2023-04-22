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
    private let _author: String?
    let title: String
    
    init(author: String?, title: String) {
        _author = author
        self.title = title
    }
    
    // TODO: refactor
    var author: String {
        if let _author = _author, _author != "" {
            return _author
        }
        
        return "Anonim"
    }
}
