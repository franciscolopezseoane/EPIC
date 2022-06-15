//
//  DateObject.swift
//  EPIC
//
//  Created by Francisco Lopez on 14/06/2022.
//

import Foundation

struct DateResult: Codable {
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case date
    }
}
typealias dateResult = [DateResult]
