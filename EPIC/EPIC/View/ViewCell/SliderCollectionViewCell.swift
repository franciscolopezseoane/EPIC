//
//  SliderCollectionViewCell.swift
//  EPIC
//
//  Created by Francisco Lopez on 15/06/2022.
//

import UIKit
import Kingfisher

class SliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sliderImageView: UIImageView!
    
    var myImgService = APIManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
            // Initialization code
    }
    
    func setup(sliderModel: PhotoList){
        self.sliderImageView?.kf.setImage(with: self.myImgService.getThumbnails(sliderModel.date, sliderModel.identifier), placeholder: UIImage(named: "placeHolder"))
    }
}
