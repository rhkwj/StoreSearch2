//
//  Search.swift
//  StoreSearch2
//
//  Created by Kim Yeon Jeong on 2018/10/22.
//  Copyright © 2018 Kim Yeon Jeong. All rights reserved.
//

import Foundation
import UIKit

typealias SearchComplete = (Bool) -> Void

class Search {
    enum State {
        case notSearchedYet
        case loading
        case noResults
        case results([SearchResult])
    }
    enum Category: Int {
        case all = 0
        case music = 1
        case software = 2
        case ebooks = 3
        var type: String {
            switch self {
            case .all: return ""
            case .music: return "musicTrack"
            case .software: return "software"
            case .ebooks: return "ebook"
            }
            
        }
    }
    
    private var dataTask: URLSessionDataTask? = nil
    private(set) var state: State = .notSearchedYet
    
   // func performSearch(for text: String, category: Int) {
   //print("Searching...")
   // }
    
    func performSearch(for text: String, category: Category,
                       completion: @escaping SearchComplete) {
        if !text.isEmpty {
            dataTask?.cancel()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            state = .loading
            
            let url = iTunesURL(searchText: text, category: category)
            let session = URLSession.shared
            
            dataTask = session.dataTask(with: url, completionHandler: {
                data, response, error in
                var newState = State.notSearchedYet
                var success = false
                // Was the search cancelled?
                if let error = error as NSError?, error.code == -999 {
                    return
                }
                if let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200, let data = data {
                    // Replace all code within this if block with following
                    var searchResults = self.parse(data: data)
                    if searchResults.isEmpty {
                        newState = .noResults
                    } else {
                        searchResults.sort(by: <)
                        newState = .results(searchResults)
                    }
                    success = true
                }
            
                DispatchQueue.main.async {
                    self.state = newState
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    completion(success)
                }
            })
            dataTask?.resume()
        }
    }
    
    // MARK:- Private Methods
    private func iTunesURL(searchText: String,
                           category: Category) -> URL {
        let kind = category.type
        let encodedText = searchText.addingPercentEncoding(
            withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = "https://itunes.apple.com/search?" +
        "term=\(encodedText)&limit=200&entity=\(kind)"
        let url = URL(string: urlString)
        return url!
    }
    
    func parse(data: Data) -> [SearchResult] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self, from:data)
            return result.results
        } catch {
            print("JSON Error: \(error)")
            return []
        }
    }
}




