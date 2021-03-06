//
//  PlayerViewController.swift
//  EPIC
//
//  Created by Francisco Lopez on 14/06/2022.
//

import UIKit
import AVKit
import Kingfisher

class PlayerViewController: UIViewController {

    
    @IBOutlet weak var sliderCollection: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    
    var photosArr = [PhotoList]()
    var theIndex: Int?
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageView.numberOfPages = photosArr.count
        pageView.currentPage = 0
        sliderCollection.delegate = self
        sliderCollection.dataSource = self
        self.sliderCollection.reloadData()
        setupTapGesture()
        DispatchQueue.main.async {
            self.startTimer()
        }
    }

    func setupTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapCollectionView(_:)))
        sliderCollection.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapCollectionView(_ sender: UITapGestureRecognizer) {
        if timer.isValid {
            timer.invalidate()
        } else {
            startTimer()
        }
    }

    func startTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
    }
    
   @objc func changeImage() {
       if counter < photosArr.count {
           let index = IndexPath.init(item: counter, section: 0)
           self.sliderCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
           pageView.currentPage = counter
           theIndex = index.row
           counter += 1
       } else {
           counter = 0
           let index = IndexPath.init(item: counter, section: 0)
           self.sliderCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
           pageView.currentPage = counter
           counter = 1
       }
   }
}

extension PlayerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
        let photo = photosArr[indexPath.row]
        cell.setup(sliderModel: photo)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in sliderCollection.visibleCells{
            let indexPath = sliderCollection.indexPath(for: cell)
            counter = indexPath!.row
            pageView.currentPage = counter
        }
    }
}

extension PlayerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollection.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
