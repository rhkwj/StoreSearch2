//
//  SearchResultCell.swift
//  StoreSearch2
//
//  Created by Kim Yeon Jeong on 2018/10/4.
//  Copyright © 2018 Kim Yeon Jeong. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!

    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 0.5)
        selectedBackgroundView = selectedView
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    
    // MARK:- Public Methods
    func configure(for result: SearchResult) {
        nameLabel.text = result.name
        if result.artistName.isEmpty {
            artistNameLabel.text = NSLocalizedString("Unknown", comment:"Artist Name Label")
        } else {
            artistNameLabel.text = String(format:
                NSLocalizedString("%@ (%@)",
                                  comment: "Format for artist name"),
                                          result.artistName, result.type)
        }
        artworkImageView.image = UIImage(named: "Placeholder")
        if let smallURL = URL(string: result.imageSmall) {
            downloadTask = artworkImageView.loadImage(url: smallURL)
        }
        
    }
    
}
