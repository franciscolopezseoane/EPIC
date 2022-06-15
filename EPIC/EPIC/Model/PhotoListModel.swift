//
//  PhotoListModel.swift
//  EPIC
//
//  Created by Francisco Lopez on 14/06/2022.
//

import Foundation

    // MARK: - WelcomeElement
struct PhotoResult: Codable {
    let identifier, caption, date: String
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case identifier, caption, image, date
    }
}

typealias photoResult = [PhotoResult]


struct PhotoList: Codable {
    let identifier: String
    let date: String
}

typealias photoList = [PhotoList]
