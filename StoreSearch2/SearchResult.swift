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
    var kind: String?
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
        case itemGenre = "primaryGenreName"
        case bookGenre = "genres"
        case itemPrice = "price"
        case kind, artistName, currency
        case trackName, trackPrice, trackViewUrl
        case collectionName, collectionViewUrl, collectionPrice
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
    
    var type:String {
        let kind = self.kind ?? "audiobook"
        switch kind {
        case "album":
            return NSLocalizedString("Album",
                            comment: "Localized kind: Album")
        case "audiobook":
            return NSLocalizedString("Audio Book",
                            comment: "Localized kind: Audio Book")
        case "book":
            return NSLocalizedString("E-Book",comment: "Localixaed kind: E-Book")
        case "music-video":
            return NSLocalizedString("Music Video",comment: "Localized kind: Music Video")
        case "podcast":
            return NSLocalizedString("Podcast",comment: "Localized kind: Podcast")
        case "software":
            return NSLocalizedString("App",comment: "Localized kind: Software")
        case "song":
              return NSLocalizedString("Song",comment: "Localized kind: Song")
        case "tv-episode":
              return NSLocalizedString("TV Episode", comment: "Localized kind: TV Episode")
              
        default:
            return kind
        }
    }
    
    var genre:String {
        if let genre = itemGenre {
            return genre
        } else if let genres = bookGenre {
            return genres.joined(separator: ", ")
        }
        return "" }
}

func < (lhs: SearchResult, rhs: SearchResult) -> Bool {
    return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
}


