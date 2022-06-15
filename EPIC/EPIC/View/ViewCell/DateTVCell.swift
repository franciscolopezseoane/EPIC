//
//  DateTVCell.swift
//  EPIC
//
//  Created by Francisco Lopez on 14/06/2022.
//

import UIKit

class DateTVCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(dateCell: MainResult){
        dateLbl.text = dateCell.date
    }
}
