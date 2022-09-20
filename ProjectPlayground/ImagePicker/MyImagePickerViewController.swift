//
//  MyImagePickerViewController.swift
//  ProjectPlayground
//
//  Created by Jeremy Endratno on 4/26/22.
//

import UIKit
import Photos

class MyImagePickerViewController: UIViewController {
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var images: [(image: UIImage, isSelected: Bool)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        requestAccess()
        collectionSetup()
    }
    
    func collectionSetup() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    func requestAccess() {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    self.getPhotos()
                }
            case .denied, .restricted:
                print("Access is not allowed")
            case .notDetermined:
                print("Access is not determined")
            case .limited:
                print("Access is limited")
            @unknown default:
                print("Access is unknown")
            }
        }
    }
    
    func getPhotos() {
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        if results.count > 0 {
            for i in 0 ..< results.count {
                let asset = results.object(at: i)
                let size = CGSize(width: 700, height: 700)
                
                manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { (image, _) in
                    if let image = image {
                        self.images.append((image: image, isSelected: false))
                        self.photosCollectionView.reloadData()
                    }
                }
            }
        } 
    }
}

extension MyImagePickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        cell.photoImageView.image = images[indexPath.row].image
        
        if images[indexPath.row].isSelected {
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.yellow.cgColor
        } else {
            cell.layer.borderWidth = 0
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (UIScreen.main.bounds.width - 50) / 2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if images[indexPath.row].isSelected {
            images[indexPath.row].isSelected = false
        } else {
            images[indexPath.row].isSelected = true
        }
        
        photosCollectionView.reloadData()
    }
}
