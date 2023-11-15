//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 15.11.2023.
//

import UIKit

class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
}
