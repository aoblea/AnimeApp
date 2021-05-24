//
//  HomeViewController.swift
//  AnimeApp
//
//  Created by Arwin Oblea on 5/13/21.
//  Copyright © 2021 iarwinscott. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {

  // MARK: - Properties
  private var animeCollectionView: UICollectionView? = nil
  let flowLayout = UICollectionViewFlowLayout()
  private lazy var client = APIClient.sharedInstance
  
  var animeList = [Anime]()
  var fetchedResponse: AnimeResponse?
  
  // MARK: View
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "ANIME APP"
    
    configureCollectionView()
    loadAnime()
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    flowLayout.invalidateLayout()
  }
  
}

// MARK: - Helper Methods
extension HomeViewController {
  private func loadAnime() {
    client.fetchAnimes { [unowned self] (animes, error) in
      guard let animesData = animes?.data else { return }
      if let err = error {
        // Do some error handling here
        print(err.localizedDescription)
      }
      fetchedResponse = animes
      animeList.append(contentsOf: animesData)
      refreshCollectionView()
    }
  }
}

// MARK: - CollectionView Helper Methods
extension HomeViewController {
  private func configureCollectionView() {
    flowLayout.scrollDirection = .vertical
    
    let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
    view.addSubview(collectionView)
    collectionView.backgroundColor = .systemGroupedBackground
    self.animeCollectionView = collectionView
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(AnimeCollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    ])
  }
  
  private func refreshCollectionView() {
    DispatchQueue.main.async {
      self.animeCollectionView?.reloadData()
    }
  }
}

// MARK: - CollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return animeList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? AnimeCollectionViewCell else { return UICollectionViewCell() }
    
    let anime = animeList[indexPath.row]
    cell.configureCell(using: anime)
    
    if anime.imageState == .placeholder {
      anime.imageState = .downloading
      
      cell.activityIndicatorView.startAnimating()
      
      client.loadImage(using: anime) { [unowned self] (image) in
        cell.activityIndicatorView.stopAnimating()
        anime.image = image
        anime.imageState = .finished
        refreshCollectionView()
      }
    }
    
    return cell
  }

}

// MARK: - CollectionViewDelegate / CollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.frame.width/2, height: self.view.frame.width/2)
  }
}

