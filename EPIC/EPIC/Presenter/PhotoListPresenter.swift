//
//  PhotoListPresenter.swift
//  EPIC
//
//  Created by Francisco Lopez on 14/06/2022.
//

import Foundation

class PhotoListPresenter: NSObject {
    
    private let getPhotosService: APIManager
    weak private var photoView: PhotoListView?
    
    init(getService: APIManager){
        getPhotosService = getService
    }
    
    func attachView(view: PhotoListView){
        self.photoView = view
    }
    
    func deatachView(){
        photoView = nil
    }
    
    func getPhotostDate(query: String){
        photoView?.startLoading()
        self.getPhotosService.getPhotosFromDate(query) { (photos) in
            self.photoView?.ShowData(photos)
            self.photoView?.stopLoading()
        }
    }
}
