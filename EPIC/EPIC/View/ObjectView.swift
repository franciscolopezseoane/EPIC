//
//  DateView.swift
//  EPIC
//
//  Created by Francisco Lopez on 14/06/2022.
//

import Foundation

protocol DateView: NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func ShowData(_ dates: [MainResult])
}
