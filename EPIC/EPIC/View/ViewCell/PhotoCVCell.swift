//
//  PhotoCVCell.swift
//  EPIC
//
//  Created by Francisco Lopez on 14/06/2022.
//

import UIKit
import Kingfisher

class PhotoCVCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var myImgService = APIManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
            // Initialization code
    }
    
    func setup(photoModel: PhotoList){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        self.imageView?.kf.setImage(with: self.myImgService.getThumbnails(photoModel.date, photoModel.identifier), placeholder: UIImage(named: "placeHolder"))
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
    }
}

