//
//  SnappingViewController2.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 1/10/22.
//

import UIKit

class SnappingViewController2: UIViewController {
    @IBOutlet weak var snapCollectionView: UICollectionView!
    
    let texts = ["One", "Two", "Three", "Four", "Five", "Six"]
    var contentOffset: CGFloat = 0
    var row = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCol()
    }
    
    func initCol() {
        snapCollectionView.delegate = self
        snapCollectionView.dataSource = self
        snapCollectionView.register(UINib(nibName: "SnapCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Snap")
        snapCollectionView.decelerationRate = .fast
    }
}

extension SnappingViewController2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        texts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = snapCollectionView.dequeueReusableCell(withReuseIdentifier: "Snap", for: indexPath) as! SnapCollectionViewCell
        cell.label1.text = texts[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if contentOffset > scrollView.contentOffset.y && contentOffset < scrollView.contentSize.height - scrollView.frame.height {
            row -= 1
            print(row)
            snapCollectionView.scrollToItem(at: IndexPath(row: row, section: 0), at: .centeredVertically, animated: true)
        } else if contentOffset < scrollView.contentOffset.y && scrollView.contentOffset.y > 0 {
            row += 1
            print(row)
            snapCollectionView.scrollToItem(at: IndexPath(row: row, section: 0), at: .centeredVertically, animated: true)
        }
        
        contentOffset = scrollView.contentOffset.y
    }

//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("decelerate")
//        if contentOffset > scrollView.contentOffset.y && contentOffset < scrollView.contentSize.height - scrollView.frame.height {
//            row += 1
//            print(row)
//            snapCollectionView.scrollToItem(at: IndexPath(row: row, section: 0), at: .centeredVertically, animated: true)
//        } else if contentOffset < scrollView.contentOffset.y && scrollView.contentOffset.y > 0 {
//            row -= 1
//            print(row)
//            snapCollectionView.scrollToItem(at: IndexPath(row: row, section: 0), at: .centeredVertically, animated: true)
//        }
//        contentOffset = scrollView.contentOffset.y
//    }
}

extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = .fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.y + (self.bounds.size.height / 2))
        print("visibleCenterPositionOfScrollView: \(visibleCenterPositionOfScrollView)")
        var closestCellIndex = -1
        var closestDistance: Float = 0
        for i in 0 ..< self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellHeight = cell.bounds.size.height
            let cellCenter = Float(cell.frame.origin.y + cellHeight / 2)
            print("cell center \(i): \(cellCenter)")

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            print("distance \(i): \(distance)")
            print("clostest distance \(i): \(closestDistance)")
            if distance > closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredVertically, animated: true)
        }
        
        print("===================")
    }
}
