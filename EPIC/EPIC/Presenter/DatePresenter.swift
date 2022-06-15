//
//  DatePresenter.swift
//  EPIC
//
//  Created by Francisco Lopez on 14/06/2022.
//

import Foundation

class DatePresenter: NSObject {
    
    private let getDateService: APIManager
    weak private var dateView: DateView?
    
    init(getService: APIManager){
        getDateService = getService
    }
    
    func attachView(view: DateView){
        self.dateView = view
    }
    
    func deatachView(){
        dateView = nil
    }
    
    func getDatetList(){
        dateView?.startLoading()
        self.getDateService.getPhotos { (dates) in
            self.dateView?.ShowData(dates)
            self.dateView?.stopLoading()
        }
    }
}
