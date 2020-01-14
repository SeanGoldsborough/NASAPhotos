//
//  ViewController.swift
//  NASAPhotos
//
//  Created by Sean Goldsborough on 1/12/20.
//  Copyright © 2020 Sean Goldsborough. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    
    enum Section {
        case main
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let cellId = "cellid"
    var items = [Items]()
    var page = 1
    var hasMoreImages = true
    var dataSource: UICollectionViewDiffableDataSource<Section, Items>!
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Items>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getItems(page: page)
    
        configureDataSource()
        collectionView.delegate = self
        
        collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .blue
        collectionView.collectionViewLayout = FlowLayoutHelper.createThreeColumnFlowLayout(in: self.view)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.title = "NASA Photos"
        
        performUpdatesOnMain {
            self.activityIndicator.startAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func getItems(page: Int) {
        NetworkManager.shared.getItemsData(page: page) { result in
            
            switch result {
                case .success(let resultItems):
                    if resultItems.count < 100 { self.hasMoreImages = false }
                    self.items.append(contentsOf: resultItems)
                    self.updateData()
                    performUpdatesOnMain {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                    }
                case .failure(let error):
                    performUpdatesOnMain {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        AlertView.alertPopUp(view: self, alertMessage: "Error: \(error.rawValue)")
                    }
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Items>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, items) -> PhotoCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseID, for: indexPath) as! PhotoCell
            self.currentSnapshot = NSDiffableDataSourceSnapshot<Section, Items>()
            performUpdatesOnMain {
                cell.set(item: items, index: indexPath.row)
                cell.itemImageView.loadImageUsingCacheWithUrlString(urlString: items.links?[0].href ?? "")
            }
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Items>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        performUpdatesOnMain {
            self.dataSource?.apply(snapshot, animatingDifferences: true)
        }        
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
//    //TODO: DO you really need this one?
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        //let photo = items[indexPath.row]
//        let collViewCell = cell as! PhotoCell
//        //collViewCell.avatarImageView.image = UIImage(data: URL(string: photo.href)
//       // var url = photo.links?[indexPath.row].href ?? "N/A"
//
//        //TODO: configCollViewCellImage here
//        performUpdatesOnMain {
//           // self.configImage(url: url, cell: collViewCell)
//            //self.configImage(cell: collViewCell, photo: photo, collectionView: collectionView, indexPath: indexPath)
//        }
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        self.pushDetailView(item: items[indexPath.row])
    }
    
    func pushDetailView(item: Items) {
        let controller =  self.storyboard!.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        controller.item = item
        self.navigationController?.pushViewController(controller, animated:true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreImages else { return }
            page += 1
            getItems(page: page)
            print("items.count is:", items.count)
        }
    }
}

