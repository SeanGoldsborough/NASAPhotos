//
//  PhotoCell.swift
//  NASAPhotos
//
//  Created by Sean Goldsborough on 1/8/20.
//  Copyright © 2020 Sean Goldsborough. All rights reserved.
//

import Foundation
import UIKit

class PhotoCell: UICollectionViewCell {
    
    static let reuseID = "cellid"
    let itemImageView = ItemImageView(frame: .zero)
    let placeholderImageURL = "https://images-assets.nasa.gov/image/PIA01717/PIA01717~thumb.jpg"
    
    var item: Items? {
        didSet {
            itemImageView.loadImageUsingCacheWithUrlString(urlString: item?.links?[0].href ?? placeholderImageURL)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(item: Items?, index: Int) {
        guard let item = item else { return }
    }
    
    override var isHighlighted: Bool {
        didSet{
            var transform = CGAffineTransform.identity
            if isHighlighted {
               transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }
            
            UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .curveEaseOut, animations: {
                self.transform = transform
            })
        }
    }
    
    private func configure() {
        addSubview(itemImageView)
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            itemImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor),

        ])
    }
}
