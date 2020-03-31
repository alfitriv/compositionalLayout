//
//  ViewController.swift
//  MakeupPicker
//
//  Created by Vania Radmila Alfitri on 19/03/20.
//  Copyright © 2020 Vania Radmila Alfitri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIActionSheetDelegate {
    var makeupStore = MakeupStore.shared
    var makeupList: [Makeup] = []
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    var sections = [ProductType.blush, ProductType.bronzer, ProductType.eyeBrow, ProductType.eyeLiner, ProductType.eyeShadow,ProductType.foundation]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Makeup List"
        progressIndicator.isHidden = false
        progressIndicator.startAnimating()
        makeupStore.fetchMakeUpList(successHandler: { [weak self] (makeup) in
            self?.progressIndicator.stopAnimating()
            self?.progressIndicator.isHidden = true
            print(makeup)
            self?.makeupList = makeup
            self?.collectionView.register(UINib(nibName: "MakeupCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
            self?.collectionView.reloadData()
            self?.collectionView.collectionViewLayout = self?.generateFlowLayout() as! UICollectionViewLayout
        }) { (error) in
            print(error)
        }
        
    }
    
    func generateFlowLayout() -> UICollectionViewLayout {
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(2/3)))
        
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let mainItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1.0)))
        
        mainItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let pairItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)))
        
        pairItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0)), subitem: pairItem, count: 2)
        
        
        let mainWithPairGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(4/9)), subitems: [mainItem, trailingGroup])
        
        let tripletItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1.0)))
        
        tripletItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
        
        let tripletGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(2/9)), subitem: tripletItem, count: 3)
        
        let mainWithPairReversedGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(4/9)),
            subitems: [trailingGroup, mainItem])
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(16/9)),
            subitems: [
                fullPhotoItem,
                mainWithPairGroup,
                tripletGroup,
                mainWithPairReversedGroup
            ]
        )
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
        
    }
    
    func generateSideBySideLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: fullPhotoItem, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func generateFullLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [fullPhotoItem])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
        
    }
    
    @IBAction func changeLayoutTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Change Layout", message: "Choose the following", preferredStyle: .actionSheet)
        let firstAction = UIAlertAction(title: "First Layout", style: .default, handler: { (action) in
            print("user clicked first action")
            self.collectionView.collectionViewLayout = self.generateFlowLayout()
            self.collectionView.reloadData()
        })
        let secondAction = UIAlertAction(title: "Second Layout", style: .default, handler: { (action) in
            self.collectionView.collectionViewLayout = self.generateSideBySideLayout()
            self.collectionView.reloadData()
        })
        let thirdAction = UIAlertAction(title: "Third Layout", style: .default, handler: { _ in
            self.collectionView.collectionViewLayout = self.generateFullLayout()
            self.collectionView.reloadData()
        })
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(thirdAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return makeupList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MakeupCollectionViewCell
        let makeup = makeupList[indexPath.row]
        cell?.setupView(makeup)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let makeup = makeupList[indexPath.row]
        let detailVC = DetailViewController.init()
        detailVC.makeup = makeup
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}

