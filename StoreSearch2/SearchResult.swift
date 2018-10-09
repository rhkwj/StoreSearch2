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
class SearchResult:Codable {
    var artistName = ""
    var trackName = ""
    var name:String {
        return trackName
    }
}
