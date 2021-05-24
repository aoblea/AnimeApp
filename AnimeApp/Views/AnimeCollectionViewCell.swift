//
//  AnimeCollectionViewCell.swift
//  AnimeApp
//
//  Created by Arwin Oblea on 5/16/21.
//  Copyright © 2021 iarwinscott. All rights reserved.
//

import UIKit

class AnimeCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  let imageView: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  let activityIndicatorView: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView()
    indicator.style = .large
    indicator.color = UIColor.lightGray
    indicator.translatesAutoresizingMaskIntoConstraints = false
    return indicator
  }()
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureView()
  }
  
  private func configureView() {
    addSubview(imageView)
    imageView.addSubview(activityIndicatorView)

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      
      activityIndicatorView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
      activityIndicatorView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
    ])
  }

  // MARK: - Helper Method
  func configureCell(using anime: Anime) {
    if anime.imageState == .finished {
      imageView.image = anime.image
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
