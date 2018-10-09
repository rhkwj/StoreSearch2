//
//  SearchResult.swift
//  StoreSearch2
//
//  Created by Kim Yeon Jeong on 2018/10/3.
//  Copyright © 2018 Kim Yeon Jeong. All rights reserved.
//
import UIKit
import Foundation

class ResultArray:Codable {
    var resultCount = 0
    var results = [SearchResult]()
}
class SearchResult:Codable, CustomStringConvertible {
    var kind = String?
    var artistName = ""
    var trackName:String?
    var trackPrice:Double?
    var currency = ""
    var trackViewUrl:String?
    var collectionName:String?
    var collectionViewUrl:String?
    var collectionPrice:Double?
    var itemPrice:Double?
    var itemGenre:String?
    var bookGenre:[String]?
    var imageSmall = ""
    var imageLarge = ""
    
    enum CodingKeys: String, CodingKey {
        case imageSmall = "artworkUrl60"
        case imageLarge = "artworkUrl100"
        case storeURL = "trackViewUrl"
        case genre = "primaryGenreName"
        case itemPrice = "price"
        case kind, artistName, trackName
        case trackPrice, currency
    }
    
    var name:String {
        return trackName ?? collectionName ?? ""
    }
    
    var description:String {
        return "Kind: \(kind ?? ""), Name: \(name), Artist Name: \(artistName)\n"
    }
    
    var storeURL:String {
        return trackViewUrl ?? collectionViewUrl ?? ""
    }
    var price:Double {
        return trackPrice ?? collectionPrice ?? itemPrice ?? 0.0
    }
    var genre:String {
        if let genre = itemGenre {
            return genre
        } else if let genres = bookGenre {
            return genres.joined(separator: ", ")
        }
        return "" }
}
