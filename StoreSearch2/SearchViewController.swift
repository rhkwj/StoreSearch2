//
//  ViewController.swift
//  StoreSearch2
//
//  Created by Kim Yeon Jeong on 2018/10/2.
//  Copyright © 2018 Kim Yeon Jeong. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
  
    
    struct TableViewCellIdentifiers {
        static let searchResultCell = "SearchResultCell"
        static let nothingFoundCell = "NothingFoundCell"
    }
    
    var searchResults = [SearchResult]()
    var hasSearched = false
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if !searchBar.text!.isEmpty {
            searchBar.resignFirstResponder()
            hasSearched = true
            searchResults = []
            let url = iTunesURL(searchText: searchBar.text!)
            print("URL: '\(url)'")
            if let data = performStoreRequest(with: url) { // Modified
                searchResults = parse(data: data)
                searchResults.sort(by: <)
                }
                tableView.reloadData()
            }
        }
    
    func showNetworkError() {
        let alert = UIAlertController(title: "Whoops...",
            message: "There was an error accessing the iTunes Store." +
            " Please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        present(alert, animated: true, completion: nil)
        alert.addAction(action)
    }
    
    func performStoreRequest(with url: URL) -> Data? {
        do {
            return try Data (contentsOf: url)
        } catch {
            print("Download Error: \(error.localizedDescription)")
            showNetworkError()
            return nil
        }
    }
    
    // MARK:- Private Methods
    func iTunesURL(searchText: String) -> URL {
        let encodedText = searchText.addingPercentEncoding(
            withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = String(format:
            "https://itunes.apple.com/search?term=%@limit=200", encodedText)
        let url = URL(string: urlString)
        return url!
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0,bottom: 0, right: 0)
        var cellNib = UINib(nibName:
            TableViewCellIdentifiers.searchResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.searchResultCell)
        cellNib = UINib(nibName: TableViewCellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier:
            TableViewCellIdentifiers.nothingFoundCell)
        tableView.rowHeight = 80
        // Show keyboard
        searchBar.becomeFirstResponder()
    }

}

extension SearchViewController: UISearchBarDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasSearched {
            return 0
        } else if searchResults.count == 0 {
            return 1
        } else {
            return searchResults.count
        }
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if searchResults.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier:
                TableViewCellIdentifiers.nothingFoundCell, for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.searchResultCell, for: indexPath) as! SearchResultCell
            let searchResult = searchResults[indexPath.row]
            cell.nameLabel.text = searchResult.name
            if searchResult.artistName.isEmpty {
                cell.artistNameLabel.text = "Unknown"
            } else {
                cell.artistNameLabel.text = String(format: "%@ (%@)", searchResult.artistName, searchResult.type)
            }
            return cell
        } }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func parse(data: Data) -> [SearchResult] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self, from:data)
            return result.results
        } catch {
            print("JSON Error: \(error)")
            return [] }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
    
}
