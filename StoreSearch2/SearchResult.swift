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
    var trackName = ""
    var trackPrice = 0.0
    var currency = ""
    
    var imageSmall = ""
    var imageLarge = ""
    var storeURL = ""
    var genre = ""
    enum CodingKeys: String, CodingKey {
        case imageSmall = "artworkUrl60"
        case imageLarge = "artworkUrl100"
        case storeURL = "trackViewUrl"
        case genre = "primaryGenreName"
        case kind, artistName, trackName
        case trackPrice, currency
    }
    
    var name:String {
        return trackName
    }
    
    var description:String {
        return "Kind: \(kind ?? ""), Name: \(name), Artist Name: \(artistName)\n"
    }
}
