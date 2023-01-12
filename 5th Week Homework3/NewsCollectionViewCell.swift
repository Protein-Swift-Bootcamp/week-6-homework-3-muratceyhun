//
//  NewsCollectionViewCell.swift
//  5th Week Homework3
//
//  Created by Murat Ceyhun Korpeoglu on 11.01.2023.
//

import UIKit

class NewsCollectionViewCellViewModel {
    let author: String
    let title: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(author: String, title: String, imageURL: URL?) {
        self.author = author
        self.title = title
        self.imageURL = imageURL
    }
}


class NewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        authorLabel.text = nil
        titleLabel.text = nil
        imageView.image = nil
    }
    
    func configure(with viewModel: NewsCollectionViewCellViewModel ) {
        authorLabel.text = viewModel.author
        titleLabel.text = viewModel.title
        
        // Image
        
        if let data = viewModel.imageData {
            imageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            //fetch
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {return}
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            } .resume()
        }
        
    }
    
}
