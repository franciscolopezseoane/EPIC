//
//  DateView.swift
//  EPIC
//
//  Created by Francisco Lopez on 14/06/2022.
//

import Foundation
import UIKit

protocol DateView: NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func ShowData(_ dates: [DateResult])
}

protocol PhotoListView: NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func ShowData(_ photos: [PhotoResult])
}

protocol PhotoView: NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func ShowData(_ photo: Any)
}
