//
//  ZoomingCollectionViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 9/12/22.
//

import UIKit

class ZoomingCollectionViewController: UIViewController {
    
    var colors: [UIColor] = []
    var viewedIndex = 5
    var startDragging = false
    
    @IBOutlet weak var collectionFlowLayout: CustomFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0 ..< 50 {
            colors.append(UIColor.random)
        }
         
        collectionViewSetup()
    }
}

extension ZoomingCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionViewSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ZoomingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.decelerationRate = .fast
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 150, bottom: 0, right: 150)
        collectionView.scrollToItem(at: IndexPath(row: 5, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ZoomingCollectionViewCell
        
        if indexPath.row == viewedIndex || startDragging {
            cell.setup(color: colors[indexPath.row % colors.count], isViewed: true)
        } else {
            cell.setup(color: colors[indexPath.row % colors.count], isViewed: false)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SizeStorage.screenWidth - 200, height: 300)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startDragging = true
        collectionView.reloadData()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) { 
        if decelerate {
            return
        } else {
            startDragging = false
            let offset = collectionView.contentOffset
            let point = CGPoint(x: offset.x + SizeStorage.halfScreenWidth, y: collectionView.frame.height / 2)
            guard let index = collectionView.indexPathForItem(at: point) else { return }
            viewedIndex = index.row
            collectionView.reloadData()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        startDragging = false
        
        let offset = collectionView.contentOffset
        let point = CGPoint(x: offset.x + SizeStorage.halfScreenWidth, y: collectionView.frame.height / 2)
        guard let index = collectionView.indexPathForItem(at: point) else { return }
        viewedIndex = index.row
        collectionView.reloadData()
    }
}
