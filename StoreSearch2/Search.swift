//
//  Search.swift
//  StoreSearch2
//
//  Created by Kim Yeon Jeong on 2018/10/22.
//  Copyright © 2018 Kim Yeon Jeong. All rights reserved.
//

import Foundation

class Search {
    var searchResults: [SearchResult] = []
    var hasSearched = false
    var isLoading = false
    private var dataTask: URLSessionDataTask? = nil
    func performSearch(for text: String, category: Int) {
        print("Searching...")
    }
}
