//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 15.11.2023.
//

import UIKit

protocol ImagesListCellDelegate: AnyObject {
    func imagesListCellDidTapLike(_ cell: ImagesListCell)
}

public final class ImagesListCell: UITableViewCell {
    
    @IBOutlet private weak var imageCell: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var likeButton: UIButton!
    
    private let placeholderImage = UIImage(named: "stub")
    
    static let reuseIdentifier = "ImagesListCell"
    weak var delegate: ImagesListCellDelegate?
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        setIsLiked(false)
        imageCell.kf.cancelDownloadTask()
    }
    
    @IBAction func didTapLikeButton(_ sender: Any) {
        delegate?.imagesListCellDidTapLike(self)
    }
}

extension ImagesListCell {
    
    func setIsLiked(_ isLiked: Bool) {
        let likedImage = isLiked ? UIImage(named: "like_active_on") : UIImage(named: "like_active_off")
        likeButton.setImage(likedImage, for: .normal)
    }
    
    func loadCell(from photo: Photo) -> Bool {
        var status = false
        if let photoDate = photo.createdAt {
            dateLabel.text = Constants.dateFormatter.string(from: photoDate)
        }
        likeButton.accessibilityIdentifier = "LikeButton"
        setIsLiked(photo.isLiked)
        guard let photoURL = URL(string: photo.thumbImageURL) else { return status }
        imageCell.kf.indicatorType = .activity
        imageCell.kf.setImage(with: photoURL, placeholder: placeholderImage) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                status = true
            case .failure(let error):
                imageCell.image = placeholderImage
                print("ITS LIT ILC 68 \(error.localizedDescription)")
            }
        }
        return status
    }
}
