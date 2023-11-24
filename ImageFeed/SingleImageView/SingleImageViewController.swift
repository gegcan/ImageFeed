//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 23.11.2023.
//

import UIKit

final class SingleImageViewController: UIViewController {
    var image: UIImage! {
        didSet {
            guard isViewLoaded else { return }
            imageView.image = image
        }
    }
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
    @IBAction private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
}
