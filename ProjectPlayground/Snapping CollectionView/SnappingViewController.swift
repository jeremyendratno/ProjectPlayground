//
//  SnappingViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 1/10/22.
//

import UIKit
import Player

class SnappingViewController: UIViewController {
    @IBOutlet weak var snapCollectionView: UICollectionView!
    let texts = ["One", "Two", "Three", "Four", "Five", "Six"]
    let urls = [
        "https://firebasestorage.googleapis.com/v0/b/brighton-debc9/o/vid%2F2998%2F657038eb-eea8-490c-8a97-935fa988d9cf.m3u8?alt=media",
        "https://firebasestorage.googleapis.com/v0/b/brighton-debc9/o/vid%2F2996%2Fb2e24972-5f40-4787-b11f-42470d0562af.m3u8?alt=media",
        "https://firebasestorage.googleapis.com/v0/b/brighton-debc9/o/vid%2F2991%2F4f762dcf-458c-4b12-93e1-4808597f834c.m3u8?alt=media",
        "https://firebasestorage.googleapis.com/v0/b/brighton-debc9/o/vid%2F2990%2FMP4_20220313_203251.m3u8?alt=media",
        "https://firebasestorage.googleapis.com/v0/b/brighton-debc9/o/vid%2F2988%2F950b2b34-7ea6-49c3-a6c7-1d9c6195a85f.m3u8?alt=media",
        "https://firebasestorage.googleapis.com/v0/b/brighton-debc9/o/vid%2F2987%2F309e93b9-a6a2-4b8b-a2cb-77a383de7862.m3u8?alt=media"
    ]
    
    let currentPlayer = Player()
    let beforePlayer = Player()
    let afterPlayer = Player()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCol()
        swipe()
    }
    
    func initCol() {
        snapCollectionView.delegate = self
        snapCollectionView.dataSource = self
        snapCollectionView.register(UINib(nibName: "SnapCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Snap")
        snapCollectionView.decelerationRate = .fast
    }
    
    func swipe() {
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipesUp(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipesDown(_:)))
                
        upSwipe.direction = .up
        downSwipe.direction = .down

        snapCollectionView.addGestureRecognizer(upSwipe)
        snapCollectionView.addGestureRecognizer(downSwipe)
    }
    
    @objc func handleSwipesUp(_: UICollectionView) {
        let indexRow = snapCollectionView.indexPathsForVisibleItems[0].row
        if  indexRow < texts.count - 1 {
            snapCollectionView.scrollToItem(at: IndexPath(row: indexRow + 1, section: 0), at: .centeredVertically, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let cell = self.snapCollectionView.cellForItem(at: IndexPath(row: indexRow + 1, section: 0)) as! SnapCollectionViewCell
                cell.label1.text = "Looked"
                let cellBefore = self.snapCollectionView.cellForItem(at: IndexPath(row: indexRow, section: 0)) as! SnapCollectionViewCell
                cellBefore.label1.text = self.texts[indexRow]
            }
            
        }
    }
    
    @objc func handleSwipesDown(_: UICollectionView) {
        let indexRow = snapCollectionView.indexPathsForVisibleItems[0].row
        if  indexRow > 0 {
            snapCollectionView.scrollToItem(at: IndexPath(row: indexRow - 1, section: 0), at: .centeredVertically, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let cell = self.snapCollectionView.cellForItem(at: IndexPath(row: indexRow - 1, section: 0)) as! SnapCollectionViewCell
                cell.label1.text = "Looked"
                let cellBefore = self.snapCollectionView.cellForItem(at: IndexPath(row: indexRow, section: 0)) as! SnapCollectionViewCell
                cellBefore.label1.text = self.texts[indexRow]
            }
        }
    }
}

extension SnappingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
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
}
