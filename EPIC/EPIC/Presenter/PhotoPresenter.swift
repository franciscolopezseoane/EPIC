//
//  PhotoPresenter.swift
//  EPIC
//
//  Created by Francisco Lopez on 15/06/2022.
//

import Foundation
import UIKit

class PhotoPresenter: NSObject {
    
    private let getPhoto: APIManager
    weak private var photoView: PhotoView?
    
    init(getService: APIManager){
        getPhoto = getService
    }
    
    func attachView(view: PhotoView){
        self.photoView = view
    }
    
    func deatachView(){
        photoView = nil
    }
    
    func getPhoto(_ date: String, _ query: String){
        photoView?.startLoading()
        self.getPhoto.getResPhoto(date, query) { data, response, error in
            guard let data = data, error == nil else { return }
            self.photoView?.ShowData(UIImage(data: data)!)
            self.photoView?.stopLoading()
        }
    }
}
